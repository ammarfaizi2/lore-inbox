Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265689AbSKKPcx>; Mon, 11 Nov 2002 10:32:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265693AbSKKPcx>; Mon, 11 Nov 2002 10:32:53 -0500
Received: from natsmtp01.webmailer.de ([192.67.198.81]:58068 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S265689AbSKKPcw>; Mon, 11 Nov 2002 10:32:52 -0500
Date: Mon, 11 Nov 2002 16:39:15 +0100
From: Dominik Brodowski <linux@brodo.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, cpufreq@www.linux.org.uk
Subject: [2.5. PATCH] cpufreq: VIA longhaul v.1 update
Message-ID: <20021111163915.A1517@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Updates for better support of VIA longhaul v.1. which is found on
Samuel/CyrixIII, Samuel2/C3 processors. (Dave Jones)

	Dominik

--- linux-2545original/arch/i386/kernel/cpu/cpufreq/longhaul.c	Thu Oct 31 12:00:00 2002
+++ linux/arch/i386/kernel/cpu/cpufreq/longhaul.c	Thu Oct 31 23:50:00 2002
@@ -1,5 +1,5 @@
 /*
- *  $Id: longhaul.c,v 1.72 2002/09/29 23:43:10 db Exp $
+ *  $Id: longhaul.c,v 1.77 2002/10/31 21:17:40 db Exp $
  *
  *  (C) 2001  Dave Jones. <davej@suse.de>
  *  (C) 2002  Padraig Brady. <padraig@antefacto.com>
@@ -436,8 +436,10 @@
 	switch (longhaul) {
 	case 1:
 		/* Ugh, Longhaul v1 didn't have the min/max MSRs.
-		   Assume max = whatever we booted at. */
+		   Assume min=3.0x & max = whatever we booted at. */
+		minmult = 30;
 		maxmult = longhaul_get_cpu_mult();
+		minfsb = maxfsb = current_fsb;
 		break;
 
 	case 2 ... 3:
