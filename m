Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129153AbQKWMnL>; Thu, 23 Nov 2000 07:43:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132240AbQKWMnC>; Thu, 23 Nov 2000 07:43:02 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:16135 "HELO
        note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
        id <S129153AbQKWMm6>; Thu, 23 Nov 2000 07:42:58 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Alexander Viro <viro@math.psu.edu>, "Mohammad A. Haque" <mhaque@haque.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Tigran Aivazian <tigran@veritas.com>
Date: Thu, 23 Nov 2000 23:12:47 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14877.2495.613209.312681@notabene.cse.unsw.edu.au>
Subject: Re: ext2 filesystem corruptions back from dead? 2.4.0-test11
In-Reply-To: message from Neil Brown on Thursday November 23
In-Reply-To: <14876.45844.670274.366687@notabene.cse.unsw.edu.au>
        <Pine.GSO.4.21.0011230435280.10127-100000@weyl.math.psu.edu>
        <14876.64017.161207.36430@notabene.cse.unsw.edu.au>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
        LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
        8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday November 23, neilb@cse.unsw.edu.au wrote:
> On Thursday November 23, viro@math.psu.edu wrote:
> > 
> > Guys, could you try to reproduce it with the following:
> 
> Well, I tried.... but it didn't go real well.
> 
.....
> It looks like extending a file is not allowed any more.
> 
> This is with 2.4.0-test11 plus assorted patches to knfsd (which should
> be totally irrelevant) and raid5 (Which should not affect ext2), plus
> your patch, which applied cleanly.
> 
> I'll try with a clean test11 plus your patches in the morning, but it
> doesn't look good.
> 
> NeilBrown

It appears that lots of files have been marked "immutable" :-(

That patch contained

@@ -110,4 +99,5 @@
 
 struct inode_operations ext2_file_inode_operations = {
 	truncate:	ext2_truncate,
+	setattr:	ext2_notify_change,
 };


which enabled ext2_notify_change, however ext2_notify_change has a
bug.
It sets attributes from iattr->ia_attr_flags even
if ATTR_ATTR_FLAG is NOT SET in iattr->ia_valid.


NeilBrown
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
