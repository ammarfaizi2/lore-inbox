Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261891AbVCZAgB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261891AbVCZAgB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 19:36:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261893AbVCZAgA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 19:36:00 -0500
Received: from hera.kernel.org ([209.128.68.125]:1216 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S261891AbVCZAfx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 19:35:53 -0500
Date: Fri, 25 Mar 2005 16:58:56 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Greg Banks <gnb@melbourne.sgi.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux NFS Mailing List <nfs@lists.sourceforge.net>,
       Linux AutoFS Mailing List <autofs@linux.kernel.org>
Subject: Re: [PATCH 2.4] SGI 932676 link_path_walk refcount problem allows umount of active filesystem
Message-ID: <20050325195856.GB15383@logos.cnet>
References: <1111454677.1991.766.camel@hole.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1111454677.1991.766.camel@hole.melbourne.sgi.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2005 at 12:24:37PM +1100, Greg Banks wrote:
> G'day,
> 
> The attached patch fixes a bug in the VFS code which causes
> "Busy inodes after unmount" and a subsequent oops.

Applied, thanks.

> 
> Greg.
> -- 
> Greg Banks, R&D Software Engineer, SGI Australian Software Group.
> I don't speak for SGI.
> 

> Following an absolute symlink opens a window during which the
> filesystem containing the symlink has an outstanding dentry count
> and no outstanding vfsmount count.  A umount() of the filesystem can
> (incorrectly) proceed, resulting in the "Busy inodes after unmount"
> message and an oops shortly thereafter.
> 
> Systems using autofs-controlled NFS mounts are especially vulnerable,
> as autofs both increases the number of unmounts happening and does NFS
> mounting in response to lookups which can result in multiple-second
> vulnerability windows.  However the bug could happen on any filesystem.
> 
> This patch adds a mntget()/mntput() pair around the link following code
> (as the 2.6 code does).  Attempts to umount() during link following
> now return EBUSY.
> 
> 
> Signed-off-by: Greg Banks <gnb@melbourne.sgi.com>
