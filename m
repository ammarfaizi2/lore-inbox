Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265355AbSLRAJA>; Tue, 17 Dec 2002 19:09:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265446AbSLRAJA>; Tue, 17 Dec 2002 19:09:00 -0500
Received: from imag.imag.fr ([129.88.30.1]:65162 "EHLO imag.imag.fr")
	by vger.kernel.org with ESMTP id <S265355AbSLRAI7>;
	Tue, 17 Dec 2002 19:08:59 -0500
Date: Wed, 18 Dec 2002 01:16:52 +0100
From: Pierre Lombard <pierre.lombard@imag.fr>
To: Andrew Morton <akpm@digeo.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] ext3 deadlock fix
Message-ID: <20021218001652.GA14049@sci41.imag.fr>
References: <3DFCE535.3417CEDB@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DFCE535.3417CEDB@digeo.com>
X-GPG-Fingerprint: A793 679A FE39 A7D4 8497 8765 C478 6832 ECF8 01E6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Andrew Morton <akpm@digeo.com> [2002-12-15 21:27]:

> The patch ensures that ->sync_fs is never run under lock_super().

> --- 24/Documentation/filesystems/Locking~sync_fs-fix	Sun Dec 15 11:12:48 2002
> +++ 24-akpm/Documentation/filesystems/Locking	Sun Dec 15 11:16:15 2002
> @@ -93,6 +93,7 @@ prototypes:
>  	void (*delete_inode) (struct inode *);
>  	void (*put_super) (struct super_block *);
>  	void (*write_super) (struct super_block *);
> +	int (*sync_fs) (struct super_block *);
>  	int (*statfs) (struct super_block *, struct statfs *);
>  	int (*remount_fs) (struct super_block *, int *, char *);
>  	void (*clear_inode) (struct inode *);
> @@ -108,6 +109,7 @@ delete_inode:	no	
>  clear_inode:	no	
>  put_super:	yes	yes	maybe		(see below)
>  write_super:	yes	yes	maybe		(see below)
> +write_super:	yes	no	maybe		(see below)
   ~~~~~~~~~~~
A small typo in the documentation.

>  statfs:		yes	no	no
>  remount_fs:	yes	yes	maybe		(see below)
>  umount_begin:	yes	no	maybe		(see below)

-- 
Best regards,
  Pierre

