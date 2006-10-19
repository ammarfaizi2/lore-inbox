Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945974AbWJSBs5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945974AbWJSBs5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 21:48:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945971AbWJSBsj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 21:48:39 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:16873 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S1945965AbWJSBse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 21:48:34 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 0 of 4] fsstack: struct path
Message-Id: <patchbomb.1161219427@thor.fsl.cs.sunysb.edu>
Date: Wed, 18 Oct 2006 20:57:07 -0400
From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, akpm@osdl.org, hch@infradead.org,
       viro@ftp.linux.org.uk, mhalcrow@us.ibm.com, chris.mason@oracle.com,
       ezk@cs.sunysb.edu, penberg@cs.helsinki.fi, dm-devel@redhat.com,
       mingo@redhat.com, reiserfs-dev@namesys.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patches attempt to fix up the problems with 'struct path' as
discussed in the 'fsstack: struct path' thread on linux-kernel. The net
effect is moving struct path from fs/namei.c to include/linux/namei.h, as it
is quite useful (and it will discourage the (ab)use of struct nameidata.)

The fsstack code benefits from it as the stackable fs dentries have to keep
track of the lower dentry as well as the lower vfsmount.

The first two patches rename Reiserfs's 'struct path' to 'struct treepath',
and Device Mapper's 'struct path' to 'struct dm_path', respectively.

The third patch moves struct path from fs/namei.c to include/linux/namei.h,
making it accessible to any part of the VFS as well as other parts of the
kernel - stackable filesystem like eCryptfs and Unionfs come to mind.

The fourth patch converts eCryptfs's dentry-vfsmount pairs in the dentry
private data to struct path.

Signed-off-by: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>


