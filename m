Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286962AbSAFCTH>; Sat, 5 Jan 2002 21:19:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286976AbSAFCS5>; Sat, 5 Jan 2002 21:18:57 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:47880 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S286962AbSAFCSo>; Sat, 5 Jan 2002 21:18:44 -0500
Date: Sat, 5 Jan 2002 18:23:30 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Ingo Molnar <mingo@elte.hu>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [announce] [patch] ultra-scalable O(1) SMP and UP scheduler
In-Reply-To: <Pine.LNX.4.33.0201060501560.5193-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.40.0201051821310.1607-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Jan 2002, Ingo Molnar wrote:

>
> On Sun, 6 Jan 2002, Alan Cox wrote:
>
> > 64 queues costs a tiny amount more than 32 queues. If you can get it
> > down to eight or nine queues with no actual cost (espcially for non
> > realtime queues) then it represents a huge win since an 8bit ffz can
> > be done by lookup table and that is fast on all processors
>
> i'm afraid that while 32 might work, 8 will definitely not be enough. In
> the interactivity-detection scheme i added it's important for interactive
> tasks to have some room (in terms of priority levels) to go up without
> hitting the levels of the true CPU abusers.
>
> we can do 32-bit ffz by doing 4x 8-bit ffz's though:
>
> 	if (likely(byte[0]))
> 		return ffz8[byte[0]];
> 	else if (byte[1])
> 		return ffz8[byte[1]];
> 	else if (byte[2]
> 		return ffz8[byte[2]];
> 	else if (byte[3]
> 		return ffz8[byte[3]];
> 	else
> 		return -1;
>
> and while this is still 4 branches, it's better than a loop of 32. But i
> also think that George Anzinger's idea works well too to reduce the cost
> of bitsearching. Or those platforms that decide to do so could search the
> arrray directly as well - if it's 32 queues then it's a cache footprint of
> 4 cachelines, which can be searched directly without any problem.

dyn_prio -> [0..15]

each time a task exaust its ts you decrease dyn_prio.

queue = dyn_prio >> 1

You get 16 consecutive CPU hog steps before falling in the hell of CPU
bound tasks




- Davide


