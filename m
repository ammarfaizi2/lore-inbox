Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261674AbUK2LVv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261674AbUK2LVv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 06:21:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261673AbUK2LVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 06:21:50 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:17166 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261674AbUK2LTv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 06:19:51 -0500
Date: Mon, 29 Nov 2004 12:19:43 +0100
From: Adrian Bunk <bunk@stusta.de>
To: davem@redhat.com, ralf@linux-mips.org
Cc: jgarzik@pobox.com, linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] remove dp83840.h
Message-ID: <20041129111943.GB9722@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dp83840.h is included once but none of the definitions it contains is 
actually used.

Is the patch below to remove it OK, or is there any usage planned?


diffstat output:
 drivers/net/ioc3-eth.c  |    1 
 include/linux/dp83840.h |   41 ----------------------------------------
 2 files changed, 42 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm3-full/drivers/net/ioc3-eth.c.old	2004-11-29 12:14:25.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/drivers/net/ioc3-eth.c	2004-11-29 12:14:34.000000000 +0100
@@ -56,7 +56,6 @@
 #include <linux/etherdevice.h>
 #include <linux/ethtool.h>
 #include <linux/skbuff.h>
-#include <linux/dp83840.h>
 #include <net/ip.h>
 
 #include <asm/byteorder.h>
--- linux-2.6.10-rc2-mm3-full/include/linux/dp83840.h	2004-10-18 23:54:32.000000000 +0200
+++ /dev/null	2004-11-25 03:16:25.000000000 +0100
@@ -1,41 +0,0 @@
-/*
- * linux/dp83840.h: definitions for DP83840 MII-compatible transceivers
- *
- * Copyright (C) 1996, 1999 David S. Miller (davem@redhat.com)
- */
-#ifndef __LINUX_DP83840_H
-#define __LINUX_DP83840_H
-
-#include <linux/mii.h>
-
-/*
- * Data sheets and programming docs for the DP83840 are available at
- * from http://www.national.com/
- *
- * The DP83840 is capable of both 10 and 100Mbps ethernet, in both
- * half and full duplex mode.  It also supports auto negotiation.
- *
- * But.... THIS THING IS A PAIN IN THE ASS TO PROGRAM!
- * Debugging eeprom burnt code is more fun than programming this chip!
- */
-
-/* First, the MII register numbers (actually DP83840 register numbers). */
-#define MII_CSCONFIG        0x17        /* CS configuration            */
-
-/* The Carrier Sense config register. */
-#define CSCONFIG_RESV1          0x0001  /* Unused...                   */
-#define CSCONFIG_LED4           0x0002  /* Pin for full-dplx LED4      */
-#define CSCONFIG_LED1           0x0004  /* Pin for conn-status LED1    */
-#define CSCONFIG_RESV2          0x0008  /* Unused...                   */
-#define CSCONFIG_TCVDISAB       0x0010  /* Turns off the transceiver   */
-#define CSCONFIG_DFBYPASS       0x0020  /* Bypass disconnect function  */
-#define CSCONFIG_GLFORCE        0x0040  /* Good link force for 100mbps */
-#define CSCONFIG_CLKTRISTATE    0x0080  /* Tristate 25m clock          */
-#define CSCONFIG_RESV3          0x0700  /* Unused...                   */
-#define CSCONFIG_ENCODE         0x0800  /* 1=MLT-3, 0=binary           */
-#define CSCONFIG_RENABLE        0x1000  /* Repeater mode enable        */
-#define CSCONFIG_TCDISABLE      0x2000  /* Disable timeout counter     */
-#define CSCONFIG_RESV4          0x4000  /* Unused...                   */
-#define CSCONFIG_NDISABLE       0x8000  /* Disable NRZI                */
-
-#endif /* __LINUX_DP83840_H */

