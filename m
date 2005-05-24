Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262014AbVEXMUX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262014AbVEXMUX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 08:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262023AbVEXMUX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 08:20:23 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:20637 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S262014AbVEXMUQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 08:20:16 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Tue, 24 May 2005 14:17:47 +0200
From: Gerd Knorr <kraxel@suse.de>
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       video4linux list <video4linux-list@redhat.com>
Subject: [patch] v4l: bttv i2c oops fix
Message-ID: <20050524121747.GA9440@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don't try to access the i2c bus if the register wasn't successful.

Signed-off-by: Gerd Knorr <kraxel@suse.de>
---
 drivers/media/video/bttv-i2c.c |    3 +++
 1 files changed, 3 insertions(+)

Index: linux-2.6.12-rc3/drivers/media/video/bttv-i2c.c
===================================================================
--- linux-2.6.12-rc3.orig/drivers/media/video/bttv-i2c.c	2005-04-26 12:18:56.000000000 +0200
+++ linux-2.6.12-rc3/drivers/media/video/bttv-i2c.c	2005-05-24 14:17:01.000000000 +0200
@@ -365,6 +365,9 @@ int bttv_I2CWrite(struct bttv *btv, unsi
 /* read EEPROM content */
 void __devinit bttv_readee(struct bttv *btv, unsigned char *eedata, int addr)
 {
+	memset(eedata, 0, 256);
+	if (0 != btv->i2c_rc)
+		return;
 	btv->i2c_client.addr = addr >> 1;
 	tveeprom_read(&btv->i2c_client, eedata, 256);
 }

-- 
-mm seems unusually stable at present.
	-- akpm about 2.6.12-rc3-mm3
