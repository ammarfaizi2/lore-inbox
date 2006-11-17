Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755945AbWKQVma@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755945AbWKQVma (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 16:42:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755947AbWKQVma
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 16:42:30 -0500
Received: from mail.ggsys.net ([69.26.161.131]:20145 "EHLO mail.ggsys.net")
	by vger.kernel.org with ESMTP id S1755945AbWKQVma (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 16:42:30 -0500
Subject: Re: qstor driver -> irq 193: nobody cared
From: Alberto Alonso <alberto@ggsys.net>
To: Mark Lord <lkml@rtr.ca>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <455C6D48.8040501@rtr.ca>
References: <1162576973.3967.10.camel@w100>  <454CDE6E.5000507@rtr.ca>
	 <1163180185.28843.13.camel@w100>  <4556AC74.3010000@rtr.ca>
	 <1163363479.3423.8.camel@w100>  <45588132.9090200@rtr.ca>
	 <1163479852.3340.9.camel@w100>  <4559F2EE.7080309@rtr.ca>
	 <1163528258.3340.23.camel@w100>  <455A09A5.2020200@rtr.ca>
	 <1163658952.3416.13.camel@w100>  <455C6D48.8040501@rtr.ca>
Content-Type: text/plain
Organization: Global Gate Systems LLC.
Date: Fri, 17 Nov 2006 15:42:22 -0600
Message-Id: <1163799742.3484.12.camel@w100>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI: trying with just the first patch didn't work. I got
the usual:

irq 185: nobody cared (try booting with the "irqpoll" option)
 <c013e19a> __report_bad_irq+0x2a/0xa0  <c013d970> handle_IRQ_event
+0x30/0x70
 <c013e2b0> note_interrupt+0x80/0xf0  <c013da8c> __do_IRQ+0xdc/0xf0
 <c0105799> do_IRQ+0x19/0x30  <c010391a> common_interrupt+0x1a/0x20
 <c0100d91> default_idle+0x41/0x70  <c0100e60> cpu_idle+0x80/0x90
handlers:
[<c0301300>] (qs_intr+0x0/0x230)
Disabling IRQ #185

Interestingly enough this is the first time I see it outside
of irq 193, not that it matter though.

I am going to try now with the second patch instead.

Alberto


On Thu, 2006-11-16 at 08:53 -0500, Mark Lord wrote:
> Alberto Alonso wrote:
> > Sorry for the long delay, I've been called on too
> > many issues at work this week.
> > 
> > Anyway, the patch basically made the drives not usable.
> 
> Mmm.. Okay, thanks for helping track this down.
> 
> It appears that this got broken when the ATA_TFLAG_POLLING
> got introduced into libata, replacing previous checks of ATA_NIEN.
> Or maybe even before that.  Not many of us have qstor cards!
> 
> Speaking of which, I'll dig my own qstor card out of mothballs soon,
> and work out a proper fix for it soon-ish.
> 
> In the meanwhile, could you take a clean kernel, and apply the first
> attached patch (qstor_spurious_1.patch), and see if it fixes things.
> 
> If not, then you can instead apply the second patch (qstor_spurious_kludge.patch)
> and your problems should disappear.  But I cannot actually push that rubbish
> upstream, so a "proper" fix will have to come later.
> 
> Cheers
-- 
Alberto Alonso                        Global Gate Systems LLC.
(512) 351-7233                        http://www.ggsys.net
Hardware, consulting, sysadmin, monitoring and remote backups

