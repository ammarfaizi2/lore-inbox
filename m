Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281018AbRKOUHz>; Thu, 15 Nov 2001 15:07:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281023AbRKOUHq>; Thu, 15 Nov 2001 15:07:46 -0500
Received: from asooo.flowerfire.com ([63.254.226.247]:7 "EHLO
	asooo.flowerfire.com") by vger.kernel.org with ESMTP
	id <S281018AbRKOUHd>; Thu, 15 Nov 2001 15:07:33 -0500
Date: Thu, 15 Nov 2001 14:07:22 -0600
From: Ken Brownfield <brownfld@irridia.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Daniel Phillips <phillips@bonn-fries.net>
Subject: Re: 2.4.>=13 VM/kswapd/shmem/Oracle issue (was Re: Google's mm problems)
Message-ID: <20011115140722.A7221@asooo.flowerfire.com>
In-Reply-To: <E15yhyY-0000Yb-00@starship.berlin> <20011109033851.A15099@asooo.flowerfire.com> <20011115184036.D1381@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20011115184036.D1381@athlon.random>; from andrea@suse.de on Thu, Nov 15, 2001 at 06:40:36PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for looking into this -- I really mean it.  I'm looking forward
to the patch and how it compares to the others I've received. ;-)

Again, good work, and thanks to all,
-- 
Ken.
brownfld@irridia.com

On Thu, Nov 15, 2001 at 06:40:36PM +0100, Andrea Arcangeli wrote:
| On Fri, Nov 09, 2001 at 03:38:51AM -0600, Ken Brownfield wrote:
| > We're seeing an easily reproducible problem that I believe to be along
| > the same lines as what Google is seeing.  I'm not sure if Oracle's SGA
| 
| FYI: yes, that's the same problem. After some debugging I found the
| exact reason of the bug, and as Daniel claimed a few weeks ago it is
| really a VM problem, not an mlock problem. And it's one thing that I
| didn't noticed while rewriting the VM, so it is reproducible on all 2.4
| kernels out there, no matter what VM is in them. The kswapd infinite
| loop that can trigger with the -ac VM when all the ZONE_DMA is
| unfreeable (now fixed in mainline with classzone) have nothing to do
| with this google problem, kswapd is right here to spend cpu time, the
| bug is not kswapd activation.
| 
| I just sent Ben (at Google) a patch that fixes the problem completly for
| me and for him and I'll try to release the real fix in the next days.
| (so far it's a dirty workaround, that is just usable fine in their and
| my memory configuration but it's not general purpose yet, but it's been
| more than enough to proof my theory so far and I've in mind how to fix
| it properly, tomorrow I hope I will implement it).
| 
| Andrea
| -
| To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
| the body of a message to majordomo@vger.kernel.org
| More majordomo info at  http://vger.kernel.org/majordomo-info.html
| Please read the FAQ at  http://www.tux.org/lkml/
