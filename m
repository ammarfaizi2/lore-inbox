Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315591AbSECIEX>; Fri, 3 May 2002 04:04:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315592AbSECIEX>; Fri, 3 May 2002 04:04:23 -0400
Received: from swazi.realnet.co.sz ([196.28.7.2]:64430 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S315591AbSECIEW>; Fri, 3 May 2002 04:04:22 -0400
Date: Fri, 3 May 2002 09:43:40 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] [2.5.12] test_bit fixes
Message-ID: <Pine.LNX.4.44.0205030940480.12156-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

arch/i386/kernel/microcode.c
arch/i386/kernel/msr.c

Now i just need to wade through the alsa ones...

--- linux-2.5/arch/i386/kernel/microcode.c.orig	Thu May  2 21:05:23 2002
+++ linux-2.5/arch/i386/kernel/microcode.c	Thu May  2 21:37:26 2002
@@ -211,7 +211,7 @@
 	req->err = 1; /* assume update will fail on this cpu */
 
 	if (c->x86_vendor != X86_VENDOR_INTEL || c->x86 < 6 ||
-		test_bit(X86_FEATURE_IA64, &c->x86_capability)){
+		test_bit(X86_FEATURE_IA64, c->x86_capability)){
 		printk(KERN_ERR "microcode: CPU%d not a capable Intel processor\n", cpu_num);
 		return;
 	}
--- linux-2.5/arch/i386/kernel/msr.c.orig	Thu May  2 20:54:32 2002
+++ linux-2.5/arch/i386/kernel/msr.c	Thu May  2 21:37:18 2002
@@ -236,7 +236,7 @@
   
   if ( !(cpu_online_map & (1UL << cpu)) )
     return -ENXIO;		/* No such CPU */
-  if ( !test_bit(X86_FEATURE_MSR, &c->x86_capability) )
+  if ( !test_bit(X86_FEATURE_MSR, c->x86_capability) )
     return -EIO;		/* MSR not supported */
   
   return 0;

-- 
http://function.linuxpower.ca

