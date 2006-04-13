Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964998AbWDMXLl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964998AbWDMXLl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 19:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965018AbWDMXLI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 19:11:08 -0400
Received: from cantor2.suse.de ([195.135.220.15]:2511 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964998AbWDMXKD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 19:10:03 -0400
Date: Thu, 13 Apr 2006 16:09:02 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Jes Sorensen <jes@sgi.com>, Nathan Scott <nathans@sgi.com>
Subject: [patch 16/22] Fix utime(2) in the case that no times parameter was passed in.
Message-ID: <20060413230902.GQ5613@kroah.com>
References: <20060413230141.330705000@quad.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="XFS-Fix-utime-2-in-the-case-that-no-times-parameter-was-passed-in.patch"
In-Reply-To: <20060413230637.GA5613@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------

SGI-PV: 949858
SGI-Modid: xfs-linux-melb:xfs-kern:25717a

Signed-off-by: Jes Sorensen <jes@sgi.com>
Signed-off-by: Nathan Scott <nathans@sgi.com>

---

 fs/xfs/linux-2.6/xfs_iops.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

8c0b5113a55c698f3190ec85925815640f1c2049
--- linux-2.6.16.5.orig/fs/xfs/linux-2.6/xfs_iops.c
+++ linux-2.6.16.5/fs/xfs/linux-2.6/xfs_iops.c
@@ -673,8 +673,7 @@ linvfs_setattr(
 	if (ia_valid & ATTR_ATIME) {
 		vattr.va_mask |= XFS_AT_ATIME;
 		vattr.va_atime = attr->ia_atime;
-		if (ia_valid & ATTR_ATIME_SET)
-			inode->i_atime = attr->ia_atime;
+		inode->i_atime = attr->ia_atime;
 	}
 	if (ia_valid & ATTR_MTIME) {
 		vattr.va_mask |= XFS_AT_MTIME;

--
