Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310207AbSCPKBl>; Sat, 16 Mar 2002 05:01:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310208AbSCPKB0>; Sat, 16 Mar 2002 05:01:26 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:31714 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S310207AbSCPKBP>; Sat, 16 Mar 2002 05:01:15 -0500
Date: Sat, 16 Mar 2002 11:44:37 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Jones <davej@suse.de>
Subject: [PATCH] Natsemi Geode GXn PM support and extended MMX
Message-ID: <Pine.LNX.4.44.0203161143160.28013-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am _not_ obsessed with power management.
I am _not_ obsessed with power management.
I am _not_ obsessed with power management.

Ok now that that's been cleared up, this patch enables suspend-on-hlt 
(Geode GXn CPU power management) and enables the SUSP# pin on the CPU 
which allows APM to function. Which brings me on to my next question, does 
APM on Geode GXn work? The datasheet specifies that in order for the 
processor to enter suspend mode (in response to SUSP# assertion) the first 
criteria which must be met is that the USE_SUSP bit must be set (CCR2 bit 
7). Part two of the patch simply enables extended MMX instructions for the 
GXn.

I'd be interested to hear of any problems with this.

Cheers,
	Zwane

Diffed against 2.4.19-pre2-ac3

--- arch/i386/kernel/setup.c.orig	Sat Mar 16 09:45:46 2002
+++ arch/i386/kernel/setup.c	Sat Mar 16 11:14:56 2002
@@ -71,6 +71,9 @@
  *  CacheSize bug workaround updates for AMD, Intel & VIA Cyrix.
  *  Dave Jones <davej@suse.de>, September, October 2001.
  *
+ *  Added additional support for Natsemi/Cyrix Geode GXn CPUs,
+ *  Enabled power management and extended MMX instructions.
+ *  Zwane Mwaikambo <zwane@commfireservices.com>, March 2002.
  */
 
 /*
@@ -1509,6 +1512,12 @@
 
 		/* GXm supports extended cpuid levels 'ala' AMD */
 		if (c->cpuid_level == 2) {
+			/* Enable Natsemi MMX extensions */
+			setCx86(CX86_CCR7, getCx86(CX86_CCR7) | 1);
+
+			/* Suspend on halt power saving and enable #SUSP pin */
+			setCx86(CX86_CCR2, getCx86(CX86_CCR2) | 0x88);
+
 			get_model_name(c);  /* get CPU marketing name */
 			/*
 	 		 *	The 5510/5520 companion chips have a funky PIT

