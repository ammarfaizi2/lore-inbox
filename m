Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262357AbTD3T65 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 15:58:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262371AbTD3T65
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 15:58:57 -0400
Received: from muss.CIS.mcmaster.ca ([130.113.64.9]:9399 "EHLO
	cgpsrv1.cis.mcmaster.ca") by vger.kernel.org with ESMTP
	id S262357AbTD3T6x convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 15:58:53 -0400
From: Gabriel Devenyi <devenyga@mcmaster.ca>
To: vojtech@suse.cz
Subject: [PATCH] Linux 2.5.68 - Fix gameport_close(gameport); after return in drivers/input/gameport/gameport.c
Date: Thu, 1 May 2003 16:10:06 -0400
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200305011610.07281.devenyga@mcmaster.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

This patch applies to 2.5.68, it is listed on kbugs.org. The gameport is never closed after calibrating it.

Please CC me with any discussion.
- -- 
Building the Future,
Gabriel Devenyi
devenyga@mcmaster.ca

- ---FILE---

- --- linux-2.5.68/drivers/input/gameport/gameport.c	2003-04-19 22:49:31.000000000 -0400
+++ linux-2.5.68-changed/drivers/input/gameport/gameport.c	2003-05-01 14:57:51.000000000 -0400
@@ -84,6 +84,7 @@
 		if ((t = DELTA(t2,t1) - DELTA(t3,t2)) < tx) tx = t;
 	}
 
+	gameport_close(gameport);
 	return 59659 / (tx < 1 ? 1 : tx);
 
 #else
@@ -93,11 +94,10 @@
 	j = jiffies; while (j == jiffies);
 	j = jiffies; while (j == jiffies) { t++; gameport_read(gameport); }
 
+	gameport_close(gameport);
 	return t * HZ / 1000;
 
 #endif
- -
- -	gameport_close(gameport);
 }
 
 static void gameport_find_dev(struct gameport *gameport)

- ---ENFILE---
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+sX8e7I5UBdiZaF4RAv8DAKCPpHLHADzNWUmRpHrHw7ldAfUdeACgklGx
9V+o3A+iUO8Jzb7T1Mr/6eU=
=EABS
-----END PGP SIGNATURE-----

