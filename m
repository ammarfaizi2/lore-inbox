Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755101AbWKLNRq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755101AbWKLNRq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 08:17:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755103AbWKLNRq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 08:17:46 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:15367 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1755100AbWKLNRp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 08:17:45 -0500
Date: Sun, 12 Nov 2006 14:17:48 +0100
From: Adrian Bunk <bunk@stusta.de>
To: neilb@cse.unsw.edu.au
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] include/linux/nfsd/nfsfh.h: fix a NULL
Message-ID: <20061112131748.GI25057@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dereference
Reply-To: 
Fcc: =sent-mail

When we know fhp->fh_dentry is NULL, a code path where it's being 
dereferenced isn't a good choice.

Spotted by the coverity checker.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6/include/linux/nfsd/nfsfh.h.old	2006-11-12 14:13:34.000000000 +0100
+++ linux-2.6/include/linux/nfsd/nfsfh.h	2006-11-12 14:13:49.000000000 +0100
@@ -330,8 +330,7 @@ fh_unlock(struct svc_fh *fhp)
 {
 	if (!fhp->fh_dentry)
 		printk(KERN_ERR "fh_unlock: fh not verified!\n");
-
-	if (fhp->fh_locked) {
+	else if (fhp->fh_locked) {
 		fill_post_wcc(fhp);
 		mutex_unlock(&fhp->fh_dentry->d_inode->i_mutex);
 		fhp->fh_locked = 0;

