Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289655AbSBJPCD>; Sun, 10 Feb 2002 10:02:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289659AbSBJPBy>; Sun, 10 Feb 2002 10:01:54 -0500
Received: from ua0d5hel.dial.kolumbus.fi ([62.248.132.0]:14362 "EHLO
	porkkala.uworld.dyndns.org") by vger.kernel.org with ESMTP
	id <S289657AbSBJPBs>; Sun, 10 Feb 2002 10:01:48 -0500
Message-ID: <3C668B24.1A22F53@kolumbus.fi>
Date: Sun, 10 Feb 2002 17:00:52 +0200
From: Jussi Laako <jussi.laako@kolumbus.fi>
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: mingo@elte.hu
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] improving O(1)-J9 in heavily threaded situations
In-Reply-To: <Pine.LNX.4.33.0202072326410.4773-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> 
> there is one more thing in the -K2 patch that could cause your problems.
> In kernel/softirq.c, you'll find this line:
> //__initcall(spawn_ksoftirqd);
> please uncomment it - this was just a debugging thing that was left in 
> the patch accidentally. I've made a -K3 patch that has this fixed. Do you
> still see the audio problems?

I did this and also tried -K3. It didn't fix the problem.

I addded lost block count printing to the SCHED_FIFO server processes. Most
of the loss (about 75%) happens at lowest level soundcard server and rest in
distributor process. Usually it looses 1 block at time but occasionally
there is peak of about 18 lost blocks.

If I make the client process read larger blocks (> 4kB) from the distributor
process number of lost blocks at soundcard server raises significantly. I
can make it a bit smaller without increased loss, but of course it means
larger overhead and eventually more lost blocks if made something like 512
bytes. 4 kB is optimal block size as it's also internal block size used by
soundcard and distributor servers.

4 kB block size means 2.9 ms in time in this case.


 - Jussi Laako

-- 
PGP key fingerprint: 161D 6FED 6A92 39E2 EB5B  39DD A4DE 63EB C216 1E4B
Available at PGP keyservers

