Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262284AbTC1Ht6>; Fri, 28 Mar 2003 02:49:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262292AbTC1Ht6>; Fri, 28 Mar 2003 02:49:58 -0500
Received: from franka.aracnet.com ([216.99.193.44]:35478 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S262284AbTC1Ht4>; Fri, 28 Mar 2003 02:49:56 -0500
Date: Fri, 28 Mar 2003 00:01:09 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix compiler warning in sound/pci/cs46xx/cs46xx_lib.o
Message-ID: <35900000.1048838469@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following compiler warning:
sound/pci/cs46xx/cs46xx_lib.c: In function `amp_voyetra':
sound/pci/cs46xx/cs46xx_lib.c:3384: warning: unused variable `old'
by wrapping the old variable in the same ifdef as its usage.

diff -urpN -X /home/fletch/.diff.exclude
virgin/sound/pci/cs46xx/cs46xx_lib.c
cs46xx_lib/sound/pci/cs46xx/cs46xx_lib.c
--- virgin/sound/pci/cs46xx/cs46xx_lib.c	Wed Mar 26 22:54:40 2003
+++ cs46xx_lib/sound/pci/cs46xx/cs46xx_lib.c	Thu Mar 27 23:45:23 2003
@@ -3381,7 +3381,9 @@ static void amp_voyetra(cs46xx_t *chip, 
 	/* Manage the EAPD bit on the Crystal 4297 
 	   and the Analog AD1885 */
 	   
+#ifdef CONFIG_SND_CS46XX_NEW_DSP
 	int old = chip->amplifier;
+#endif
 	int oval, val;
 	
 	chip->amplifier += change;

