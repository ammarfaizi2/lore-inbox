Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316491AbSE0CVA>; Sun, 26 May 2002 22:21:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316486AbSE0CU7>; Sun, 26 May 2002 22:20:59 -0400
Received: from ausmtp02.au.ibm.COM ([202.135.136.105]:57752 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP
	id <S316491AbSE0CU4>; Sun, 26 May 2002 22:20:56 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Trivial: check_region cleanup from drivers/char/ip2main.c
Date: Mon, 27 May 2002 12:24:47 +1000
Message-Id: <E17CABj-0001GY-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

johnpol@2ka.mipt.ru: 40) request_region check, 31-40:
  You say, i'm frezy :)
  
  Please test and apply.
  
  	Evgeniy Polyakov ( s0mbre )
  

--- trivial-2.5.18/drivers/char/ip2main.c.orig	Mon May 27 12:07:37 2002
+++ trivial-2.5.18/drivers/char/ip2main.c	Mon May 27 12:07:37 2002
@@ -1002,12 +1002,10 @@
 	printk(KERN_INFO "IP2: Board %d: addr=0x%x irq=%d\n", boardnum + 1,
 	       ip2config.addr[boardnum], ip2config.irq[boardnum] );
 
-	if (0 != ( rc = check_region( ip2config.addr[boardnum], 8))) {
-		printk(KERN_ERR "IP2: bad addr=0x%x rc = %d\n",
-				ip2config.addr[boardnum], rc );
+	if (!request_region( ip2config.addr[boardnum], 8, pcName )) {
+		printk(KERN_ERR "IP2: bad addr=0x%x\n", ip2config.addr[boardnum]);
 		goto err_initialize;
 	}
-	request_region( ip2config.addr[boardnum], 8, pcName );
 
 	if ( iiDownloadAll ( pB, (loadHdrStrPtr)Fip_firmware, 1, Fip_firmware_size )
 	    != II_DOWN_GOOD ) {

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
