Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266280AbUAHVqM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 16:46:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266325AbUAHVqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 16:46:12 -0500
Received: from ofmail.of.pl ([217.97.243.238]:7896 "EHLO ofmail.of.pl")
	by vger.kernel.org with ESMTP id S266280AbUAHVqL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 16:46:11 -0500
From: =?iso-8859-2?q?Pawe=B3_Goleniowski?= <pawelg@dabrowa.pl>
To: linux-kernel@vger.kernel.org
Subject: [PATCH for 2.4.x] rivafb & small 16 bit mode problem
Date: Thu, 8 Jan 2004 22:45:56 +0100
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Cc: marcelo.tosatti@cyclades.com, trivial@rustcorp.com.au
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_U+c//wvZdA6GwMA"
Message-Id: <200401082245.56654.pawelg@dabrowa.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_U+c//wvZdA6GwMA
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I have already send this once before Xmas but it probably got lost, so I'm 
sending it again:

There is a problem with 16 bit mode with rivafb. Colors are sometimes broken 
(specialy under Midnight Commander). This small patch fixes it. I've been 
using it for last months and it works without any problems.

Pawel 'Goldi' Goleniowski



--Boundary-00=_U+c//wvZdA6GwMA
Content-Type: text/x-diff;
  charset="iso-8859-2";
  name="patch-rivafb.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="patch-rivafb.diff"

--- linux/drivers/video/riva/accel.c	2003-12-22 22:46:27.000000000 +0100
+++ linux/drivers/video/riva/accel.c	2003-12-22 19:47:19.000000000 +0100
@@ -300,8 +300,8 @@
 
 static inline void convert_bgcolor_16(u32 *col)
 {
-	*col = ((*col & 0x00007C00) << 9)
-             | ((*col & 0x000003E0) << 6)
+	*col = ((*col & 0x0000F800) << 8)
+             | ((*col & 0x000007E0) << 5)
              | ((*col & 0x0000001F) << 3)
              |          0xFF000000;
 }

--Boundary-00=_U+c//wvZdA6GwMA--

