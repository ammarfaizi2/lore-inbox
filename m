Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750880AbWCBCyI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750880AbWCBCyI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 21:54:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbWCBCyI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 21:54:08 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:5314 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750880AbWCBCyH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 21:54:07 -0500
Date: Thu, 2 Mar 2006 02:54:06 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Joshua Hudson <joshudson@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Possible deadlock in vfs layer, namei.c
Message-ID: <20060302025406.GV27946@ftp.linux.org.uk>
References: <bda6d13a0603011846s6bfed498ha9fb78c4ba74963c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bda6d13a0603011846s6bfed498ha9fb78c4ba74963c@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2006 at 06:46:42PM -0800, Joshua Hudson wrote:
> I've been hunting down various deadlocks caused by hard links to directories.
> I found one that can happen *without* such things.
 
> process 1 does: rename("dir/subdir/file", "dir/file")
> process 2 does: rmdir("dir/subdir")
> 
> from namei.c (function: lock_rename), rename takes:
> 1. s_vfs_rename_sem,
> 2. dir/subdir: p1->d_inode->i_sem
> 3. dir: p2->d_inode->i_sem

No, it doesn't.  Wrong order - it will take dir before dir/subdir.
RTFM - Documentation/filesystems/directory-locking is there for
purpose.
