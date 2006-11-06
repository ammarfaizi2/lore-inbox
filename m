Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423333AbWKFEEj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423333AbWKFEEj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 23:04:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423457AbWKFEEi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 23:04:38 -0500
Received: from mail.ggsys.net ([69.26.161.131]:43724 "EHLO mail.ggsys.net")
	by vger.kernel.org with ESMTP id S1423333AbWKFEEi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 23:04:38 -0500
Subject: Re: qstor driver -> irq 193: nobody cared
From: Alberto Alonso <alberto@ggsys.net>
To: Mark Lord <lkml@rtr.ca>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <454CDE6E.5000507@rtr.ca>
References: <1162576973.3967.10.camel@w100>  <454CDE6E.5000507@rtr.ca>
Content-Type: text/plain
Organization: Global Gate Systems LLC.
Date: Sun, 05 Nov 2006 22:04:31 -0600
Message-Id: <1162785871.5520.20.camel@w100>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have patched the system. I'll let you know if I get the
same problem. Since I can't reproduce it on demand I may not see
the problem for months. I don't know what happened the other day
when it just started to happen repeatedly, I haven't had the issue
since.

Thanks,

Alberto


On Sat, 2006-11-04 at 13:39 -0500, Mark Lord wrote:
> Alberto Alonso wrote:
> > I have a Pacific Digital qstor card on irq 193. I am using kernel
> > 2.6.17.13 SMP
> > 
> > The error happens every now and then. I have not been able to
> > figure out any triggers and I can not reproduce it on demand. Today
> > it happened 3 times within a 40 minutes period. 
> > 
> > All disks connected to the card are disabled and I can't do anything
> > other than a reboot to get them back.
> > 
> > It is reported as follows:
> > 
> > irq 193: nobody cared (try booting with the "irqpoll" option)
> >  <c013e19a> __report_bad_irq+0x2a/0xa0  <c013d970> handle_IRQ_event
> > +0x30/0x70
> >  <c013e2b0> note_interrupt+0x80/0xf0  <c013da8c> __do_IRQ+0xdc/0xf0
> >  <c0105799> do_IRQ+0x19/0x30  <c010391a> common_interrupt+0x1a/0x20
> >  <c0100d91> default_idle+0x41/0x70  <c0100e60> cpu_idle+0x80/0x90
> >  <c046699d> start_kernel+0x18d/0x1d0  <c0466330> unknown_bootoption
> > +0x0/0x1d0
> > handlers:
> > [<c0301300>] (qs_intr+0x0/0x220)
> > Disabling IRQ #193
> 
> What other devices are routed to that same interrupt line?
> 
> The sata_qstor driver is very rigorous in acknowledging *only* it's own
> interrupts, to prevent other devices sharing the same IRQ from losing theirs.
> 
> Mmm.. We could apply a bit of fuzzy tolerance for the odd glitch.
> Try this patch (attached) and report back.
> 
> Thanks.
> 
> 
-- 
Alberto Alonso                        Global Gate Systems LLC.
(512) 351-7233                        http://www.ggsys.net
Hardware, consulting, sysadmin, monitoring and remote backups

