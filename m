Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261496AbUCDHE0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 02:04:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261524AbUCDHE0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 02:04:26 -0500
Received: from smtp6.wanadoo.fr ([193.252.22.25]:28011 "EHLO
	mwinf0602.wanadoo.fr") by vger.kernel.org with ESMTP
	id S261496AbUCDHEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 02:04:08 -0500
Date: Thu, 4 Mar 2004 08:04:27 +0000
From: Philippe Elie <phil.el@wanadoo.fr>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nmi_watchdog=2 and P4-HT
Message-ID: <20040304080427.GC683@zaniah>
References: <20040304054215.GA683@zaniah>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040304054215.GA683@zaniah>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 Mar 2004 at 05:42 +0000, Philippe Elie wrote:

> Hi,
> 
> Actually with nmi_watchdog=2 and a P4 ht box the nmi is reflected
> only on logical processor 0, it's better to get it on both.

oops a line from a next patch is in the patch "deliver nmi to both thread"
patch, apply this incremental patch please else on UP check_nmi_watchdog()
will use 1hz as rate and boot will wait 10 seconds for complementation
of this test.

Phil 


--- linux-2.6/arch/i386/kernel/nmi.c~	2004-03-04 07:59:22.000000000 +0000
+++ linux-2.6/arch/i386/kernel/nmi.c	2004-03-04 07:59:31.000000000 +0000
@@ -347,7 +347,6 @@ static int setup_p4_watchdog(void)
 	wrmsr(MSR_P4_IQ_COUNTER0, -(cpu_khz/nmi_hz*1000), -1);
 	apic_write(APIC_LVTPC, APIC_DM_NMI);
 	wrmsr(MSR_P4_IQ_CCCR0, nmi_p4_cccr_val, 0);
-	nmi_hz = 1;
 	return 1;
 }
 
