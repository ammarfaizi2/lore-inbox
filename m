Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945946AbWBCU0H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945946AbWBCU0H (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 15:26:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751397AbWBCU0H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 15:26:07 -0500
Received: from uproxy.gmail.com ([66.249.92.197]:35513 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751302AbWBCU0F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 15:26:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=EZIWCiIOLvuG9scwAOE1h4fw16HjDQ4EEJNDAr3eMR2hqZXVNBjmR5EHfjsd73L6yiFINWtjE1EYiwY9iGJgDtNxhEp47pwrO5yJmsqboFEJ4pZkP95qMsQeaFMqYkBbvWpgRFf+llvdaoxofPKBJbTinhZXQ4MCi2CkN7ZL3EQ=
Date: Fri, 3 Feb 2006 23:44:10 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Gregor Jasny <gjasny@web.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.6.16-git2: compile error in reiserfs
Message-ID: <20060203204410.GA8861@mipter.zuzino.mipt.ru>
References: <200602032043.46148.gjasny@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602032043.46148.gjasny@web.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2006 at 08:43:45PM +0100, Gregor Jasny wrote:
>   CC [M]  fs/reiserfs/xattr.o
> fs/reiserfs/xattr.c: In function 'reiserfs_check_acl':
> fs/reiserfs/xattr.c:1330: error: called object '0u' is not a function
> make[2]: *** [fs/reiserfs/xattr.o] Error 1
> make[1]: *** [fs/reiserfs] Error 2
> make: *** [fs] Error 2
> 
> Part of my config:
> CONFIG_REISERFS_FS=m
> # CONFIG_REISERFS_CHECK is not set
> # CONFIG_REISERFS_PROC_INFO is not set
> CONFIG_REISERFS_FS_XATTR=y
> # CONFIG_REISERFS_FS_POSIX_ACL is not set
> # CONFIG_REISERFS_FS_SECURITY is not set
> # CONFIG_JFS_FS is not set
> CONFIG_FS_POSIX_ACL=y

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 include/linux/reiserfs_acl.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/linux/reiserfs_acl.h
+++ b/include/linux/reiserfs_acl.h
@@ -58,7 +58,7 @@ extern struct reiserfs_xattr_handler pos
 extern struct reiserfs_xattr_handler posix_acl_access_handler;
 #else
 
-#define reiserfs_get_acl NULL
+#define reiserfs_get_acl(inode, type) NULL
 #define reiserfs_cache_default_acl(inode) 0
 
 static inline int reiserfs_xattr_posix_acl_init(void)

