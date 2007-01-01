Return-Path: <linux-kernel-owner+w=401wt.eu-S932895AbXAAEVV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932895AbXAAEVV (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 23:21:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932896AbXAAEVV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 23:21:21 -0500
Received: from gate.crashing.org ([63.228.1.57]:47950 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932895AbXAAEVV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 23:21:21 -0500
In-Reply-To: <459714A6.4000406@firmworks.com>
References: <459714A6.4000406@firmworks.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <6288db25c3465ebca5af7760fe38d954@kernel.crashing.org>
Content-Transfer-Encoding: 7bit
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       "OLPC Developer's List" <devel@laptop.org>, Jim Gettys <jg@laptop.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Open Firmware device tree virtual filesystem
Date: Mon, 1 Jan 2007 05:21:48 +0100
To: Mitch Bradley <wmb@firmworks.com>
X-Mailer: Apple Mail (2.623)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some comments, mostly coding style:

> - 0xb0 - 0x13f		Free. Add more parameters here if you really need them.
> + 0xb0   16 bytes	Open Firmware information (magic, version, callback, 
> idt)

Is there an OF ISA binding for x86 somewhere?  And don't
point me to the source code, I'd like to see an actual
reference doc ;-)

> +//	printk(KERN_WARNING "CALLOFW: %s\n", name);

Please remove disabled code.  And don't use // comments
at all please.

> +	if (call_firmware == NULL)
> +		return (-1);

No parentheses around return value.

> +	argarray[0] = (int)name;

This would warn on 64-bit systems, better write it as
(u32)(u64)name (and make sure that "name" is somewhere
in the low 4GB of memory).  This doesn't handle 64-bit
client interface either btw.

> +	while (numargs--) {
> +		argarray[argnum++] = va_arg(ap, int);
> +	}

No braces around single statements.

> +#undef	MAXARGS

Why this #undef?  That's nasty style, and this is at the
end of file anyway.

> +#if 0

Better use a normal comment.

> +Here are call templates for all the standard OFW client services.

You missed "instance-to-interposed-path" (standard, although
not required).

> + * By Mitch Bradley (wmb@firmworks.com), with assistance from David 
> Kahn.
> + * Most of the basic virtual file system structure was taken from a
> + * "promfs" example written by Arnd Bergmann.  + *

My mailer messed up this line, that means you have trailing
spaces here :-)

> +	    +	if (root == 0) {

Same here.

> +++ b/include/asm-i386/callofw.h
> @@ -0,0 +1,22 @@
> +#ifndef _I386_PROM_H
> +#define _I386_PROM_H

Better make the #define correspond to the file name.


Segher

