Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262932AbTDFMSp (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 08:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262939AbTDFMSp (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 08:18:45 -0400
Received: from pat.uio.no ([129.240.130.16]:36345 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262932AbTDFMSo (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 08:18:44 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16016.7633.982870.860147@charged.uio.no>
Date: Sun, 6 Apr 2003 14:30:09 +0200
To: SteveD@RedHat.com
Cc: nfs@lists.sourceforge.net, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [NFS] [PATCH] mmap corruption
In-Reply-To: <20030405164741.GA6450@RedHat.com>
References: <3E8DDB13.9020009@RedHat.com>
	<shsistt7wip.fsf@charged.uio.no>
	<20030405164741.GA6450@RedHat.com>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Steve Dickson <SteveD@RedHat.com> writes:

     > 	filemap_fdatasync(inode->i_mapping);
     > 	error = nfs_wb_all(inode);
     > 	filemap_fdatawait(inode->i_mapping);
     > 	if (error)
     > 		goto out;

     > 	/*
     > * Every time either npages or ncommit had a value and the file
     > 	   size is
     > * immediately changed (with in a microsecond or two) by another
     > * truncation, followed by a mmap read, the file would be
     > 	   corrupted.
     > 	 */
     > 	if (NFS_I(inode)->npages || NFS_I(inode)->ncommit ||
     > 	NFS_I(inode)->ndirty) {
     > 		printk("nfs_notify_change: fid %Ld npages %d ncommit
     > 		%d ndirty %d\n", NFS_FILEID(inode),
     > 		NFS_I(inode)->npages, ncommit, NFS_I(inode)->ndirty);
     > 	}
     > }

My point is that nfs_wb_all() is supposed to ensure that
NFS_I(inode)->ncommit, and/or NFS_I(inode)->ndirty are both
zero. i.e. you can have pending reads (in which case
NFS_I(inode)->npages != 0), but *no* pending writes.

Was this the case?

Cheers,
  Trond
