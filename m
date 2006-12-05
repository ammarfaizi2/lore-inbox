Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968302AbWLEPP7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968302AbWLEPP7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 10:15:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968295AbWLEPP6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 10:15:58 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:47385 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968301AbWLEPP6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 10:15:58 -0500
Date: Tue, 5 Dec 2006 10:13:24 -0500
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
       hch@infradead.org, viro@ftp.linux.org.uk, linux-fsdevel@vger.kernel.org,
       mhalcrow@us.ibm.com
Subject: Re: Unionfs: Stackable namespace unification filesystem
Message-ID: <20061205151323.GC20520@filer.fsl.cs.sunysb.edu>
References: <1165235468365-git-send-email-jsipek@cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1165235468365-git-send-email-jsipek@cs.sunysb.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2006 at 07:30:33AM -0500, Josef 'Jeff' Sipek wrote:
> The following patches are in a git repo at:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/jsipek/unionfs.git
> 
> (master.kernel.org:/pub/scm/linux/kernel/git/jsipek/unionfs.git)
> 
> The repository contains the following 35 commits (also available as patches
> in replies to this email).
 
Wow, I completely forgot to say what changed since the previous posting...

- Added more comments (akpm)
- Cleaned up inode/dentry/file/sb private data structure member names
- Moved struct inode from unionfs_inode_container into unionfs_inode_info
	(following ext2's example)
- Renamed {d,i,f,s}topd to UNIONFS_{D,I,F,S} (following almost any fs's
	example)
- Removed *_ptr and *_lhs macros, open-coding the assignments (Pekka Enberg)
- Kill wrappers (e.g., unionfs_kill_block_super) (Pekka Enberg)
- Few tiny coding style fixes
- Removed some unnecessary complexity (no need to pass struct file and a
	struct dentry for that file to a function - just pass a struct file
	and dereference in the function, etc.)
- Removed some unnecessary checks (if (foo) kfree(foo); is completely
	redundant as kfree has a null check)
- Changed C++-style comments to C-style comments (Pekka Enberg)
- Use struct kmem_cache instead of kmem_cache_t (Pekka Enberg)
- Use anonymous unions for sioq (Jan Engelhardt)
- Moved some functionality into fsstack (most of it is in -mm already)

All in all about 1/8th of the code was touched in one way or another.
 
Josef "Jeff" Sipek.
