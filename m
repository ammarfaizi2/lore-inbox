Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130162AbRBVAWF>; Wed, 21 Feb 2001 19:22:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130194AbRBVAVy>; Wed, 21 Feb 2001 19:21:54 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:51728 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S130162AbRBVAVq>; Wed, 21 Feb 2001 19:21:46 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Mark Hemment <markhe@veritas.com>
Date: Thu, 22 Feb 2001 11:21:30 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14996.23434.271569.212657@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Subject: Re: [PATCH] nfsd + scalability
In-Reply-To: message from Mark Hemment on Sunday February 18
In-Reply-To: <Pine.LNX.4.21.0102182007310.11260-200000@alloc>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday February 18, markhe@veritas.com wrote:
> Hi Neil, all,
> 
>   The nfs daemons run holding the global kernel lock.  They still hold
> this lock over calls to file_op's read and write.
> 
>   The file system kernel interface (FSKI) doesn't require the kernel lock
> to be held over these read/write calls.  The nfs daemons do not require 
> that the reads or writes do not block (would be v silly if they did), so
> they have no guarantee the lock isn't dropped and retaken during
> blocking.  ie. they aren't using it as a guard across the calls.
> 
>   Dropping the kernel lock around read and write in fs/nfsd/vfs.c is a
> _big_ SMP scalability win!

Certainly I would like to not hold the BKL so much, but I'm curious
how much effect it will really have.  Do you have any data on the
effect of this change?

Also, I would much rather drop the lock in nfsd_dispatch() and then go
around reclaiming it whereever it was needed.
Subsequently we would drop the lock in nfsd() and make sure sunrpc is
safe. 
This would be more work (any volunteers?:-) but I feel that dropping
it in little places like this is a bit unsatisfying.

Thanks for the input,

NeilBrown


[patch deleted]
