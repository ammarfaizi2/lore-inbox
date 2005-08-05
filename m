Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262918AbVHEIPF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262918AbVHEIPF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 04:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262915AbVHEIPE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 04:15:04 -0400
Received: from mx1.elte.hu ([157.181.1.137]:10389 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262921AbVHEIM4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 04:12:56 -0400
Date: Fri, 5 Aug 2005 10:13:24 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Chuck Harding <charding@llnl.gov>
Cc: Linux Kernel Discussion List <linux-kernel@vger.kernel.org>
Subject: Re: Oops when rebooting 2.6.13-rc4-RT-V0.7.52-*
Message-ID: <20050805081324.GC6409@elte.hu>
References: <Pine.LNX.4.63.0508041430140.14107@ghostwheel.llnl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0508041430140.14107@ghostwheel.llnl.gov>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Chuck Harding <charding@llnl.gov> wrote:

> couldn't see the beginning of the oops but at the end was
> Init: no more processes left in this run level
> and have to power cycle to be able to boot. I tried vanilla -rc4, -rc5
> and -rc4-mm1 which all worked just fine. But all 3 of the -RT versions
> I have on hand (08,10,13) showed the same symptom.
> 
> This is my desktop system - Dell Optiplex GX-240 2GHz P4 1Gb SDRAM ATI 
> Radeon VE/7000 QY SB Live! Value. Dell FP2000 RHEL 4.0 KDE 3.3
> 
> I don't have serial console debugging capability here at work, so what 
> can I do to debug this? Thanks.

it's the first oops that matters. You could try to 'freeze' the system 
after printing the first stacktrace, via the patch below - but debugging 
boot-time crashes without logging support is a quite tedious process.

(maybe, if the crash happens after the ethernet card is detected, you 
could try netconsole logging.)

	Ingo

Index: linux/arch/i386/kernel/traps.c
===================================================================
--- linux.orig/arch/i386/kernel/traps.c
+++ linux/arch/i386/kernel/traps.c
@@ -170,6 +170,7 @@ void show_trace(struct task_struct *task
 		printk(" =======================\n");
 	}
 	print_traces(task);
+	for (;;) raw_local_irq_disable();
 	show_held_locks(task);
 }
 
