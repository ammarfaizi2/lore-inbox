Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262406AbUKQU2s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262406AbUKQU2s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 15:28:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262378AbUKQU1A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 15:27:00 -0500
Received: from brmea-mail-4.Sun.COM ([192.18.98.36]:20182 "EHLO
	brmea-mail-4.sun.com") by vger.kernel.org with ESMTP
	id S262406AbUKQUZq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 15:25:46 -0500
Date: Wed, 17 Nov 2004 15:25:26 -0500
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: [patch] inotify: use permission not vfs_permission
In-reply-to: <1100722624.4981.49.camel@betsy.boston.ximian.com>
To: Robert Love <rml@novell.com>
Cc: Christoph Hellwig <hch@infradead.org>, ttb@tentacle.dhs.org,
       linux-kernel@vger.kernel.org
Message-id: <419BB3B6.40703@sun.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
References: <1100710677.6280.2.camel@betsy.boston.ximian.com>
 <1100714560.6280.7.camel@betsy.boston.ximian.com>
 <20041117190850.GA11682@infradead.org>
 <1100718601.4981.2.camel@betsy.boston.ximian.com>
 <20041117191803.GA11830@infradead.org>
 <1100719052.4981.4.camel@betsy.boston.ximian.com> <419BAFE1.7030500@sun.com>
 <1100722624.4981.49.camel@betsy.boston.ximian.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Robert Love wrote:
> On Wed, 2004-11-17 at 15:09 -0500, Mike Waychison wrote:
> 
> 
>>use permission()
> 
> 
> I appreciate the constructive comment.
> 
> John, attached patch replaces vfs_permission() with permission().
> 
> Thanks, Mike.
> 
> 	Robert Love
> 
> 
> Use permission() instead of generic_permission().
> 
> Signed-Off-By: Robert Love <rml@novell.com>
> 
> diff -u linux/drivers/char/inotify.c linux/drivers/char/inotify.c
> --- linux/drivers/char/inotify.c	2004-11-17 12:28:27.921136656 -0500
> +++ linux/drivers/char/inotify.c	2004-11-17 12:28:27.921136656 -0500
> @@ -166,7 +166,7 @@
>  	inode = nd.dentry->d_inode;
>  
>  	/* you can only watch an inode if you have read permissions on it */
> -	error = generic_permission(inode, MAY_READ, NULL);
> +	error = permission(inode, MAY_READ);
>  	if (error) {
>  		inode = ERR_PTR(error);
>  		goto release_and_out;
> 
> 

permission() still takes 3 arguments though.  I think it is safe to pass
NULL for the nameidata.


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

iD8DBQFBm7O2dQs4kOxk3/MRApYgAJ0c1XGD99i8Yir2LYTAtosJrOtvIACfT5BE
C3T8DDq+L9NskVe1sI47IKM=
=BZA8
-----END PGP SIGNATURE-----
