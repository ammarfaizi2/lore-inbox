Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262927AbTDFKvr (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 06:51:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262926AbTDFKvr (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 06:51:47 -0400
Received: from modemcable169.130-200-24.mtl.mc.videotron.ca ([24.200.130.169]:22792
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S262927AbTDFKvp (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 6 Apr 2003 06:51:45 -0400
Date: Sun, 6 Apr 2003 06:58:24 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH][2.5] small fix for printk KERN_WARNING in mpparse
Message-ID: <Pine.LNX.4.50.0304060650230.2268-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

before:
OEM ID: IBM NUMA Product ID: SBB          <6>Found an OEM MPC table at   601320 - parsing it ...

after:
OEM ID: IBM NUMA Product ID: SBB          Found an OEM MPC table at 00601320 - parsing it ...

Index: linux-2.5.66/arch/i386/kernel/mpparse.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.66/arch/i386/kernel/mpparse.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 mpparse.c
--- linux-2.5.66/arch/i386/kernel/mpparse.c	24 Mar 2003 23:40:27 -0000	1.1.1.1
+++ linux-2.5.66/arch/i386/kernel/mpparse.c	6 Apr 2003 10:56:09 -0000
@@ -295,7 +295,7 @@ static void __init smp_read_mpc_oem(stru
 	unsigned char *oemptr = ((unsigned char *)oemtable)+count;
 	
 	mpc_record = 0;
-	printk(KERN_INFO "Found an OEM MPC table at %8p - parsing it ... \n", oemtable);
+	printk("Found an OEM MPC table at %p - parsing it ... \n", oemtable);
 	if (memcmp(oemtable->oem_signature,MPC_OEM_SIGNATURE,4))
 	{
 		printk(KERN_WARNING "SMP mpc oemtable: bad signature [%c%c%c%c]!\n",
-- 
function.linuxpower.ca
