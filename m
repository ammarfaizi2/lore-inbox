Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270738AbTGNTDq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 15:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270741AbTGNTDq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 15:03:46 -0400
Received: from smtp012.mail.yahoo.com ([216.136.173.32]:30483 "HELO
	smtp012.mail.yahoo.com") by vger.kernel.org with SMTP
	id S270738AbTGNTC1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 15:02:27 -0400
From: Michael Buesch <fsdeveloper@yahoo.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 2.4.22-pre5] another cpia.c warning fix
Date: Mon, 14 Jul 2003 21:16:48 +0200
User-Agent: KMail/1.5.2
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200307142116.48774.fsdeveloper@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi.

This patch fixes these warnings:
cpia.c:1686: Warnung: comparison is always false due to limited range of data type
cpia.c:1688: Warnung: comparison is always false due to limited range of data type
cpia.c:1690: Warnung: comparison is always false due to limited range of data type
cpia.c:1692: Warnung: comparison is always false due to limited range of data type

The warnings are thrown, because an u8 is tested against >255.
As far as I can see, these tests are completely useless,
because u8 will never be >255.
struct cam_params {
[SNIP]
	struct {
		u8 gainMode;
		u8 expMode;
		u8 compMode;
		u8 centreWeight;
		u8 gain;
		u8 fineExp;
		u8 coarseExpLo;
		u8 coarseExpHi;
		u8 redComp;
		u8 green1Comp;
		u8 green2Comp;
		u8 blueComp;
	} exposure;
[SNIP]
};



- --- drivers/media/video/cpia.c.orig	2003-06-13 20:52:37.000000000 +0200
+++ drivers/media/video/cpia.c	2003-07-14 21:12:45.000000000 +0200
@@ -1683,13 +1683,9 @@
 			 * values.             - rich@annexia.org
 			 */
 			if (cam->params.exposure.redComp < 220 ||
- -			    cam->params.exposure.redComp > 255 ||
 			    cam->params.exposure.green1Comp < 214 ||
- -			    cam->params.exposure.green1Comp > 255 ||
 			    cam->params.exposure.green2Comp < 214 ||
- -			    cam->params.exposure.green2Comp > 255 ||
- -			    cam->params.exposure.blueComp < 230 ||
- -			    cam->params.exposure.blueComp > 255)
+			    cam->params.exposure.blueComp < 230)
 			  {
 			    printk (KERN_WARNING "*_comp parameters have gone AWOL (%d/%d/%d/%d) - reseting them\n",
 				    cam->params.exposure.redComp,

- -- 
Regards Michael Buesch
http://www.8ung.at/tuxsoft
 21:12:56 up  2:23,  3 users,  load average: 1.20, 1.06, 1.13

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/EwGgoxoigfggmSgRAgOyAJ42TUVPCMuuFhlhQne351LQAayyrACfY5gn
LdtWXgKauUanjuwOn6cfM/c=
=ZwVh
-----END PGP SIGNATURE-----

