Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261564AbTEHQWD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 12:22:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbTEHQWD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 12:22:03 -0400
Received: from air-2.osdl.org ([65.172.181.6]:6619 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261564AbTEHQWB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 12:22:01 -0400
Date: Thu, 8 May 2003 09:30:58 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: davem@redhat.com, alan@lxorguk.ukuu.org.uk, haveblue@us.ibm.com,
       akpm@digeo.com, rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: The magical mystical changing ethernet interface order
Message-Id: <20030508093058.3bf3b6ba.rddunlap@osdl.org>
In-Reply-To: <3EBA854D.1030101@pobox.com>
References: <3EB98878.5060607@us.ibm.com>
	<1052395526.23259.0.camel@rth.ninka.net>
	<1052405730.10038.51.camel@dhcp22.swansea.linux.org.uk>
	<20030508.075438.52189319.davem@redhat.com>
	<3EBA854D.1030101@pobox.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 08 May 2003 12:26:53 -0400 Jeff Garzik <jgarzik@pobox.com> wrote:

| David S. Miller wrote:
| >    From: Alan Cox <alan@lxorguk.ukuu.org.uk>
| >    Date: 08 May 2003 15:55:31 +0100
| > 
| >    Unfortunately for the ISA driver code we *have* to rely on link
| >    order or rip out the __init stuff and use Space.c type hacks.
| >    
| > I do no argue that needing an invocation order is bogus.
| > I merely disagree with the way we're trying to achieve it.
| > 
| > You don't need Space.c magic, the linker in binutils has mechanisms by
| > which this can be accomplished and we already use this in 2.5.x
| > 
| > Have a peek at __define_initcall($NUM,fn), imagine it with one more
| > argument $PRIO.  It might look like this:
| > 
| > #define __define_initcall(level,prio,fn) \
| >         static initcall_t __initcall_##fn __attribute__
| >         ((unused,__section__ ("\.initcall" level "." prio ".init"))) = fn
| > 
| > Use the 'prio' number to define the ordering.  The default for
| > modules that don't care about relative ordering within a class
| > use a value like "9999" or something like that.
| 
| 
| Linus has traditionally resisted this, and pushed for the 
| link-order-defines-init-order bit.
| 
| However, that was years ago.  Patrick Mochel added the current 
| seven-levels-of-initcall, which is where the referenced 
| __define_initcall originated.
| 
| I agree with you, and would prefer to move away from any dependence on 
| link order...

I don't care what the exact implementation is, but anything except
depending on link (tools) order is better than now IMO.

--
~Randy
