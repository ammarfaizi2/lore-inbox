Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262730AbVCDCJc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262730AbVCDCJc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 21:09:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262786AbVCDCGh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 21:06:37 -0500
Received: from locomotive.csh.rit.edu ([129.21.60.149]:61481 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S262730AbVCDBob (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 20:44:31 -0500
Message-ID: <4227BE1E.7070601@suse.com>
Date: Thu, 03 Mar 2005 20:47:10 -0500
From: Jeff Mahoney <jeffm@suse.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeffrey Mahoney <jeffm@suse.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Stephen Smalley <sds@epoch.ncsc.mil>, Chris Wright <chrisw@osdl.org>
Subject: Re: [PATCH 1/4] vfs: adds the S_PRIVATE flag and adds use to security
References: <20050301153717.GB18215@locomotive.unixthugs.org>
In-Reply-To: <20050301153717.GB18215@locomotive.unixthugs.org>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Bogosity: No, tests=bogofilter, spamicity=0.000000, version=0.92.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jeffrey Mahoney wrote:
> This patch adds an S_PRIVATE flag to inode->i_flags to mark an inode as
> filesystem-internal. As such, it should be excepted from the security
> infrastructure to allow the filesystem to perform its own access control.

> @@ -1459,12 +1469,16 @@ static inline void security_inode_post_l
>  					     struct inode *dir,
>  					     struct dentry *new_dentry)
>  {
> +	if (unlikely (IS_PRIVATE (new_dentry->d_inode)))
> +		return;
>  	security_ops->inode_post_link (old_dentry, dir, new_dentry);
>  }
>  

Internal testing has shown that this operation will cause an Oops on
NFS. The assumption that a link operation will return an instantiated
dentry is invalid, and thus new_dentry->d_inode will be NULL on NFS
filesystems. I'll send out a revised version later this evening.

- -Jeff

- --
Jeff Mahoney
SuSE Labs
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCJ74eLPWxlyuTD7IRAg3zAJ4w5ThhGVHoTNKf+4TyqwU/NtRUvACfWnje
EIiFuTZPWZq245g/9xrkZLA=
=hTpo
-----END PGP SIGNATURE-----
