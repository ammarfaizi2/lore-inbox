Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261821AbTJ2CUL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 21:20:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261845AbTJ2CUL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 21:20:11 -0500
Received: from 205-158-62-67.outblaze.com ([205.158.62.67]:16838 "EHLO
	spf13.us4.outblaze.com") by vger.kernel.org with ESMTP
	id S261821AbTJ2CUA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 21:20:00 -0500
Message-ID: <20031029021944.86876.qmail@mail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "David Liontooth" <liontooth@post.com>
To: linux-kernel@vger.kernel.org
Cc: "Manfred Spraul" <manfred@colorfullife.com>
Date: Tue, 28 Oct 2003 21:19:43 -0500
Subject: Re: [2.6.0-test-9] natsemi oops
X-Originating-Ip: 128.97.184.97
X-Originating-Server: ws1-1.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks Manfred -- I left out ipx and everything is working great so far. 
So count that as an ipx problem instead.

Cheers,
David

Manfred Sproul wrote:

[netdev added to cc list: it looks like a module refcount bug with ipx]

David Liontooth wrote:

>The natsemi oops is triggered in 2.6.0-test9 too.
>
>kernel BUG at include/linux/module.h:296
>
>
That's BUG_ON(module_refcount(module) == 0) in __module_get. I doubt
that the natsemi driver has anything to do with the bug, it looks like a
bug in the ipx core.


----- Original Message -----
From: "David Liontooth"

> 
> The natsemi oops is triggered in 2.6.0-test9 too. 
> 
> kernel BUG at include/linux/module.h:296
> 
> Everything freezes. 
> 
> Am I the only one to get this? 
> 
> I don't know when it started, but 2.5.69 has no problems.
> 
> Cheers,
> David
> 
> 
> ----- Original Message -----
> From: "David Liontooth"
> Subject: Re: [2.6.0-test-7] natsemi oops
> 
> > 
> > Correction: I get the oops also when natsemi is compiled as a module. 
> > It is triggered not when the module is loaded, but when it is used 
> > the first time. Oops (some fragments below) followed by a total freeze;
> > nothing gets logged.
> > 
> > Is this a known problem? 
> > 
> > Is there a workaround?
> > 
> > Cheers,
> > David
> > 
> > 
> > ----- Original Message -----
> > From: David Liontooth
> > Subject: [2.6.0-test-7] natsemi oops
> > 
> > > 
> > > The 2.6.0-test-7 boots fine and works great -- until I plug
> > > in the ethernet cable. Within a second I get an oops and
> > > everything freezes. Booting with "acpi=off" makes no difference.
> > > If I boot with the ethernet cable plugged in, I get to the 
> > > login prompt, and it oopses within a second. If I time it right,
> > > I can log into the machine remotely for one second before it 
> > > oopses (so the natsemi driver is working). Very reproducible! 
> > > /proc/kmsg is empty. 
> > > 
> > > If I compile natsemi as a module, I don't get the oops. 
> > > However, now the driver is not working -- I can't ping out.
> > > Everything works fine in 2.5.69, which I've been running
> > > since early July.
> > > 
> > > Here's some of the oops, taken by hand:
> > > 
> > > Process swapper (pid: 0, threadinfo=c042a000 task c03a47a0)
> > > 
> > > Stack
> > > 
> > > Call trace:
> > > 
> > > ipxitf_auto_create
> > > ipx_rcv
> > > netif_receive_skb
> > > process_backlog
> > > net_rx_action
> > > do_softirq
> > > do_IRQ
> > > _stext
> > > common_interrupt
> > > acpi_processor_idle
> > > cpu_idle
> > > start_kernel
> > > unknown_bootoption
> > > 
> > > Kernel panic: Fatal exception in interrupt
> > > In interrupt handler -- not syncing
> > > 
> > > Configuration, lspci, and dmesg attached.
> > > 
> > > Cheers,
> > > David
> > > 
> > > 
> > > 
> > << config-2.6.0-test7-3 >>
> > << dmesg-2.6.0-test7-7 >>
> > << lspci-2.6.0-test7 >>
> > 
> > -- 
-- 
__________________________________________________________
Sign-up for your own personalized E-mail at Mail.com
http://www.mail.com/?sr=signup

CareerBuilder.com has over 400,000 jobs. Be smarter about your job search
http://corp.mail.com/careers

