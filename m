Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261666AbTEHQOR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 12:14:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261743AbTEHQOR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 12:14:17 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:43179 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261666AbTEHQOQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 12:14:16 -0400
Message-ID: <3EBA854D.1030101@pobox.com>
Date: Thu, 08 May 2003 12:26:53 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: alan@lxorguk.ukuu.org.uk, haveblue@us.ibm.com, akpm@digeo.com,
       rmk@arm.linux.org.uk, rddunlap@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: The magical mystical changing ethernet interface order
References: <3EB98878.5060607@us.ibm.com>	<1052395526.23259.0.camel@rth.ninka.net>	<1052405730.10038.51.camel@dhcp22.swansea.linux.org.uk> <20030508.075438.52189319.davem@redhat.com>
In-Reply-To: <20030508.075438.52189319.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
>    From: Alan Cox <alan@lxorguk.ukuu.org.uk>
>    Date: 08 May 2003 15:55:31 +0100
> 
>    Unfortunately for the ISA driver code we *have* to rely on link
>    order or rip out the __init stuff and use Space.c type hacks.
>    
> I do no argue that needing an invocation order is bogus.
> I merely disagree with the way we're trying to achieve it.
> 
> You don't need Space.c magic, the linker in binutils has mechanisms by
> which this can be accomplished and we already use this in 2.5.x
> 
> Have a peek at __define_initcall($NUM,fn), imagine it with one more
> argument $PRIO.  It might look like this:
> 
> #define __define_initcall(level,prio,fn) \
>         static initcall_t __initcall_##fn __attribute__
>         ((unused,__section__ ("\.initcall" level "." prio ".init"))) = fn
> 
> Use the 'prio' number to define the ordering.  The default for
> modules that don't care about relative ordering within a class
> use a value like "9999" or something like that.


Linus has traditionally resisted this, and pushed for the 
link-order-defines-init-order bit.

However, that was years ago.  Patrick Mochel added the current 
seven-levels-of-initcall, which is where the referenced 
__define_initcall originated.

I agree with you, and would prefer to move away from any dependence on 
link order...

	Jeff


