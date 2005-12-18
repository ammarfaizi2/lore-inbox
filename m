Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965274AbVLRUG7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965274AbVLRUG7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 15:06:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965277AbVLRUG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 15:06:59 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:13061 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965274AbVLRUG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 15:06:58 -0500
Date: Sun, 18 Dec 2005 21:06:59 +0100
From: Adrian Bunk <bunk@stusta.de>
To: urban@teststation.com
Cc: samba@samba.org, linux-kernel@vger.kernel.org, macro@linux-mips.org,
       marcelo.tosatti@cyclades.com
Subject: [patch] fs/smbfs/proc.c: fix data corruption in smb_proc_setattr_unix()
Message-ID: <20051218200659.GL23349@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maciej W. Rozycki <macro@linux-mips.org>


This patch fixes a data corruption in smb_proc_setattr_unix() 
(smb_filetype_from_mode() returns an u32, and there are only four bytes 
reserved for it in data.

Signed-off-by: Adrian Bunk <bunk@stusta.de>


--- linux-2.6.14-rc3-git3/fs/smbfs/proc.c	2005-10-04 19:24:37.000000000 +1000
+++ .6877.trivial/fs/smbfs/proc.c	2005-10-04 19:29:50.000000000 +1000
@@ -3113,7 +3113,7 @@ smb_proc_setattr_unix(struct dentry *d, 
 	LSET(data, 32, SMB_TIME_NO_CHANGE);
 	LSET(data, 40, SMB_UID_NO_CHANGE);
 	LSET(data, 48, SMB_GID_NO_CHANGE);
-	LSET(data, 56, smb_filetype_from_mode(attr->ia_mode));
+	DSET(data, 56, smb_filetype_from_mode(attr->ia_mode));
 	LSET(data, 60, major);
 	LSET(data, 68, minor);
 	LSET(data, 76, 0);

