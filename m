Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280015AbRJ3Qxp>; Tue, 30 Oct 2001 11:53:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280022AbRJ3Qxf>; Tue, 30 Oct 2001 11:53:35 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:1804 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S280015AbRJ3QxQ>; Tue, 30 Oct 2001 11:53:16 -0500
Date: Tue, 30 Oct 2001 17:51:30 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: Frank Dekervel <Frank.dekervel@student.kuleuven.ac.Be>,
        Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: need help interpreting 'free' output.
Message-ID: <20011030175129.J1340@athlon.random>
In-Reply-To: <200110301132.MAA22471@lambik.cc.kuleuven.ac.be> <Pine.LNX.4.21.0110301557560.1229-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.21.0110301557560.1229-100000@localhost.localdomain>; from hugh@veritas.com on Tue, Oct 30, 2001 at 04:07:45PM +0000
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2001 at 04:07:45PM +0000, Hugh Dickins wrote:
> On Tue, 30 Oct 2001, Frank Dekervel wrote:
> > 
> > since i saw strange things happening with my free memory numbers, i tried 
> > this:
> > - i compiled and booted a fresh kernel (no proprietary modules, no patches, 
> > just 2.4.14-pre4)
> > - i did free.
> > 
> > bakvis:~# free
> >              total       used       free     shared    buffers     cached
> > Mem:        384912      55644     329268          0       3652      29880
> > -/+ buffers/cache:      22112     362800
> > Swap:       136512          0     136512
> > 
> > so i have 22 meg used right ?
> > 
> > - i started the daily cron jobs (updatedb and htdig  and some minor things 
> > like log rotation)
> > 
> > - i did 'free' again.
> > 
> > bakvis:~# free
> >              total       used       free     shared    buffers     cached
> > Mem:        384912     377060       7852          0      29424     125660
> > -/+ buffers/cache:     221976     162936
> > Swap:       136512        752     135760
> > 
> > so now there is 220 meg used memory right ?
> > and the memory is definitely used, because as soon as i start a memory hog 
> > the system hits swap ...
> > 
> > so what am i missing here ?
> > should i provide more info about my kernel configuration ? vmstat numbers ?
> 
> I'm fairly sure /proc/slabinfo will show large inode_cache and large
> dentry_cache: which is natural after updatedb, nothing wrong with that.
> 
> However, unlike 2.4.13, 2.4.14-pre (you tried pre4, I just tried pre5)
> seems much too unwilling to shrink_dcache and shrink_icache: your
> memory hog should shrink them, but it seems not to.  Linus?

2.4.14pre5aa1 has a logic to try to shrink those caches at a better
time. Frank could you try again with pre5aa1 and see if it goes better?

Not shrinking the vfs caches when shrink_cache failed is wrong,
allocations from ZONE_NORMAL will fail without way to recover as soon as
all ZONE_NORMAL is eat in vfs caches.

Andrea
