Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129436AbQLEVDL>; Tue, 5 Dec 2000 16:03:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129786AbQLEVDC>; Tue, 5 Dec 2000 16:03:02 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:28132 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129436AbQLEVC6>; Tue, 5 Dec 2000 16:02:58 -0500
Message-ID: <3A2D51A3.DFF47557@uow.edu.au>
Date: Wed, 06 Dec 2000 07:35:47 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] inode dirty blocks  Re: test12-pre4
In-Reply-To: <Pine.LNX.4.10.10012031828170.22914-100000@penguin.transmeta.com> <Pine.GSO.4.21.0012040054400.5055-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 
> On Sun, 3 Dec 2000, Linus Torvalds wrote:
> 
> >
> > Synching up with Alan and various other stuff. The most important one
> > being the fix to the inode dirty block list.
> 
> It doesn't solve the problem. If you unlink a file with dirty metadata
> you have a nice chance to hit the BUG() in inode.c:83. I hope that patch
> below closes all remaining holes. See analysis in previous posting
> (basically, bforget() is not enough when we free the block; bh should
> be removed from the inode's list regardless of the ->b_count).
>                                                         Cheers,
>                                                                 Al
> 
> diff -urN rc12-pre4/fs/buffer.c rc12-pre4-dirty_blocks/fs/buffer.c
> --- rc12-pre4/fs/buffer.c       Mon Dec  4 01:01:43 2000
> +++ rc12-pre4-dirty_blocks/fs/buffer.c  Mon Dec  4 01:11:42 2000

That bforget-inode patch ran fine on two machines for ten hours. One
was SMP.  The other was running the ATA guy's latest set of patches
including taskfile support.

The proposed FS changes are solid.

The third machine died horribly twice - recursive pagefaults.  Without
IDE patch.  This could be anything, including hardware.  Will investigate.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
