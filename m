Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263622AbTDDLK3 (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 06:10:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263624AbTDDLK2 (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 06:10:28 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:65251 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id S263622AbTDDLG7 (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 06:06:59 -0500
Date: Fri, 4 Apr 2003 13:17:15 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [PATCH] interlaced packed pixels
Message-ID: <Pine.GSO.4.21.0304041310440.1720-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi,

I'd like to introduce a new frame buffer type to accommodate packed pixel frame
buffers that store the even and odd fields separately. This is typically used
in graphics hardware for TV output (e.g. set-top boxes).

--- linux-2.4.21-pre6/include/linux/fb.h.orig	Tue Apr 16 10:21:43 2002
+++ linux-2.4.21-pre6/include/fb.h	Fri Apr  4 13:14:19 2003
@@ -38,6 +38,7 @@
 #define FB_TYPE_INTERLEAVED_PLANES	2	/* Interleaved planes	*/
 #define FB_TYPE_TEXT			3	/* Text/attributes	*/
 #define FB_TYPE_VGA_PLANES		4	/* EGA/VGA planes	*/
+#define FB_TYPE_PACKED_PIXELS_LACED	5	/* Interlaced Packed Pixels */
 
 #define FB_AUX_TEXT_MDA		0	/* Monochrome text */
 #define FB_AUX_TEXT_CGA		1	/* CGA/EGA/VGA Color text */
@@ -115,6 +117,8 @@
 	__u32 smem_len;			/* Length of frame buffer mem */
 	__u32 type;			/* see FB_TYPE_*		*/
 	__u32 type_aux;			/* Interleave for interleaved Planes */
+					/* Offset to odd field for      */
+					/* interlaced packed pixels */
 	__u32 visual;			/* see FB_VISUAL_*		*/ 
 	__u16 xpanstep;			/* zero if no hardware panning  */
 	__u16 ypanstep;			/* zero if no hardware panning  */

The patch applies to both 2.4.x and 2.5.x.

Any comments?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

