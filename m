Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262367AbTD3TgA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 15:36:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262371AbTD3Tf7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 15:35:59 -0400
Received: from muss.CIS.mcmaster.ca ([130.113.64.9]:23473 "EHLO
	cgpsrv1.cis.mcmaster.ca") by vger.kernel.org with ESMTP
	id S262367AbTD3Tf6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 15:35:58 -0400
From: Gabriel Devenyi <devenyga@mcmaster.ca>
To: khc@pm.waw.pl
Subject: [PATCH] Linux 2.5.68 - Fix module_put after return statement
Date: Thu, 1 May 2003 15:48:15 -0400
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200305011548.16524.devenyga@mcmaster.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

This patch applies to 2.5.68. Its listed on kbugs.org. The function module_put is never called because it is after return.

Please CC me with any discussion.
- -- 
Building the Future,
Gabriel Devenyi
devenyga@mcmaster.ca

- ---FILE---

- --- linux-2.5.68/drivers/net/wan/c101.c	2003-04-19 22:50:34.000000000 -0400
+++ linux-2.5.68-changed/drivers/net/wan/c101.c	2003-05-01 15:04:23.000000000 -0400
@@ -161,8 +161,8 @@
 
 	int result = hdlc_open(hdlc);
 	if (result) {
- -		return result;
 		module_put(THIS_MODULE);
+		return result;
 	}
 
 	writeb(1, port->win0base + C101_DTR);

- ---ENDFILE---
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+sXn/7I5UBdiZaF4RAitxAJ9UHBL/iO7nuElsJkIBTqivnGoGDQCfQYbj
6ZrVhEXv1ir82/V/KKHjEQI=
=xOsM
-----END PGP SIGNATURE-----

