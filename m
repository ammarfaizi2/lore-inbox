Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287585AbSAEHls>; Sat, 5 Jan 2002 02:41:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287582AbSAEHli>; Sat, 5 Jan 2002 02:41:38 -0500
Received: from ns1.yggdrasil.com ([209.249.10.20]:8156 "EHLO ns1.yggdrasil.com")
	by vger.kernel.org with ESMTP id <S287585AbSAEHla>;
	Sat, 5 Jan 2002 02:41:30 -0500
Date: Fri, 4 Jan 2002 23:41:28 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: bcollins@debian.org, andreas.bombe@munich.netsurf.de,
        linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Patch: linux-2.5.2-pre8/drivers/ieee1394 kdev_t compilation fixes
Message-ID: <20020104234128.A26076@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	The following patch fixes the kdev_t compilation errors
in linux-2.5.2-pre8/drivers/ieee1394.  It just a global replace
of "MINOR(" with "minor(".  I only know that the new code compiles.
I have not tested it.

	Also my drivers/ieee1394 is slightly different from the
stock kernel (some code cleanup), so you may get a few messages from
patch about it.  However, I believe the areas relevant to this patch
are all the same.

-- 
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ieee1394.diffs"

--- linux/drivers/ieee1394/pcilynx.c	2001/11/15 02:58:40	1.17
+++ linux/drivers/ieee1394/pcilynx.c	2002/01/05 07:34:25
@@ -764,7 +764,7 @@
 
 static int mem_open(struct inode *inode, struct file *file)
 {
-        int cid = MINOR(inode->i_rdev);
+        int cid = minor(inode->i_rdev);
         enum { t_rom, t_aux, t_ram } type;
         struct memdata *md;
 	struct hpsb_host *host = hpsb_find_host(&lynx_template, cid);
--- linux/drivers/ieee1394/raw1394.c	2001/11/29 02:39:38	1.1.1.16
+++ linux/drivers/ieee1394/raw1394.c	2002/01/05 07:34:25
@@ -915,7 +915,7 @@
 {
         struct file_info *fi;
 
-        if (MINOR(inode->i_rdev)) {
+        if (minor(inode->i_rdev)) {
                 return -ENXIO;
         }
 
--- linux/drivers/ieee1394/video1394.c	2002/01/01 00:02:21	1.11
+++ linux/drivers/ieee1394/video1394.c	2002/01/05 07:34:25
@@ -850,7 +850,7 @@
 		struct video_card *p;
 		list_for_each(lh, &video1394_cards) {
 			p = list_entry(lh, struct video_card, list);
-			if (p->id == MINOR(inode->i_rdev)) {
+			if (p->id == minor(inode->i_rdev)) {
 				video = p;
 				break;
 			}
@@ -859,7 +859,7 @@
 	spin_unlock_irqrestore(&video1394_cards_lock, flags);
 
 	if (video == NULL) {
-		PRINT_G(KERN_ERR, __FUNCTION__": Unknown video card for minor %d", MINOR(inode->i_rdev));
+		PRINT_G(KERN_ERR, __FUNCTION__": Unknown video card for minor %d", minor(inode->i_rdev));
 		return -EFAULT;
 	}
 
@@ -1328,7 +1328,7 @@
 		struct video_card *p;
 		list_for_each(lh, &video1394_cards) {
 			p = list_entry(lh, struct video_card, list);
-			if (p->id == MINOR(file->f_dentry->d_inode->i_rdev)) {
+			if (p->id == minor(file->f_dentry->d_inode->i_rdev)) {
 				video = p;
 				break;
 			}
@@ -1338,7 +1338,7 @@
 
 	if (video == NULL) {
 		PRINT_G(KERN_ERR, __FUNCTION__": Unknown video card for minor %d",
-			MINOR(file->f_dentry->d_inode->i_rdev));
+			minor(file->f_dentry->d_inode->i_rdev));
 		return -EFAULT;
 	}
 
@@ -1357,7 +1357,7 @@
 
 static int video1394_open(struct inode *inode, struct file *file)
 {
-	int i = MINOR(inode->i_rdev);
+	int i = minor(inode->i_rdev);
 	unsigned long flags;
 	struct video_card *video = NULL;
 	struct list_head *lh;
@@ -1397,7 +1397,7 @@
 		struct video_card *p;
 		list_for_each(lh, &video1394_cards) {
 			p = list_entry(lh, struct video_card, list);
-			if (p->id == MINOR(inode->i_rdev)) {
+			if (p->id == minor(inode->i_rdev)) {
 				video = p;
 				break;
 			}
@@ -1407,7 +1407,7 @@
 
 	if (video == NULL) {
 		PRINT_G(KERN_ERR, __FUNCTION__": Unknown device for minor %d",
-				MINOR(inode->i_rdev));
+				minor(inode->i_rdev));
 		return 1;
 	}
 

--pf9I7BMVVzbSWLtt--
