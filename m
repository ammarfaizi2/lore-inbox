Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932073AbWJREXh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932073AbWJREXh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 00:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932072AbWJREXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 00:23:37 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:9644 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S932067AbWJREXg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 00:23:36 -0400
Date: Wed, 18 Oct 2006 00:23:23 -0400
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, hch@infradead.org, viro@ftp.linux.org.uk,
       mhalcrow@us.ibm.com, penberg@cs.helsinki.fi,
       linux-fsdevel@vger.kernel.org
Subject: fsstack: struct path
Message-ID: <20061018042323.GA8537@filer.fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Few weeks ago, I noticed that fs/namei.c defines struct path:

struct path {
	struct vfsmount *mnt;
	struct dentry *dentry;
};

I think it would make sense to move it into include/linux/ as it is quite
useful (and it would discourage the (ab)use of struct nameidata.)

The fsstack code could benefit from it as the stackable fs dentries have to
keep track of the lower dentry as well as the lower vfsmount.

One, rather unfortunate, fact is that struct path is also defined in
include/linux/reiserfs_fs.h as something completely different - reiserfs
specific.

Any thoughts?

Josef "Jeff" Sipek.

-- 
I already backed up the box once, I can do it again.
