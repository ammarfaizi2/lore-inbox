Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273983AbRI3TI0>; Sun, 30 Sep 2001 15:08:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273985AbRI3TIQ>; Sun, 30 Sep 2001 15:08:16 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:37751 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S273983AbRI3TII>; Sun, 30 Sep 2001 15:08:08 -0400
To: Jim Meyering <jim@meyering.net>
Cc: Nilmoni Deb <ndeb@ece.cmu.edu>, viro@math.psu.edu, bug-fileutils@gnu.org,
        Remy.Card@linux.org, linux-kernel@vger.kernel.org
Subject: Re: fs/ext2/namei.c: dir link/unlink bug? [Re: mv changes dir timestamp
In-Reply-To: <Pine.LNX.3.96L.1010929125713.27868A-100000@d-alg.ece.cmu.edu>
	<87bsjt59jb.fsf@pixie.eng.ascend.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 30 Sep 2001 12:58:18 -0600
In-Reply-To: <87bsjt59jb.fsf@pixie.eng.ascend.com>
Message-ID: <m1g0944ib9.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Meyering <jim@meyering.net> writes:

> Nilmoni Deb <ndeb@ece.cmu.edu> wrote:
> > When I move a directory its time stamp gets changed.
> > I am using mv version 4.1 (with mandrake-8.1).
> 
> Thanks a lot for reporting that!
> This appears to be a bug not in GNU mv, nor even in GNU libc, but
> rather in the underlying implementation in the kernel ext2 file system
> support.  The offending change seems to have come in with a rewrite
> of fs/ext2/namei.c that happened sometime between 2.4.4 and 2.4.9.
> 
> That file begins with this new comment:
> 
>  * Rewrite to pagecache. Almost all code had been changed, so blame me
>  * if the things go wrong. Please, send bug reports to viro@math.psu.edu
> 
> This demonstrates that the problem affects ext2, but not tmpfs
> using a 2.4.10 kernel (notice that the timestamp doesn't change
> in /t, but does in the ext2 /tmp):

This actually looks like a fix.  Ext2 keeps a directory entry named
.. in the directory so it knows what the parent directory is.
So to rename a directory besides it must unlink(..) and the link(..) inside
the directory being moved, at least logically.  In the case you gave
as the parent directory didn't change it could be optimized out, but
it probably isn't worth it. 

I know this is different but why is this a problem?

Eric




