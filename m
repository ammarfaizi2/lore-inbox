Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262540AbULDMwa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262540AbULDMwa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 07:52:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262541AbULDMwa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 07:52:30 -0500
Received: from king.bitgnome.net ([66.207.162.30]:55509 "EHLO
	king.bitgnome.net") by vger.kernel.org with ESMTP id S262540AbULDMwW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 07:52:22 -0500
Date: Sat, 4 Dec 2004 06:52:05 -0600
From: Mark Nipper <nipsy@bitgnome.net>
To: linux-kernel@vger.kernel.org
Subject: Re: reiser4 crash
Message-ID: <20041204125205.GA56863@king.bitgnome.net>
References: <41B1A3AA.5060703@benton987.fsnet.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
In-Reply-To: <41B1A3AA.5060703@benton987.fsnet.co.uk>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 04 Dec 2004, Andrew Benton wrote:
> I've been using reiser4 for a couple of months. A couple of days ago I
> did something stupid with Abiword, the disk started thrashing and as the
> system crashed it left this on the screen
<snipped>

	Which if you are trying to patch this against the current
Namesys 2.6.10-rc1 patches requires Saveliev's previous patch
from a couple of weeks ago which I've also attached to this
thread now as I'm in the middle of upgrading to 2.6.10-rc3 and
had to go looking for the previous patch myself.  :)

-- 
Mark Nipper                                                e-contacts:
4475 Carter Creek Parkway                           nipsy@bitgnome.net
Apartment 724                               http://nipsy.bitgnome.net/
Bryan, Texas, 77802-4481           AIM/Yahoo: texasnipsy ICQ: 66971617
(979)575-3193                                      MSN: nipsy@tamu.edu

-----BEGIN GEEK CODE BLOCK-----
Version: 3.1
GG/IT d- s++:+ a- C++$ UBL++++$ P--->+++ L+++$ !E---
W++(--) N+ o K++ w(---) O++ M V(--) PS+++(+) PE(--)
Y+ PGP t+ 5 X R tv b+++@ DI+(++) D+ G e h r++ y+(**)
------END GEEK CODE BLOCK------

---begin random quote of the moment---
"I know the forces of spontaneous, emergent life are stronger
than the forces of evil, repression and death, and the forces of
death will destroy themselves."
 -- William S. Burroughs
----end random quote of the moment----

--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="1.1755"

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/11/15 16:23:47+03:00 vs@tribesman.namesys.com 
#   unix_file_filemap_nopage: missing context creation is added
# 
# plugin/file/file.c
#   2004/11/15 16:23:45+03:00 vs@tribesman.namesys.com +5 -1
#   unix_file_filemap_nopage: missing context creation is added
# 
diff -Nru a/plugin/file/file.c b/plugin/file/file.c
--- a/plugin/file/file.c	2004-11-17 09:36:11 +03:00
+++ b/plugin/file/file.c	2004-11-17 09:36:11 +03:00
@@ -1961,8 +1961,10 @@
 {
 	struct page *page;
 	struct inode *inode;
-
+	reiser4_context ctx;
+	
 	inode = area->vm_file->f_dentry->d_inode;
+	init_context(&ctx, inode->i_sb);
 
 	/* block filemap_nopage if copy on capture is processing with a node of this file */
 	down_read(&reiser4_inode_data(inode)->coc_sem);
@@ -1972,6 +1974,8 @@
 
 	drop_nonexclusive_access(unix_file_inode_data(inode));
 	up_read(&reiser4_inode_data(inode)->coc_sem);
+
+	reiser4_exit_context(&ctx);
 	return page;
 }
 

--PNTmBPCT7hxwcZjr--
