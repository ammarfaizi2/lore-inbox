Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289217AbSAGOcA>; Mon, 7 Jan 2002 09:32:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289218AbSAGObv>; Mon, 7 Jan 2002 09:31:51 -0500
Received: from jalon.able.es ([212.97.163.2]:35472 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S289217AbSAGObc>;
	Mon, 7 Jan 2002 09:31:32 -0500
Date: Mon, 7 Jan 2002 15:35:33 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Davide Libenzi <davidel@xmailserver.org>, Jens Axboe <axboe@suse.de>,
        Matthias Hanisch <mjh@vr-web.de>, Mikael Pettersson <mikpe@csd.uu.se>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 2.5.2 scheduler code for 2.4.18-pre1 ( was 2.5.2-pre performance degradation on an old 486 )
Message-ID: <20020107153533.A12242@werewolf.able.es>
In-Reply-To: <20020106112129.D8673@suse.de> <Pine.LNX.4.40.0201061554410.933-100000@blue1.dev.mcafeelabs.com> <20020107023854.F1561@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20020107023854.F1561@athlon.random>; from andrea@suse.de on Mon, Jan 07, 2002 at 02:38:54 +0100
X-Mailer: Balsa 1.3.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20020107 Andrea Arcangeli wrote:
>
>yes please (feel free to CC me on the answers), I'd really like to
>reduce the scheduler O(N) overhead to the number of the running tasks,
>rather than doing the recalculate all over the processes in the machine.
>O(1) scheduler would be even better of course, but the below would
>ensure not to hurt the 1 task running case, and it's way simpler to
>check for correctness (so it's easier to include it as a start).
>

It looks like you all are going to turn the scheduler upside-down.
Hmm, as a non-kernel-hacker observer from the world outside, could I
make a suggestion ?
Is it easy to split the thing in steps:
- Move from single-queue to per-cpu-queue, with just the same algorithm
  that is running now for per-queue scheduling.
- Get that running for 2.18.18 and 2.5.2
- Then start to play with the per-queue scheduling algorithm:
	* better O(n)
	* O(1)
	* O(1) with different queues for RT and non RT
	etc...

Is it easy enough or are both steps so related that can not be split ?

Thanks.

(a linux user that tries experimental kernels and is seeing them grow
like mushrooms in latest weeks...)

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.2 (Cooker) for i586
Linux werewolf 2.4.18-pre1-beo #1 SMP Fri Jan 4 02:25:59 CET 2002 i686
