Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261178AbVAKSTz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261178AbVAKSTz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 13:19:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261555AbVAKRsP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 12:48:15 -0500
Received: from brmea-mail-3.Sun.COM ([192.18.98.34]:9921 "EHLO
	brmea-mail-3.sun.com") by vger.kernel.org with ESMTP
	id S261264AbVAKRd4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 12:33:56 -0500
Date: Tue, 11 Jan 2005 12:30:01 -0500
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: [PATCH 3/11] FUSE - device functions
In-reply-to: <E1Co4mF-00045N-00@dorka.pomaz.szeredi.hu>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: akpm@osdl.org, torvalds@osdl.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Message-id: <41E40D19.8010806@sun.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
References: <E1Co4mF-00045N-00@dorka.pomaz.szeredi.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Miklos Szeredi wrote:
> This adds the FUSE device handling functions.
> 
> This contains the following files:
> 
>  o dev.c
>     - fuse device operations (read, write, release, poll)
>     - registers misc device
>     - support for sending requests to userspace
> 
> Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
> diff -Nurp a/fs/fuse/Makefile b/fs/fuse/Makefile
> --- a/fs/fuse/Makefile	2005-01-10 19:28:38.000000000 +0100
> +++ b/fs/fuse/Makefile	2005-01-10 19:28:38.000000000 +0100
> @@ -4,4 +4,4 @@
>  
>  obj-$(CONFIG_FUSE) += fuse.o
>  
> -fuse-objs := inode.o
> +fuse-objs := dev.o inode.o
> diff -Nurp a/fs/fuse/dev.c b/fs/fuse/dev.c
> --- a/fs/fuse/dev.c	1970-01-01 01:00:00.000000000 +0100
> +++ b/fs/fuse/dev.c	2005-01-10 19:28:38.000000000 +0100

[...]

> +static inline void block_sigs(sigset_t *oldset)
> +{
> +	sigset_t sigmask;
> +
> +	siginitsetinv(&sigmask, sigmask(SIGKILL));
> +	sigprocmask(SIG_BLOCK, &sigmask, oldset);

sigmask shadows sigmask.  I'm surprised this works actually. (I see that
sigmask() is a macro..)


- --
Mike Waychison
Sun Microsystems, Inc.
1 (650) 352-5299 voice
1 (416) 202-8336 voice

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NOTICE:  The opinions expressed in this email are held by me,
and may not represent the views of Sun Microsystems, Inc.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB5A0ZdQs4kOxk3/MRAvJfAJ9AqZqRWRKpRww2zJVaM4gsDq00lQCgjp4Q
Bh+GXSiI/mAx3rghwFvT9UA=
=U2iZ
-----END PGP SIGNATURE-----
