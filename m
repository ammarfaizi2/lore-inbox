Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266208AbUFUMZr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266208AbUFUMZr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 08:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266209AbUFUMZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 08:25:47 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17538 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266208AbUFUMZo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 08:25:44 -0400
Date: Mon, 21 Jun 2004 09:18:48 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Andrew Walrond <andrew@walrond.org>
Cc: linux-kernel@vger.kernel.org, zebul666 <zebul666@voila.fr>
Subject: Re: PROBLEM: 2.4.27-rc1 system clock is running two times too fast
Message-ID: <20040621121848.GA10911@logos.cnet>
References: <40D6C6DD.40607@voila.fr> <200406211201.21040.andrew@walrond.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406211201.21040.andrew@walrond.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 21, 2004 at 12:01:20PM +0100, Andrew Walrond wrote:
> On Monday 21 Jun 2004 12:30, zebul666 wrote:
> > System is running 2 times faster than it should
> 
> Could this be related to the recent 2.6.7-bk troubles? Have similar patches 
> made it into 2.4?
> 
> (Check back a few messages or archives for details)

The change which broke made it through ACPI update

This patch from Andrew (for 2.6, but 2.4 should be very similar) seem to
fix it.


 06/21/2004 00:21:37

"Matt H." <lkml@lpbproductions.com> wrote:
>
> I can confirm simular behavior here. I loaded 2.6.7-mm1 tonite  and  tried  
> Andrew's  patch ( which didn't work ) and then Linus's  ( which also didn't 
> work ).
> 

hm.  This worked for me.  Could you double-check?


diff -puN arch/i386/kernel/mpparse.c~double-clock-speed-fix arch/i386/kernel/mpparse.c
--- 25/arch/i386/kernel/mpparse.c~double-clock-speed-fix	2004-06-20 23:28:16.655299120 -0700
+++ 25-akpm/arch/i386/kernel/mpparse.c	2004-06-20 23:28:20.468719392 -0700
@@ -1017,7 +1017,6 @@ void __init mp_config_acpi_legacy_irqs (
 
 		for (idx = 0; idx < mp_irq_entries; idx++)
 			if (mp_irqs[idx].mpc_srcbus == MP_ISA_BUS &&
-				(mp_irqs[idx].mpc_dstapic == ioapic) &&
 				(mp_irqs[idx].mpc_srcbusirq == i ||
 				mp_irqs[idx].mpc_dstirq == i))
 					break;
diff -puN arch/x86_64/kernel/mpparse.c~double-clock-speed-fix arch/x86_64/kernel/mpparse.c
--- 25/arch/x86_64/kernel/mpparse.c~double-clock-speed-fix	2004-06-20 23:28:16.672296536 -0700
+++ 25-akpm/arch/x86_64/kernel/mpparse.c	2004-06-20 23:28:20.469719240 -0700
@@ -861,7 +861,6 @@ void __init mp_config_acpi_legacy_irqs (
 
 		for (idx = 0; idx < mp_irq_entries; idx++)
 			if (mp_irqs[idx].mpc_srcbus == MP_ISA_BUS &&
-				(mp_irqs[idx].mpc_dstapic == ioapic) &&
 				(mp_irqs[idx].mpc_srcbusirq == i ||
 				mp_irqs[idx].mpc_dstirq == i))
 					break;
_

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
