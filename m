Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751158AbWHIRSX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158AbWHIRSX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 13:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbWHIRSX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 13:18:23 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:14803 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751158AbWHIRSW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 13:18:22 -0400
Subject: Re: [PATCH 1/6] prepare for write access checks: collapse if()
From: Dave Hansen <haveblue@us.ibm.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060809170904.GA7324@infradead.org>
References: <20060809165729.FE36B262@localhost.localdomain>
	 <20060809165730.0F7D9814@localhost.localdomain>
	 <20060809170904.GA7324@infradead.org>
Content-Type: text/plain
Date: Wed, 09 Aug 2006 10:18:08 -0700
Message-Id: <1155143888.19249.154.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-09 at 18:09 +0100, Christoph Hellwig wrote:
> On Wed, Aug 09, 2006 at 09:57:30AM -0700, Dave Hansen wrote:
> > 
> > We're shortly going to be adding a bunch more permission
> > checks in these functions.  That requires adding either a
> > bunch of new if() conditions, or some gotos.  This patch
> > collapses existing if()s and uses gotos instead to
> > prepare for the upcoming changes.
> > 
> > Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
> 
> 
> Acked-by: Christoph Hellwig <hch@lst.de>
> 
> > +	res = vfs_permission(&nd, mode);
> > +	/* SuS v2 requires we report a read only fs too */
> > +	if(res || !(mode & S_IWOTH) ||
> 
> except that there's a space missing after the if here :)

In my defense, the code I moved sucked, too. ;)

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 lxc-dave/fs/open.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN fs/namei.c~B1-prepwork-collapse-ifs-spacefix fs/namei.c
diff -puN fs/open.c~B1-prepwork-collapse-ifs-spacefix fs/open.c
--- lxc/fs/open.c~B1-prepwork-collapse-ifs-spacefix	2006-08-09 10:13:18.000000000 -0700
+++ lxc-dave/fs/open.c	2006-08-09 10:14:12.000000000 -0700
@@ -525,11 +525,11 @@ asmlinkage long sys_faccessat(int dfd, c
 
 	res = vfs_permission(&nd, mode);
 	/* SuS v2 requires we report a read only fs too */
-	if(res || !(mode & S_IWOTH) ||
+	if (res || !(mode & S_IWOTH) ||
 	   special_file(nd.dentry->d_inode->i_mode))
 		goto out_path_release;
 
-	if(IS_RDONLY(nd.dentry->d_inode))
+	if (IS_RDONLY(nd.dentry->d_inode))
 		res = -EROFS;
 
 out_path_release:
_


-- Dave

