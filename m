Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266396AbTGJQ4i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 12:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269390AbTGJQyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 12:54:38 -0400
Received: from serenity.mcc.ac.uk ([130.88.200.93]:16136 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP id S269349AbTGJQy0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 12:54:26 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10578569441778@movementarian.org>
Subject: [PATCH 2/3] OProfile: needed fix to IO-APIC timer
In-Reply-To: <1057856944622@movementarian.org>
From: John Levon <levon@movementarian.org>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Thu, 10 Jul 2003 18:09:04 +0100
Content-Transfer-Encoding: 7BIT
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19aeun-000AiW-Ku*HNAT4HOD.BI*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Retransmit of a critical fix to the IO-APIC timer support. By Zwane Mwaikambo. Please apply

diff -Naur -X dontdiff linux-cvs/arch/i386/kernel/nmi.c linux-fixes/arch/i386/kernel/nmi.c
--- linux-cvs/arch/i386/kernel/nmi.c	2003-06-18 15:06:05.000000000 +0100
+++ linux-fixes/arch/i386/kernel/nmi.c	2003-06-18 23:09:49.000000000 +0100
@@ -189,7 +189,6 @@
 	if ((nmi_watchdog != NMI_IO_APIC) || (nmi_active <= 0))
 		return;
 
-	disable_irq(0);
 	unset_nmi_callback();
 	nmi_active = -1;
 	nmi_watchdog = NMI_NONE;
@@ -201,7 +200,6 @@
 		nmi_watchdog = NMI_IO_APIC;
 		touch_nmi_watchdog();
 		nmi_active = 1;
-		enable_irq(0);
 	}
 }
 

