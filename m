Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264503AbUIDRLx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264503AbUIDRLx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 13:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264530AbUIDRLx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 13:11:53 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:25094 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264503AbUIDRLv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 13:11:51 -0400
Date: Sat, 4 Sep 2004 18:11:43 +0100
From: Christoph Hellwig <hch@infradead.org>
To: =?iso-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] copyfile: sendfile
Message-ID: <20040904181143.A16644@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	=?iso-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040904165733.GC8579@wohnheim.fh-wedel.de> <20040904165938.GD8579@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040904165938.GD8579@wohnheim.fh-wedel.de>; from joern@wohnheim.fh-wedel.de on Sat, Sep 04, 2004 at 06:59:38PM +0200
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 04, 2004 at 06:59:38PM +0200, Jörn Engel wrote:
> Creates vfs_sendfile(), which can be called from other places within
> the kernel.  Such other places include copyfile() and cowlinks.
> 
> In principle, this just removes code from do_sendfile() to
> vfs_sendfile().  On top of that, it adds a check to out_inode,
> identical to the one on in_inode.  True, the check for out_inode was
> never needed, maybe that tells you something about the check to
> in_inode as well. ;)

Both checks aren't nessecary. 

> +++ linux-2.6.9-rc1-mm3/include/linux/syscalls.h	2004-09-04 18:17:15.000000000 +0200
> @@ -285,6 +285,8 @@
>  asmlinkage long sys_unlink(const char __user *pathname);
>  asmlinkage long sys_rename(const char __user *oldname,
>  				const char __user *newname);
> +asmlinkage long sys_copyfile(const char __user *from, const char __user *to,
> +				umode_t mode);

oesn't seem to belong into this patch.

