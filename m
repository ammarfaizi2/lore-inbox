Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129572AbQK3Xt3>; Thu, 30 Nov 2000 18:49:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131067AbQK3XtS>; Thu, 30 Nov 2000 18:49:18 -0500
Received: from TSX-PRIME.MIT.EDU ([18.86.0.76]:33938 "HELO tsx-prime.MIT.EDU")
	by vger.kernel.org with SMTP id <S130854AbQK3XtB>;
	Thu, 30 Nov 2000 18:49:01 -0500
Date: Thu, 30 Nov 2000 18:18:20 -0500
Message-Id: <200011302318.SAA17390@tsx-prime.MIT.EDU>
From: "Theodore Y. Ts'o" <tytso@MIT.EDU>
To: Alexander Viro <viro@math.psu.edu>
CC: linux-kernel@vger.kernel.org, "Theodore Y. Ts'o" <tytso@MIT.EDU>
In-Reply-To: Alexander Viro's message of Thu, 30 Nov 2000 17:13:27 -0500
	(EST), <Pine.GSO.4.21.0011301652130.21891-100000@weyl.math.psu.edu>
Subject: Re: [CFT][RFC] ext2_new_inode() fixes and cleanup
Phone: (781) 391-3464
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Thu, 30 Nov 2000 17:13:27 -0500 (EST)
   From: Alexander Viro <viro@math.psu.edu>

	   * search for appropriate cylinder group had been taken out of the
   ext2_new_inode() into helper functions - find_cg_dir(sb, parent_group) and
   find_cg_other(sb, parent_group). Bug caught by Daniel (wrong bh being
   dirtied when we update the free inodes counter) - fixed.
	   * ext2_new_inode() returns error values via ERR_PTR(). Callers
   updated, the third argument gone.
	   * load_inode_bitmap() returns bh of the bitmap instead of the slot
   number. Callers updated.
	   * code in ext2_new_inode() straightened up. Nothing spectacular,
   but it became more readable now...
	   * all callers of ext2_new_inode() in namei.c are passing correct
   mode (including ext2_mkdir(), etc.) instead of setting ->i_mode by hands
   afterwards. 

	   It's _not_ likely that the whole thing will go into 2.4.0. Moreover,
   if it ever will go, it will go in pieces. I will post the splitup for
   review, indeed. Right now I'm just asking to help with testing the
   thing and with reading the resulting code. Hopefully, it's easier to
   read than it used to be.

The code is definitely more readable with these changes.  For 2.4.0 at
this point my bias is towards a simple 1-2 line fix for Daniel's bug,
and save the cleanups for post 2.4.  

	   Ted, if you could look through the code and comment on it... I would
   be extremely grateful. I can send you a splitup of the patch if that will be
   more convenient for you - just tell.

If you could send me the split up, I'd appreciate it, as it'll make it
easier to find any subtle bugs.  I certainly like the general way you've
cleaned up the interfaces and factored out the code.

Many thanks,

					- Ted
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
