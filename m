Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278617AbRKAJjN>; Thu, 1 Nov 2001 04:39:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278629AbRKAJjC>; Thu, 1 Nov 2001 04:39:02 -0500
Received: from island.mx1.ru ([212.5.121.238]:28683 "EHLO island.mx1.ru")
	by vger.kernel.org with ESMTP id <S278617AbRKAJi4>;
	Thu, 1 Nov 2001 04:38:56 -0500
Date: Thu, 1 Nov 2001 12:38:59 +0300
From: Stepan Koltsov <yozh@island.mx1.ru>
To: linux-kernel@vger.kernel.org
Subject: small bug? in drivers/video/vgacon.c
Message-ID: <20011101123750.A21051@island.mx1.ru>
Reply-To: Stepan Koltsov <yozh@mx1.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Function drivers/video/vgacon.c:vgacon_scrolldelta() doesn't work
when get 1 or -1 as 2nd arg (it doesn't scroll).
This bug can be seen rarely, cos usually this func never called with 1 or -1.
I don't quite understand, how this func works :-) but vgacon_scrolldelta
works properly with this small patch.

diff -ur linux-2.4.12-orig/drivers/video/vgacon.c linux-2.4.12/drivers/video/vgacon.c
--- linux-2.4.12-orig/drivers/video/vgacon.c	Fri Sep 14 03:04:43 2001
+++ linux-2.4.12/drivers/video/vgacon.c	Sat Oct 20 19:29:20 2001
@@ -931,7 +931,7 @@
 		c->vc_visible_origin = c->vc_origin;
 	else {
 		int vram_size = vga_vram_end - vga_vram_base;
-		int margin = c->vc_size_row * 4;
+		int margin = c->vc_size_row;
 		int ul, we, p, st;
 
 		if (vga_rolled_over > (c->vc_scr_end - vga_vram_base) + margin) {

-- 
mailto:yozh@mx1.ru
ICQ:26521795

