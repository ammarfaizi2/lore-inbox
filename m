Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263678AbUJ3KQg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263678AbUJ3KQg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 06:16:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263679AbUJ3KQg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 06:16:36 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:31501 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263678AbUJ3KQe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 06:16:34 -0400
Date: Sat, 30 Oct 2004 11:16:30 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, michael@mihu.de
Subject: [PATCH] saa7111.c: fix VIDEO_MODE_SECAM
Message-ID: <20041030111629.A11909@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, michael@mihu.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(untested since I do not have any SECAM tv sources.)

VIDEO_MODE_SECAM was incorrectly writing the contents of cached
register 14 back to hardware register 8, rather than using cached
register 8.

Signed-off-by: Russell King <rmk@arm.linux.org.uk>

diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x *.orig -x *.rej orig/drivers/media/video/saa7111.c linux/drivers/media/video/saa7111.c
--- orig/drivers/media/video/saa7111.c	Mon May 24 11:25:07 2004
+++ linux/drivers/media/video/saa7111.c	Sat Oct 30 11:13:09 2004
@@ -342,7 +342,7 @@ saa7111_command (struct i2c_client *clie
 
 		case VIDEO_MODE_SECAM:
 			saa7111_write(client, 0x08,
-				      (decoder->reg[0x0e] & 0x3f) | 0x00);
+				      (decoder->reg[0x08] & 0x3f) | 0x00);
 			saa7111_write(client, 0x0e,
 				      (decoder->reg[0x0e] & 0x8f) | 0x50);
 			break;

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
