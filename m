Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262439AbTHBMpl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 08:45:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262577AbTHBMpk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 08:45:40 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:60424 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S262439AbTHBMpj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 08:45:39 -0400
Date: Sat, 2 Aug 2003 14:45:36 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Erik Andersen <andersen@codepoet.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: ide-disk.c rev 1.13 killed CONFIG_IDEDISK_STROKE
Message-ID: <20030802124536.GB3689@win.tue.nl>
References: <20030802084205.GA2033@codepoet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030802084205.GA2033@codepoet.org>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 02, 2003 at 02:42:05AM -0600, Erik Andersen wrote:

> Anybody know what the intent of this IDE_STROKE_LIMIT macro is?
> I ask since it completely breaks CONFIG_IDEDISK_STROKE and I can't see
> any reason for it being there.  It looks to me like it just needs to be
> ripped right back out.

I agree entirely.


> I have created the following patch which makes this option work
> as expected once again in 2.4.x.

Will you also submit the corresponding 2.6 patch?


> #define IDE_STROKE_LIMIT	(32000*1024*2)

I can guess where this limit came from.
The most common way people meet this situation is when they have a
large disk, so large that their BIOS faints when seeing it, so that
they have to use a clipping jumper to fake a smaller disk. Such
jumpers usually clip to about 32 GB (namely 66055248 sectors).
So 65536000 is a lower limit to what one sees with clips.

Maybe it is intended to protect against old disks that do not
understand these new commands. Andre? Bart? Alan?


> +	    printk(KERN_INFO "%s: Host Protected Area detected.\n"

This text might lead to some confusion: as just remarked, usually
we have a clipping jumper, not a proper Host Protected Area.


#ifdef CONFIG_IDEDISK_STROKE

I am also unhappy about the fact that this is a configuration option,
one of the zillion we have. A boot parameter would be a better choice.

Does anyone know about disks that get unhappy if we just do this
stuff unconditionally (or, to be more precise, do it when the IDENTIFY
output says we can) ?
Maybe not even a boot parameter is needed and we can do the right thing
automatically.


Andries

