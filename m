Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265982AbTBGQf5>; Fri, 7 Feb 2003 11:35:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266010AbTBGQf5>; Fri, 7 Feb 2003 11:35:57 -0500
Received: from nycsmtp2out.rdc-nyc.rr.com ([24.29.99.223]:38847 "EHLO
	nycsmtp2out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S265982AbTBGQf4>; Fri, 7 Feb 2003 11:35:56 -0500
Date: Fri, 7 Feb 2003 11:54:56 -0500 (EST)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: fdavis@master
To: linux-kernel@vger.kernel.org
cc: fdavis@si.rr.com, <trivial@rustcorp.com.au>
Subject: [PATCH] 2.5.59 : drivers/char/generic_serial.c 
Message-ID: <Pine.LNX.4.44.0302071150580.6917-100000@master>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
   The following patch fixes buzilla bug # 307 - a dangling else issue. 
Please review for inclusion.

Regards,
Frank

--- linux/drivers/char/generic_serial.c.old	2003-01-16 21:22:13.000000000 -0500
+++ linux/drivers/char/generic_serial.c	2003-02-07 03:22:26.000000000 -0500
@@ -142,14 +142,14 @@
  
 		/* Can't copy more? break out! */
 		if (c <= 0) break;
-		if (from_user)
+		if (from_user) {
 			if (copy_from_user (port->xmit_buf + port->xmit_head, 
 					    buf, c)) {
 				up (& port->port_write_sem);
 				return -EFAULT;
 			}
 
-		else
+		}else
 			memcpy (port->xmit_buf + port->xmit_head, buf, c);
 
 		port -> xmit_cnt += c;
 

