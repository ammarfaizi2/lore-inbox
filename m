Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130252AbQLEDUM>; Mon, 4 Dec 2000 22:20:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130874AbQLEDUD>; Mon, 4 Dec 2000 22:20:03 -0500
Received: from smtp02.mrf.mail.rcn.net ([207.172.4.61]:54764 "EHLO
	smtp02.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id <S130252AbQLEDTx>; Mon, 4 Dec 2000 22:19:53 -0500
Message-ID: <3A2C57B2.57DA3BA6@haque.net>
Date: Mon, 04 Dec 2000 21:49:22 -0500
From: "Mohammad A. Haque" <mhaque@haque.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <andrewm@uow.edu.au>
CC: Alexander Viro <viro@math.psu.edu>,
        Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] inode dirty blocks
In-Reply-To: <3A2B9B39.AA240475@uow.edu.au> <Pine.GSO.4.21.0012040843490.5153-100000@weyl.math.psu.edu> <3A2C493C.4A321797@uow.edu.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cool. Anyone have have a unified patch against pre4 or should I start
digging through my mail? =)

Andrew Morton wrote:
> This is with
> 
>         - test12-pre4
>         - aviro bforget patch
>         - UnlockPage() removed from vmscan.c:623
>         - and
> 
> --- linux-2.4.0-test12-pre4/fs/ext2/inode.c     Mon Dec  4 21:07:12 2000
> +++ linux-akpm/fs/ext2/inode.c  Tue Dec  5 08:46:38 2000
> @@ -1208,7 +1208,7 @@
>                 raw_inode->i_block[0] = cpu_to_le32(kdev_t_to_nr(inode->i_rdev));
>         else for (block = 0; block < EXT2_N_BLOCKS; block++)
>                 raw_inode->i_block[block] = inode->u.ext2_i.i_data[block];
> -       mark_buffer_dirty_inode(bh, inode);
> +       mark_buffer_dirty(bh);
>         if (do_sync) {
>                 ll_rw_block (WRITE, 1, &bh);
>                 wait_on_buffer (bh);

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/ 
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
