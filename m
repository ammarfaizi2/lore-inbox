Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751003AbVKEVUT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751003AbVKEVUT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 16:20:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751006AbVKEVUT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 16:20:19 -0500
Received: from mailfe08.tele2.fr ([212.247.154.236]:37047 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S1750950AbVKEVUT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 16:20:19 -0500
X-T2-Posting-ID: dCnToGxhL58ot4EWY8b+QGwMembwLoz1X2yB7MdtIiA=
Date: Sat, 5 Nov 2005 22:19:50 +0100
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org
Cc: mlang@debian.org
Subject: [PATCH] Set the vga cursor even when hidden
Message-ID: <20051105211949.GM7383@bouh.residence.ens-lyon.fr>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org,
	mlang@debian.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i-nntp
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Some visually impaired people use hardware devices which directly read
the vga screen. When newt for instance asks to hide the cursor for
better visual aspect, the kernel puts the vga cursor out of the screen,
so that the cursor position can't be read by the hardware device. This
is a great loss for such people.

Here is a patch which uses the same technique as CUR_NONE for hiding the
cursor while still moving it.

Mario, you should apply it to the speakup kernel for access floppies
asap. I'll submit a 2.4 patch too.

Signed-off-by: samuel.thibault@ens-lyon.org

--- linux/drivers/video/console/vgacon.c.orig	2005-11-05 21:51:03.000000000 +0100
+++ linux/drivers/video/console/vgacon.c	2005-11-05 21:51:31.000000000 +0100
@@ -448,7 +448,8 @@ static void vgacon_cursor(struct vc_data
 		vgacon_scrolldelta(c, 0);
 	switch (mode) {
 	case CM_ERASE:
-		write_vga(14, (vga_vram_end - vga_vram_base - 1) / 2);
+		write_vga(14, (c->vc_pos - vga_vram_base) / 2);
+		vgacon_set_cursor_size(c->vc_x, 31, 30);
 		break;
 
 	case CM_MOVE:

Regards,
Samuel Thibault
