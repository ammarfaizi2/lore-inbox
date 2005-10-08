Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161032AbVJHBEj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161032AbVJHBEj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 21:04:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161033AbVJHBEj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 21:04:39 -0400
Received: from smtp3.brturbo.com.br ([200.199.201.164]:45784 "EHLO
	smtp3.brturbo.com.br") by vger.kernel.org with ESMTP
	id S1161032AbVJHBEj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 21:04:39 -0400
Date: Fri, 07 Oct 2005 22:04:28 -0300
From: mchehab@brturbo.com.br
To: linux-kernel@vger.kernel.org
Cc: video4linux-list@redhat.com, akpm@osdl.org
Subject: [PATCH 1/2] V4L: Cleanup cx88 - fix sparse warnings
Message-ID: <43471b1c.Mnuza9xX/yszpHLa%mchehab@brturbo.com.br>
User-Agent: nail 11.25 7/29/05
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Hagervall <hager@cs.umu.se>

* cx88-core.c: (cx88_risc_decode):
* cx88-video.c: (video_read):
* cx88.h:
- Fix a number of sparse warnings.

Signed-off-by: Peter Hagervall <hager@cs.umu.se>
Signed-off-by: Michael Krufky <mkrufky@m1k.net>
Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>

cx88-core.c  |    2 +-
cx88-video.c |    2 +-
cx88.h       |    4 ++--
3 files changed, 4 insertions(+), 4 deletions(-)

diff -upr linux-2.6.14-rc3-git7/drivers/media/video/cx88/cx88-core.c linux/drivers/media/video/cx88/cx88-core.c
--- linux-2.6.14-rc3-git7/drivers/media/video/cx88/cx88-core.c	2005-10-07 14:54:38.925664951 -0500
+++ linux/drivers/media/video/cx88/cx88-core.c	2005-10-07 15:59:18.079770381 -0500
@@ -431,7 +431,7 @@ int cx88_sram_channel_setup(struct cx88_
 /* ------------------------------------------------------------------ */
 /* debug helper code                                                  */
 
-int cx88_risc_decode(u32 risc)
+static int cx88_risc_decode(u32 risc)
 {
 	static char *instr[16] = {
 		[ RISC_SYNC    >> 28 ] = "sync",
diff -upr linux-2.6.14-rc3-git7/drivers/media/video/cx88/cx88.h linux/drivers/media/video/cx88/cx88.h
--- linux-2.6.14-rc3-git7/drivers/media/video/cx88/cx88.h	2005-10-07 14:54:38.933661977 -0500
+++ linux/drivers/media/video/cx88/cx88.h	2005-10-07 15:59:18.082769261 -0500
@@ -203,8 +203,8 @@ struct cx88_board {
 	int                     tda9887_conf;
 	struct cx88_input       input[MAX_CX88_INPUT];
 	struct cx88_input       radio;
-	int                     blackbird:1;
-	int                     dvb:1;
+	unsigned int            blackbird:1;
+	unsigned int            dvb:1;
 };
 
 struct cx88_subid {
diff -upr linux-2.6.14-rc3-git7/drivers/media/video/cx88/cx88-video.c linux/drivers/media/video/cx88/cx88-video.c
--- linux-2.6.14-rc3-git7/drivers/media/video/cx88/cx88-video.c	2005-10-07 14:54:38.932662349 -0500
+++ linux/drivers/media/video/cx88/cx88-video.c	2005-10-07 15:59:18.081769635 -0500
@@ -787,7 +787,7 @@ static int video_open(struct inode *inod
 }
 
 static ssize_t
-video_read(struct file *file, char *data, size_t count, loff_t *ppos)
+video_read(struct file *file, char __user *data, size_t count, loff_t *ppos)
 {
 	struct cx8800_fh *fh = file->private_data;
 
