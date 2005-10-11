Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751432AbVJKJJa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751432AbVJKJJa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 05:09:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751433AbVJKJJa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 05:09:30 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:36746 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751432AbVJKJJ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 05:09:29 -0400
Date: Tue, 11 Oct 2005 05:09:24 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc3-rt12
In-Reply-To: <20051011080151.GA27401@elte.hu>
Message-ID: <Pine.LNX.4.58.0510110507240.1044@localhost.localdomain>
References: <5bdc1c8b0510041158m3620f5dcy2dafda545ad3cd5e@mail.gmail.com>
 <1128458707.13057.68.camel@tglx.tec.linutronix.de>
 <5bdc1c8b0510041349g1a4f2484qd17a11812c8ccac3@mail.gmail.com>
 <20051005105605.GA27075@elte.hu> <5bdc1c8b0510051014q3bb02d5bl80d2c88cc884fe35@mail.gmail.com>
 <Pine.LNX.4.58.0510060403210.28535@localhost.localdomain> <20051006081055.GA20491@elte.hu>
 <Pine.LNX.4.58.0510060433010.28535@localhost.localdomain> <20051006084920.GB22397@elte.hu>
 <Pine.LNX.4.58.0510061122530.418@localhost.localdomain> <20051011080151.GA27401@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ingo,  I keep getting a "changed soft IRQ-flags" on sysrq-b.  Would the
following patch be appropriate?

-- Steve

Index: linux-rt-quilt/drivers/char/sysrq.c
===================================================================
--- linux-rt-quilt.orig/drivers/char/sysrq.c	2005-10-07 15:57:57.000000000 -0400
+++ linux-rt-quilt/drivers/char/sysrq.c	2005-10-11 05:04:38.000000000 -0400
@@ -114,7 +114,7 @@
 static void sysrq_handle_reboot(int key, struct pt_regs *pt_regs,
 				struct tty_struct *tty)
 {
-	local_irq_enable();
+	raw_local_irq_enable();
 	emergency_restart();
 }


