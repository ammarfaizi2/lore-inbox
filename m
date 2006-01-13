Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161652AbWAMDYO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161652AbWAMDYO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 22:24:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161659AbWAMDTj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 22:19:39 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:18816 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1161655AbWAMDTf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 22:19:35 -0500
Message-Id: <20060113032239.017057000@sorel.sous-sol.org>
References: <20060113032102.154909000@sorel.sous-sol.org>
Date: Thu, 12 Jan 2006 18:37:40 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org, johnpol@2ka.mipt.ru,
       mm-commits@vger.kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       " Greg Kroah-Hartman " <gregkh@suse.de>
Subject: [PATCH 02/17] UFS: inode->i_sem is not released in error path
Content-Disposition: inline; filename=ufs-inode-i_sem-is-not-released-in-error-path.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

---

 fs/ufs/super.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

Index: linux-2.6.15.y/fs/ufs/super.c
===================================================================
--- linux-2.6.15.y.orig/fs/ufs/super.c
+++ linux-2.6.15.y/fs/ufs/super.c
@@ -1296,8 +1296,10 @@ static ssize_t ufs_quota_write(struct su
 		blk++;
 	}
 out:
-	if (len == towrite)
+	if (len == towrite) {
+		up(&inode->i_sem);
 		return err;
+	}
 	if (inode->i_size < off+len-towrite)
 		i_size_write(inode, off+len-towrite);
 	inode->i_version++;

--
