Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317544AbSFIEZJ>; Sun, 9 Jun 2002 00:25:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317552AbSFIEZI>; Sun, 9 Jun 2002 00:25:08 -0400
Received: from mail.parknet.co.jp ([210.134.213.6]:58634 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S317544AbSFIEZI>; Sun, 9 Jun 2002 00:25:08 -0400
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: linux-kernel@vger.kernel.org, chaffee@cs.berkeley.edu
Subject: Re: [patch] fat/msdos/vfat crud removal
In-Reply-To: <200206090247.g592lR3471572@saturn.cs.uml.edu>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 09 Jun 2002 13:24:41 +0900
Message-ID: <87ptz1dqpi.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Albert D. Cahalan" <acahalan@cs.uml.edu> writes:

> This get rid of the old byte order macros.
> 
> diff -Naurd old/fs/fat/cache.c new/fs/fat/cache.c
> --- old/fs/fat/cache.c	Sun Jun  2 21:44:45 2002
> +++ new/fs/fat/cache.c	Sat Jun  8 17:25:48 2002
> @@ -67,13 +67,13 @@
>  	}
>  	if (sbi->fat_bits == 32) {
>  		p_first = p_last = NULL; /* GCC needs that stuff */
> -		next = CF_LE_L(((__u32 *) bh->b_data)[(first &
> +		next = le32_to_cpu(((__u32 *) bh->b_data)[(first &
>  		    (sb->s_blocksize - 1)) >> 2]);
>  		/* Fscking Microsoft marketing department. Their "32" is 28. */

Personally I think this patch makes code readable. But please don't
remove BT
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
