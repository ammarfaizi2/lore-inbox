Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276361AbRKORlQ>; Thu, 15 Nov 2001 12:41:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280809AbRKORlG>; Thu, 15 Nov 2001 12:41:06 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:14602 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S276361AbRKORkr>; Thu, 15 Nov 2001 12:40:47 -0500
Date: Thu, 15 Nov 2001 18:40:36 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Ken Brownfield <brownfld@irridia.com>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Daniel Phillips <phillips@bonn-fries.net>
Subject: Re: 2.4.>=13 VM/kswapd/shmem/Oracle issue (was Re: Google's mm problems)
Message-ID: <20011115184036.D1381@athlon.random>
In-Reply-To: <E15yhyY-0000Yb-00@starship.berlin> <20011109033851.A15099@asooo.flowerfire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20011109033851.A15099@asooo.flowerfire.com>; from brownfld@irridia.com on Fri, Nov 09, 2001 at 03:38:51AM -0600
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2001 at 03:38:51AM -0600, Ken Brownfield wrote:
> We're seeing an easily reproducible problem that I believe to be along
> the same lines as what Google is seeing.  I'm not sure if Oracle's SGA

FYI: yes, that's the same problem. After some debugging I found the
exact reason of the bug, and as Daniel claimed a few weeks ago it is
really a VM problem, not an mlock problem. And it's one thing that I
didn't noticed while rewriting the VM, so it is reproducible on all 2.4
kernels out there, no matter what VM is in them. The kswapd infinite
loop that can trigger with the -ac VM when all the ZONE_DMA is
unfreeable (now fixed in mainline with classzone) have nothing to do
with this google problem, kswapd is right here to spend cpu time, the
bug is not kswapd activation.

I just sent Ben (at Google) a patch that fixes the problem completly for
me and for him and I'll try to release the real fix in the next days.
(so far it's a dirty workaround, that is just usable fine in their and
my memory configuration but it's not general purpose yet, but it's been
more than enough to proof my theory so far and I've in mind how to fix
it properly, tomorrow I hope I will implement it).

Andrea
