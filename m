Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273909AbTHPPvh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 11:51:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274788AbTHPPvg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 11:51:36 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:16092 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S273909AbTHPPvf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 11:51:35 -0400
Date: Sat, 16 Aug 2003 11:50:23 -0400
From: Chris Heath <chris@heathens.co.nz>
To: jsimmons@infradead.org
Subject: Re:FBDEV updates.
Cc: linux-kernel@vger.kernel.org
In-Reply-To: Pine.LNX.4.44.0308142052440.15200-100000@phoenix.infradead.org
Message-Id: <20030816114422.1E63.CHRIS@heathens.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.06.02
X-Antirelay: Good relay from local net1 127.0.0.1/32
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James,

I am still seeing a lot of cursors being left behind.  It is not a race
condition or anything -- in the TTY line editor, it happens about 50% of
the time when you press backspace.

What appears to be happening is the cursor is flashing twice as slowly
as the driver thinks it is, so of course it's wrong half the time when
it comes to erase the cursor.

The patch below fixes it for me.

Chris


--- a/drivers/video/softcursor.c	2003-08-16 11:39:51.000000000 -0400
+++ b/drivers/video/softcursor.c	2003-08-16 11:29:43.000000000 -0400
@@ -74,6 +74,12 @@
 		
 	if (info->cursor.image.data)
 		info->fbops->fb_imageblit(info, &info->cursor.image);
+
+	if (!info->cursor.enable) {
+		for (i = 0; i < size; i++)
+			dst[i] ^= info->cursor.mask[i]; 
+	}
+
 	return 0;
 }
 

