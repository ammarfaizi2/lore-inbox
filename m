Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264547AbTFKWMl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 18:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264569AbTFKWMl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 18:12:41 -0400
Received: from 216-239-45-4.google.com ([216.239.45.4]:47003 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S264547AbTFKWMj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 18:12:39 -0400
Date: Wed, 11 Jun 2003 15:24:36 -0700
From: Frank Cusack <fcusack@fcusack.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nfs_unlink() race (was: nfs_refresh_inode: inode number mismatch)
Message-ID: <20030611152436.A3241@google.com>
References: <Pine.LNX.4.44.0306110929260.1653-100000@home.transmeta.com> <1055352127.2419.25.camel@dhcp22.swansea.linux.org.uk> <16103.26865.361044.360120@charged.uio.no> <16103.29804.198545.680701@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <16103.29804.198545.680701@charged.uio.no>; from trond.myklebust@fys.uio.no on Wed, Jun 11, 2003 at 08:26:52PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 11, 2003 at 08:26:52PM +0200, Trond Myklebust wrote:
> diff -u --recursive --new-file linux-2.4.21-rc6/fs/namei.c linux/fs/namei.c
> --- linux-2.4.21-rc6/fs/namei.c	2002-12-30 09:39:54.000000000 -0800
> +++ linux/fs/namei.c	2003-06-11 11:16:49.000000000 -0700
> @@ -633,7 +633,8 @@
>  		 * Check the cached dentry for staleness.
>  		 */
>  		dentry = nd->dentry;
> -		if (dentry && dentry->d_op && dentry->d_op->d_revalidate) {

Doesn't the above simply always revalidate?

> +		if (dentry && dentry->d_sb
> +		    && (dentry->d_sb->s_type->fs_flags & FS_ALWAYS_REVAL)) {
>  			err = -ESTALE;
>  			if (!dentry->d_op->d_revalidate(dentry, 0)) {
>  				d_invalidate(dentry);

/fc
