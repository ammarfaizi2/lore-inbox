Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261647AbUKOXyV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261647AbUKOXyV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 18:54:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261658AbUKOXxO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 18:53:14 -0500
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:52700 "EHLO
	biscayne-one-station.mit.edu") by vger.kernel.org with ESMTP
	id S261639AbUKOXwl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 18:52:41 -0500
Date: Mon, 15 Nov 2004 18:52:35 -0500 (EST)
From: Nickolai Zeldovich <kolya@MIT.EDU>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
cc: linux-kernel@vger.kernel.org, csapuntz@stanford.edu
Subject: Re: [patch] Fix GDT re-load on ACPI resume
In-Reply-To: <Pine.LNX.4.58L.0411152320520.12776@blysk.ds.pg.gda.pl>
Message-ID: <Pine.GSO.4.58L.0411151851430.4959@contents-vnder-pressvre.mit.edu>
References: <Pine.GSO.4.58L.0411151525540.28749@contents-vnder-pressvre.mit.edu>
 <Pine.LNX.4.58L.0411152320520.12776@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Nov 2004, Maciej W. Rozycki wrote:

>  You should use "lgdtl" and let gas figure out the rest.

Thanks for the pointer; here's an updated patch.

-- kolya

--- linux-2.6.9/arch/i386/kernel/acpi/wakeup.S	2004/11/15 09:00:34	1.1
+++ linux-2.6.9/arch/i386/kernel/acpi/wakeup.S	2004/11/15 23:50:38
@@ -66,8 +66,9 @@
 	movw	%ax,%fs
 	movw	$0x0e00 + 'i', %fs:(0x12)

-	# need a gdt
-	lgdt	real_save_gdt - wakeup_code
+	# need a gdt -- use lgdtl to force 32-bit operands, in case
+	# the GDT is located past 16 megabytes.
+	lgdtl	real_save_gdt - wakeup_code

 	movl	real_save_cr0 - wakeup_code, %eax
 	movl	%eax, %cr0
