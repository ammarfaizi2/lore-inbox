Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262288AbTD3TrJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 15:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262342AbTD3TrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 15:47:09 -0400
Received: from muss.CIS.mcmaster.ca ([130.113.64.9]:11700 "EHLO
	cgpsrv1.cis.mcmaster.ca") by vger.kernel.org with ESMTP
	id S262288AbTD3TqN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 15:46:13 -0400
From: Gabriel Devenyi <devenyga@mcmaster.ca>
To: khc@pm.waw.pl
Subject: [PATCH] Linux 2.5.68 - Fix module_put after return in drivers/net/wan/n2.c
Date: Thu, 1 May 2003 15:58:30 -0400
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200305011558.32475.devenyga@mcmaster.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

This patch applies to 2.5.68. It is a bug listed at kbugs.org. module_put is never executed because it is after return.

Please CC me with any discussion.
- -- 
Building the Future,
Gabriel Devenyi
devenyga@mcmaster.ca

- ---FILE---

- --- linux-2.5.68/drivers/net/wan/n2.c	2003-04-19 22:48:55.000000000 -0400
+++ linux-2.5.68-changed/drivers/net/wan/n2.c	2003-05-01 15:05:36.000000000 -0400
@@ -223,8 +223,8 @@
 
 	int result = hdlc_open(hdlc);
 	if (result) {
- -		return result;
 		module_put(THIS_MODULE);
+		return result;
 	}
 
 	mcr &= port->phy_node ? ~DTR_PORT1 : ~DTR_PORT0; /* set DTR ON */

- ---ENDFILE---
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+sXxm7I5UBdiZaF4RAu8kAJ0RKpz8xwzNovBJIgD/vd4f4hEAzQCeNKpI
USAyeWl6lmsVqOPEzV/r1tI=
=rplC
-----END PGP SIGNATURE-----

