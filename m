Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263725AbTDGWpr (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 18:45:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263722AbTDGWpp (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 18:45:45 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:37504
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263743AbTDGWom (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 18:44:42 -0400
Date: Tue, 8 Apr 2003 01:03:37 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200304080003.h3803b3P008916@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: read extended cpu revision data
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Dave Jones)

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/arch/i386/kernel/cpu/common.c linux-2.5.67-ac1/arch/i386/kernel/cpu/common.c
--- linux-2.5.67/arch/i386/kernel/cpu/common.c	2003-03-18 16:46:45.000000000 +0000
+++ linux-2.5.67-ac1/arch/i386/kernel/cpu/common.c	2003-03-23 15:55:48.000000000 +0000
@@ -217,6 +217,10 @@
 			c->x86_capability[4] = excap;
 			c->x86 = (tfms >> 8) & 15;
 			c->x86_model = (tfms >> 4) & 15;
+			if (c->x86 == 0xf) {
+				c->x86 += (tfms >> 20) & 0xff;
+				c->x86_model += ((tfms >> 16) & 0xF) << 4;
+			} 
 			c->x86_mask = tfms & 15;
 		} else {
 			/* Have CPUID level 0 only - unheard of */
