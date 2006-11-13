Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753523AbWKMVyv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753523AbWKMVyv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 16:54:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755356AbWKMVyu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 16:54:50 -0500
Received: from smtp.osdl.org ([65.172.181.4]:11990 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1753523AbWKMVyt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 16:54:49 -0500
Date: Mon, 13 Nov 2006 13:54:05 -0800
From: Andrew Morton <akpm@osdl.org>
To: Romano Giannetti <romanol@upcomillas.es>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>,
       Pete Zaitcev <zaitcev@redhat.com>, linux-pcmcia@lists.infradead.org,
       fabrice@bellet.info, linux-kernel@vger.kernel.org
Subject: Re: pcmcia: patch to fix pccard_store_cis Was:
 [SOLUTION/HACK/PUZZLED] pcmcia modem only works with cardmgr in recent
 2.6.15 kernel.
Message-Id: <20061113135405.4e7874ac.akpm@osdl.org>
In-Reply-To: <1163412159.11397.11.camel@localhost>
References: <20061001122107.9260aa5d.zaitcev@redhat.com>
	<20061002003138.GB16938@isilmar.linta.de>
	<1159794094.8246.2.camel@localhost>
	<20061103160247.GB11160@dominikbrodowski.de>
	<1163412159.11397.11.camel@localhost>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Nov 2006 11:02:39 +0100
Romano Giannetti <romanol@upcomillas.es> wrote:

> 
> On Fri, 2006-11-03 at 11:02 -0500, Dominik Brodowski wrote:
> > Does it work again (after re-copying the cis file to /lib/firmware)
> > when
> > you use this patch?
> > 
> > Thanks,
> >         Dominik
> > 
> > >From 4bb59569454f09e8bfc3a0f7bbdef46ccc7a51e0 Mon Sep 17 00:00:00
> > 2001
> > From: Dominik Brodowski <linux@dominikbrodowski.net>
> > Date: Fri, 3 Nov 2006 10:54:00 -0500
> > Subject: [PATCH] pcmcia: start over after CIS override
> > 
> > When overriding the CIS, re-start the configuration of the card from
> > scratch. Reported and debugged by Fabrice Bellet
> > <fabrice@bellet.info> 
> 
> Mr Dominik, all,
> 
> 	I tried your patch on top of the kernel 2.6.17.13 that came with ubuntu
> edgy (and had sufficient trouble with it, I do not know if I'll be able
> to try with a recent kernel.). This message is in copy to akpm which
> asked me a report on the same problem.
> 
> I applied your patch and this one: 
> http://lkml.org/lkml/2006/10/1/179
> 
> but the kernel continues to ignore the second function of my card.
> Moreover, now the modem does not work even with the dear old cardmgr:
> 
> [17179741.804000] pcmcia: registering new device pcmcia1.1
> [17179741.844000] 1.1: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
> [17179741.992000] setup_irq: irq handler mismatch
> [17179741.992000]  <c0139e82> setup_irq+0x102/0x110  <c0223250> serial8250_interrupt+0x0/0xf0
> [17179741.992000]  <c0139f29> request_irq+0x99/0xb0  <c0223195> serial8250_startup+0x415/0x440
> [17179741.992000]  <c021ec58> uart_startup+0x48/0x130  <c021fa3f> uart_open+0xbf/0x410
> [17179741.992000]  <c0160a13> cdev_get+0x23/0x60  <c020eba1> tty_open+0x161/0x310
> [17179741.992000]  <c0160ace> chrdev_open+0x6e/0x140  <c0160a60> chrdev_open+0x0/0x140
> [17179741.992000]  <c0156924> __dentry_open+0xb4/0x1e0  <c0156b05> nameidata_to_filp+0x35/0x40
> [17179741.992000]  <c0156b60> do_filp_open+0x50/0x60  <c0156805> get_unused_fd+0x45/0xb0
> [17179741.992000]  <c0156bba> do_sys_open+0x4a/0xe0  <c0156c8c> sys_open+0x1c/0x20
> [17179741.992000]  <c0102dbb> sysenter_past_esp+0x54/0x79
> 
> Mr Morton, do you still think I should open a bug in bugzilla? Even if I
> have not tested a newer kernel? It seems to me that nothing has changed
> over there, and this _is_ a regression (from 2.6.13, even).
> 

It doesn't sound like these problems will be fixed in the short term so
yes, please let's get these into bugzilla so at least they don't get
forgotten about and we have contact information filed away against
particular problems.  One record per bug, please.

I do have a debugging patch here which will give us better info about the
above IRQ-handler conflict.  I'll probably push that into 2.6.19 - we seem
to be getting a few of these lately.


> 
> PS: can anyone point me to a tutorial on howto install a new kernael
> easily on ubuntu? The procedure they point to (creating deb package,
> installing, etc) are quite cumbersome. Anyway, I will try. 

Well it sounds like fixing these bugs is a long-term project.  So it would
be fine if you were to wait until Ubuntu have a 2.6.19-based kernel
available.

But otoh I don't think Ubuntu release bleeding-edge kernel packages, so
that may be quite some time in the future.  So if you're able to work out
how to build and install a kernel.org kernel then that would help things
along a bit.  
