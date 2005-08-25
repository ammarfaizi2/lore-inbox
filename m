Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751393AbVHYTmY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393AbVHYTmY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 15:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751399AbVHYTmY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 15:42:24 -0400
Received: from mummy.ncsc.mil ([144.51.88.129]:40873 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S1751393AbVHYTmY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 15:42:24 -0400
Subject: Re: [PATCH][-mm] Generic VFS fallback for security xattrs
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: Christoph Hellwig <hch@infradead.org>, lkml <linux-kernel@vger.kernel.org>,
       James Morris <jmorris@namei.org>, Chris Wright <chrisw@osdl.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <1124991803.3873.125.camel@moss-spartans.epoch.ncsc.mil>
References: <1124991803.3873.125.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Organization: National Security Agency
Date: Thu, 25 Aug 2005 15:39:38 -0400
Message-Id: <1124998778.3873.145.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-08-25 at 13:43 -0400, Stephen Smalley wrote:
> This patch modifies the VFS setxattr, getxattr, and listxattr code to
> fall back to the security module for security xattrs if the filesystem
> does not support xattrs natively.  This allows security modules to
> export the incore inode security label information to userspace even
> if the filesystem does not provide xattr storage, and eliminates the
> need to individually patch various pseudo filesystem types to provide
> such access.  The patch removes the existing xattr code from devpts
> and tmpfs as it is then no longer needed.
> 
> The patch restructures the code flow slightly to reduce duplication
> between the normal path and the fallback path, but this should only
> have one user-visible side effect - a program may get -EACCES rather
> than -EOPNOTSUPP if policy denied access but the filesystem didn't
> support the operation anyway.  Note that the post_setxattr hook call
> is not needed in the fallback case, as the inode_setsecurity hook call
> handles the incore inode security state update directly.  In contrast,
> we do call fsnotify in both cases.
> 
> Please include in -mm for wider testing prior to merging in 2.6.14.
> 
> ---
> 
>  fs/Kconfig                 |   43 ----------------------
>  fs/devpts/Makefile         |    1 
>  fs/devpts/inode.c          |   21 -----------
>  fs/devpts/xattr_security.c |   47 ------------------------
>  fs/xattr.c                 |   80 +++++++++++++++++++++++++-----------------
>  mm/shmem.c                 |   85 ---------------------------------------------
>  6 files changed, 49 insertions(+), 228 deletions(-)

Sorry, forgot to explicitly sign off on the patch:

Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>

-- 
Stephen Smalley
National Security Agency

