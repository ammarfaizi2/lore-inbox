Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279963AbRJ3QFn>; Tue, 30 Oct 2001 11:05:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279971AbRJ3QFe>; Tue, 30 Oct 2001 11:05:34 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:50311 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S279963AbRJ3QFZ>; Tue, 30 Oct 2001 11:05:25 -0500
Date: Tue, 30 Oct 2001 16:07:45 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Frank Dekervel <Frank.dekervel@student.kuleuven.ac.Be>
cc: Linus Torvalds <torvalds@transmeta.com>, Andrea Arcangeli <andrea@suse.de>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: need help interpreting 'free' output.
In-Reply-To: <200110301132.MAA22471@lambik.cc.kuleuven.ac.be>
Message-ID: <Pine.LNX.4.21.0110301557560.1229-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Oct 2001, Frank Dekervel wrote:
> 
> since i saw strange things happening with my free memory numbers, i tried 
> this:
> - i compiled and booted a fresh kernel (no proprietary modules, no patches, 
> just 2.4.14-pre4)
> - i did free.
> 
> bakvis:~# free
>              total       used       free     shared    buffers     cached
> Mem:        384912      55644     329268          0       3652      29880
> -/+ buffers/cache:      22112     362800
> Swap:       136512          0     136512
> 
> so i have 22 meg used right ?
> 
> - i started the daily cron jobs (updatedb and htdig  and some minor things 
> like log rotation)
> 
> - i did 'free' again.
> 
> bakvis:~# free
>              total       used       free     shared    buffers     cached
> Mem:        384912     377060       7852          0      29424     125660
> -/+ buffers/cache:     221976     162936
> Swap:       136512        752     135760
> 
> so now there is 220 meg used memory right ?
> and the memory is definitely used, because as soon as i start a memory hog 
> the system hits swap ...
> 
> so what am i missing here ?
> should i provide more info about my kernel configuration ? vmstat numbers ?

I'm fairly sure /proc/slabinfo will show large inode_cache and large
dentry_cache: which is natural after updatedb, nothing wrong with that.

However, unlike 2.4.13, 2.4.14-pre (you tried pre4, I just tried pre5)
seems much too unwilling to shrink_dcache and shrink_icache: your
memory hog should shrink them, but it seems not to.  Linus?

Hugh

