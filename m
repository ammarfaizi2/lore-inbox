Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267493AbRGRPzE>; Wed, 18 Jul 2001 11:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267494AbRGRPyp>; Wed, 18 Jul 2001 11:54:45 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:37904 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S267493AbRGRPyg>; Wed, 18 Jul 2001 11:54:36 -0400
Date: Wed, 18 Jul 2001 17:53:42 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Chris Mason <mason@suse.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        reiserfs-dev@namesys.com
Subject: Re: [PATCH] reiserfs b_count usage
Message-ID: <20010718175342.B18183@athlon.random>
In-Reply-To: <203060000.995466320@tiny>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <203060000.995466320@tiny>; from mason@suse.com on Wed, Jul 18, 2001 at 10:25:20AM -0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2001 at 10:25:20AM -0400, Chris Mason wrote:
> @@ -2597,7 +2599,7 @@
>  
>    if (bh) {
>      reiserfs_clean_and_file_buffer(bh) ;
> -    atomic_dec(&(bh->b_count)) ; /* get_hash incs this */
> +    put_bh(bh) ; /* get_hash grabs the buffer */
>      if (atomic_read(&(bh->b_count)) < 0) {
>        printk("journal-2165: bh->b_count < 0\n") ;
>      }

in mainline you aren't calling reiserfs_clean_and_file_buffer above, so
it rejects.

Andrea
