Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317024AbSG1SLt>; Sun, 28 Jul 2002 14:11:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317030AbSG1SLt>; Sun, 28 Jul 2002 14:11:49 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:51799 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S317024AbSG1SLs>; Sun, 28 Jul 2002 14:11:48 -0400
To: Anton Altaparmakov <aia21@cantab.net>
Cc: torvalds@transmeta.com (Linus Torvalds),
       linux-kernel@vger.kernel.org (Linux Kernel)
Subject: Re: [BK PATCH 2.5] fs/ntfs/dir.c: use PAGE_CACHE_MASK_LL with 64-bit values
References: <E17YRtw-0006I7-00@storm.christs.cam.ac.uk>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 28 Jul 2002 12:03:01 -0600
In-Reply-To: <E17YRtw-0006I7-00@storm.christs.cam.ac.uk>
Message-ID: <m1sn23hgru.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov <aia21@cantab.net> writes:

> Linus,
> 
> Following from previous patch which introduced PAGE_CACHE_MASK_LL, this
> one fixes a bug in fs/ntfs/dir.c which was using PAGE_CACHE_MASK
> on 64-bit values... It now uses PAGE_CACHE_MASK_LL.
> 
> Patch together with the other two patches available from:
> 
> 	bk pull http://linux-ntfs.bkbits.net/linux-2.5-pm
> 
> Best regards,
> 
> 	Anton
> -- 
> Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
> Linux NTFS maintainer / IRC: #ntfs on irc.openprojects.net
> WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/
> 
> ===================================================================
> 
> This will update the following files:
> 
>  fs/ntfs/dir.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletion(-)
> 
> through these ChangeSets:
> 
> <aia21@cantab.net> (02/07/27 1.479)
>    fs/ntfs/dir.c: Use PAGE_CACHE_MASK_LL() on 64-bit values.
> 
> 
> diff -Nru a/fs/ntfs/dir.c b/fs/ntfs/dir.c
> --- a/fs/ntfs/dir.c	Sat Jul 27 14:24:09 2002
> +++ b/fs/ntfs/dir.c	Sat Jul 27 14:24:09 2002
> @@ -1232,7 +1232,8 @@
>  	ntfs_debug("Handling index buffer 0x%Lx.",
>  			(long long)bmp_pos + cur_bmp_pos);
>  	/* If the current index buffer is in the same page we reuse the page. */
> 
> -	if ((prev_ia_pos & PAGE_CACHE_MASK) != (ia_pos & PAGE_CACHE_MASK)) {
> +	if ((prev_ia_pos & PAGE_CACHE_MASK_LL) !=
> +			(ia_pos & PAGE_CACHE_MASK_LL)) {
>  		prev_ia_pos = ia_pos;
>  		if (likely(ia_page != NULL))
>  			ntfs_unmap_page(ia_page);


Hmm.  Wouldn't
prev_ia_pos >> PAGE_CACHE_SHIFT != ia_pos >> PAGE_CACHE_SHIFT
work just as well?  And be some safer as the result could be stored in
32bits?

Eric
