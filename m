Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316675AbSGVKtn>; Mon, 22 Jul 2002 06:49:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316681AbSGVKtm>; Mon, 22 Jul 2002 06:49:42 -0400
Received: from [195.63.194.11] ([195.63.194.11]:22536 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316675AbSGVKtl>; Mon, 22 Jul 2002 06:49:41 -0400
Message-ID: <3D3BE2B5.9010807@evision.ag>
Date: Mon, 22 Jul 2002 12:47:17 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020625
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.27 smbiod
References: <Pine.LNX.4.44.0207201218390.1230-100000@home.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------080900070903070306070409"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080900070903070306070409
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Fix label at block end warning - don't write "assembler code".

--------------080900070903070306070409
Content-Type: text/plain;
 name="smbiod-2.5.27.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="smbiod-2.5.27.diff"

diff -urN linux-2.5.27/fs/smbfs/smbiod.c linux/fs/smbfs/smbiod.c
--- linux-2.5.27/fs/smbfs/smbiod.c	2002-07-20 21:11:26.000000000 +0200
+++ linux/fs/smbfs/smbiod.c	2002-07-22 01:39:05.000000000 +0200
@@ -233,14 +233,14 @@
 	int maxwork = 7;
 
 	if (server->state != CONN_VALID)
-		goto out;
+		return;
 
 	do {
 		result = smb_request_recv(server);
 		if (result < 0) {
 			server->state = CONN_INVALID;
 			smbiod_retry(server);
-			goto out;	/* reconnecting is slow */
+			return;	/* reconnecting is slow */
 		} else if (server->rstate == SMB_RECV_REQUEST)
 			smbiod_handle_request(server);
 	} while (result > 0 && maxwork-- > 0);
@@ -249,7 +249,7 @@
 	 * If there is more to read then we want to be sure to wake up again.
 	 */
 	if (server->state != CONN_VALID)
-		goto out;
+		return;
 	if (smb_recv_available(server) > 0)
 		set_bit(SMBIOD_DATA_READY, &smbiod_flags);
 
@@ -258,7 +258,7 @@
 		if (result < 0) {
 			server->state = CONN_INVALID;
 			smbiod_retry(server);
-			goto out;	/* reconnecting is slow */
+			return;	/* reconnecting is slow */
 		}
 	} while (result > 0);
 
@@ -267,8 +267,6 @@
 	 */
 	if (!list_empty(&server->xmitq))
 		set_bit(SMBIOD_DATA_READY, &smbiod_flags);
-
-out:
 }
 
 /*

--------------080900070903070306070409--

