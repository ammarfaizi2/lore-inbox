Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266143AbUFUHS6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266143AbUFUHS6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 03:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266138AbUFUHS6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 03:18:58 -0400
Received: from fw.osdl.org ([65.172.181.6]:5803 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266144AbUFUHRV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 03:17:21 -0400
Date: Mon, 21 Jun 2004 00:16:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: lkml@lpbproduction.scom
Cc: lkml@lpbproductions.com, cs@tequila.co.jp, torvalds@osdl.org,
       norberto+linux-kernel@bensa.ath.cx, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com
Subject: Re: 2.6.7-bk way too fast
Message-Id: <20040621001612.176bf8e1.akpm@osdl.org>
In-Reply-To: <200406210018.04883.lkml@lpbproductions.com>
References: <40D64DF7.5040601@pobox.com>
	<Pine.LNX.4.58.0406202313510.11274@ppc970.osdl.org>
	<40D688D1.7020308@tequila.co.jp>
	<200406210018.04883.lkml@lpbproductions.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

