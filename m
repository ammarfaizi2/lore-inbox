Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752223AbWCJWZu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752223AbWCJWZu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 17:25:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752220AbWCJWZX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 17:25:23 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:13060 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1752214AbWCJWZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 17:25:07 -0500
Date: Fri, 10 Mar 2006 23:25:06 +0100
From: Adrian Bunk <bunk@stusta.de>
To: gregkh@suse.de
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/usb/media/vicam.c: fix a NULL pointer dereference
Message-ID: <20060310222506.GA21864@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a NULL pointer dereference spotted by the Coverity 
checker.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.16-rc5-mm3-full/drivers/usb/media/vicam.c.old	2006-03-10 20:54:17.000000000 +0100
+++ linux-2.6.16-rc5-mm3-full/drivers/usb/media/vicam.c	2006-03-10 20:54:44.000000000 +0100
@@ -758,18 +758,19 @@ vicam_open(struct inode *inode, struct f
 {
 	struct video_device *dev = video_devdata(file);
 	struct vicam_camera *cam =
 	    (struct vicam_camera *) dev->priv;
 	DBG("open\n");
 
 	if (!cam) {
 		printk(KERN_ERR
 		       "vicam video_device improperly initialized");
+		return -EINVAL;
 	}
 
 	/* the videodev_lock held above us protects us from
 	 * simultaneous opens...for now. we probably shouldn't
 	 * rely on this fact forever.
 	 */
 
 	if (cam->open_count > 0) {
 		printk(KERN_INFO

