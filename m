Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129525AbQLDE23>; Sun, 3 Dec 2000 23:28:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129710AbQLDE2U>; Sun, 3 Dec 2000 23:28:20 -0500
Received: from smtp01.mrf.mail.rcn.net ([207.172.4.60]:24252 "EHLO
	smtp01.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id <S129525AbQLDE2P>; Sun, 3 Dec 2000 23:28:15 -0500
Message-ID: <3A2B163A.380E4A62@haque.net>
Date: Sun, 03 Dec 2000 22:57:46 -0500
From: "Mohammad A. Haque" <mhaque@haque.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: test12-pre4
In-Reply-To: <Pine.LNX.4.10.10012031828170.22914-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------DEF270124F250E9CE1270D5E"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------DEF270124F250E9CE1270D5E
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Was borking on dummy.c. This seemed to fix it. Verification please?

gcc -D__KERNEL__ -I/usr/src/linux-2.4.0-test11/include -Wall
-Wstrict-prototypes -O6 -fomit-frame-pointer -fno-strict-aliasing -pipe
-mpreferred-stack-boundary=2 -march=i686 -DMODULE -DMODVERSIONS -include
/usr/src/linux-2.4.0-test11/include/linux/modversions.h   -c -o dummy.o
dummy.c
dummy.c: In function `dummy_init_module':
dummy.c:103: invalid type argument of `->'
make[2]: *** [dummy.o] Error 1


Linus Torvalds wrote:
> 
> Synching up with Alan and various other stuff. The most important one
> being the fix to the inode dirty block list.
> 
>                 Linus
> 

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/ 
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================
--------------DEF270124F250E9CE1270D5E
Content-Type: text/plain; charset=us-ascii;
 name="dummy-t12p4.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dummy-t12p4.diff"

--- linux/drivers/net/dummy.c.orig	Sun Dec  3 21:59:18 2000
+++ linux/drivers/net/dummy.c	Sun Dec  3 22:52:13 2000
@@ -53,6 +53,8 @@
 
 static int __init dummy_init(struct net_device *dev)
 {
+	SET_MODULE_OWNER(dev);
+
 	/* Initialize the device structure. */
 	dev->hard_start_xmit	= dummy_xmit;
 
@@ -100,7 +102,6 @@
 	int err;
 
 	dev_dummy.init = dummy_init;
-	SET_MODULE_OWNER(&dev_dummy);
 
 	/* Find a name for this unit */
 	err=dev_alloc_name(&dev_dummy,"dummy%d");

--------------DEF270124F250E9CE1270D5E--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
