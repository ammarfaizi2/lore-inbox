Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265506AbUEZLzZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265506AbUEZLzZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 07:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265509AbUEZLzZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 07:55:25 -0400
Received: from mx1.elte.hu ([157.181.1.137]:49345 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S265506AbUEZLzV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 07:55:21 -0400
Date: Wed, 26 May 2004 13:44:54 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.7-rc1-bk: SMT scheduler bug / crashes on kernel boot
Message-ID: <20040526114454.GA10614@elte.hu>
References: <1085568719.2666.53.camel@imp.csi.cam.ac.uk> <1085569838.2666.60.camel@imp.csi.cam.ac.uk> <40B47F47.20504@yahoo.com.au> <1085571285.2666.75.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1085571285.2666.75.camel@imp.csi.cam.ac.uk>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Anton Altaparmakov <aia21@cam.ac.uk> wrote:

> WARNING: 1 siblings found for CPU0, should be 2

does the patch below fix it?

	Ingo

--- linux/arch/i386/kernel/smpboot.c.orig	
+++ linux/arch/i386/kernel/smpboot.c	
@@ -1110,8 +1110,10 @@ static void __init smp_boot_cpus(unsigne
 			cpu_set(cpu, cpu_sibling_map[cpu]);
 		}
 
-		if (siblings != smp_num_siblings)
+		if (siblings != smp_num_siblings) {
 			printk(KERN_WARNING "WARNING: %d siblings found for CPU%d, should be %d\n", siblings, cpu, smp_num_siblings);
+			smp_num_siblings = siblings;
+		}
 	}
 
 	if (nmi_watchdog == NMI_LOCAL_APIC)
