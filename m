Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261899AbVCGXiY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261899AbVCGXiY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 18:38:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261771AbVCGXgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 18:36:46 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:41992 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261824AbVCGXHF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 18:07:05 -0500
Date: Tue, 8 Mar 2005 00:07:03 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Jesper Juhl <juhl-lkml@dif.dk>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] sound/oss/soundcard.c: remove an unused variable
Message-ID: <20050307230703.GK3170@stusta.de>
References: <20050304033215.1ffa8fec.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050304033215.1ffa8fec.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2005 at 03:32:15AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.11-rc5-mm1:
>...
> +verify_area-cleanup-sound.patch
>...
>  Replace verify_area() with access_ok() in lots of places.
>...


This causes the following compile warning:

<--  snip  -->

...
  CC      sound/oss/soundcard.o
sound/oss/soundcard.c: In function `sound_ioctl':
sound/oss/soundcard.c:332: warning: unused variable `err'
...

<--  snip  -->

Trivial fix:


<--  snip  -->


This patch removes an unused variable.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.11-mm1-full/sound/oss/soundcard.c.old	2005-03-07 23:52:35.000000000 +0100
+++ linux-2.6.11-mm1-full/sound/oss/soundcard.c	2005-03-07 23:52:42.000000000 +0100
@@ -329,7 +329,7 @@
 static int sound_ioctl(struct inode *inode, struct file *file,
 		       unsigned int cmd, unsigned long arg)
 {
-	int err, len = 0, dtype;
+	int len = 0, dtype;
 	int dev = iminor(inode);
 	void __user *p = (void __user *)arg;
 

