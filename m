Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264561AbUDVQl1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264561AbUDVQl1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 12:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264559AbUDVQl0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 12:41:26 -0400
Received: from gruby.cs.net.pl ([62.233.142.99]:50695 "EHLO gruby.cs.net.pl")
	by vger.kernel.org with ESMTP id S264552AbUDVQlG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 12:41:06 -0400
Date: Thu, 22 Apr 2004 18:41:01 +0200
From: Jakub Bogusz <qboosh@pld-linux.org>
To: linux-kernel@vger.kernel.org
Cc: linux-nvidia@lists.surfsouth.com, ajoshi@shell.unixbox.com
Subject: [PATCH 2.4, 2.6] rivafb 16bpp text background colour fix
Message-ID: <20040422164101.GA16878@gruby.cs.net.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I sent it already to Ani Joshi long time ago (December 2002),
but it seems to be lost somewhere in time.
I noticed that Pawel Goleniowski made the same patch and sent to LKML
in December 2003 and January 2004:
http://www.uwsg.iu.edu/hypermail/linux/kernel/0312.2/1258.html
http://www.uwsg.iu.edu/hypermail/linux/kernel/0401.1/0225.html
but it's still not fixed.

The same applies to 2.6.x series, only filename
(linux-2.6.*/drivers/video/riva/fbdev.c instead of .../riva/accel.c)
and whitespace (tabs are used now instead of spaces) differ.

Original description (written in Dec 2002):
> I noticed, that text background in 16bpp (only) modes is displayed
> incorrectly. That's because convert_bgcolor_16() converts value to RGBA
> from 15bpp, not 16bpp.
>
> The fix is attached (works for me, tested by one more person).
> Patch was made against Linux 2.4.19, but should apply to 2.4.20 and
> 2.5.x without changes.


-- 
Jakub Bogusz    http://cyber.cs.net.pl/~qboosh/

--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-rivafb16-bgcolor.patch"

Text background in 16bpp (only) modes was displayed incorrectly because
onvert_bgcolor_16() converted value to RGBA from 15bpp, not 16bpp as it
should.

--- linux-2.4.19/drivers/video/riva/accel.c.orig	Sat Aug  3 02:39:45 2002
+++ linux-2.4.19/drivers/video/riva/accel.c	Thu Nov 28 12:08:49 2002
@@ -293,8 +293,8 @@
 
 static inline void convert_bgcolor_16(u32 *col)
 {
-	*col = ((*col & 0x00007C00) << 9)
-             | ((*col & 0x000003E0) << 6)
+	*col = ((*col & 0x0000F800) << 8)
+             | ((*col & 0x000007E0) << 5)
              | ((*col & 0x0000001F) << 3)
              |          0xFF000000;
 }

--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.6-rivafb16.patch"

Text background in 16bpp (only) modes was displayed incorrectly because
onvert_bgcolor_16() converted value to RGBA from 15bpp, not 16bpp as it
should.

--- linux-2.6.4/drivers/video/riva/fbdev.c.orig	2004-03-11 03:55:36.000000000 +0100
+++ linux-2.6.4/drivers/video/riva/fbdev.c	2004-04-22 18:42:33.063742432 +0200
@@ -1368,8 +1368,8 @@
 
 static inline void convert_bgcolor_16(u32 *col)
 {
-	*col = ((*col & 0x00007C00) << 9)
-		| ((*col & 0x000003E0) << 6)
+	*col = ((*col & 0x0000F800) << 8)
+		| ((*col & 0x000007E0) << 5)
 		| ((*col & 0x0000001F) << 3)
 		|	   0xFF000000;
 }

--0OAP2g/MAC+5xKAE--
