Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262318AbVBVOfI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262318AbVBVOfI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 09:35:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262317AbVBVOfI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 09:35:08 -0500
Received: from pat.uio.no ([129.240.130.16]:31705 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262316AbVBVOe7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 09:34:59 -0500
Subject: Re: [Patch 6/6] Bind Mount Extensions 0.06
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: Andrew Morton <akpm@osdl.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <20050222121333.GG3682@mail.13thfloor.at>
References: <20050222121333.GG3682@mail.13thfloor.at>
Content-Type: text/plain
Date: Tue, 22 Feb 2005 09:34:31 -0500
Message-Id: <1109082871.9839.9.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.631, required 12,
	autolearn=disabled, AWL 1.37, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ty den 22.02.2005 Klokka 13:13 (+0100) skreiv Herbert Poetzl:
> 
> diff -NurpP --minimal linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01-co0.01-xa0.01/fs/nfs/dir.c linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01-co0.01-xa0.01-ro0.01/fs/nfs/dir.c
> --- linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01-co0.01-xa0.01/fs/nfs/dir.c	2005-02-13 17:16:55 +0100
> +++ linux-2.6.11-rc4-bme0.06-bm0.01-at0.01-cc0.01-co0.01-xa0.01-ro0.01/fs/nfs/dir.c	2005-02-19 06:32:05 +0100
> @@ -771,7 +771,8 @@ static int is_atomic_open(struct inode *
>  	if (nd->flags & LOOKUP_DIRECTORY)
>  		return 0;
>  	/* Are we trying to write to a read only partition? */
> -	if (IS_RDONLY(dir) && (nd->intent.open.flags & (O_CREAT|O_TRUNC|FMODE_WRITE)))
> +	if ((IS_RDONLY(dir) || (nd && MNT_IS_RDONLY(nd->mnt))) &&
> +		(nd->intent.open.flags & (O_CREAT|O_TRUNC|FMODE_WRITE)))
>  		return 0;
>  	return 1;
>  }

The check for nd != NULL is redundant. See 5 lines further up...

Cheers,
  Trond

-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

