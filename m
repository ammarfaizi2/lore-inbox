Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290389AbSBFKkE>; Wed, 6 Feb 2002 05:40:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290386AbSBFKjz>; Wed, 6 Feb 2002 05:39:55 -0500
Received: from mx2.elte.hu ([157.181.151.9]:17846 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S290389AbSBFKjo>;
	Wed, 6 Feb 2002 05:39:44 -0500
Date: Wed, 6 Feb 2002 13:37:30 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Jussi Laako <jussi.laako@kolumbus.fi>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] improving O(1)-J9 in heavily threaded situations
In-Reply-To: <3C607C43.92262E82@kolumbus.fi>
Message-ID: <Pine.LNX.4.33.0202061329370.4542-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 6 Feb 2002, Jussi Laako wrote:

> > > > tasks? If yes then renice them to -11.
>
> I tried to renice many of the processes with different combinations
> and didn't make any difference.

> Here's top screens of two badly behaving load combinations:

> CPU states: 14.3% user, 11.9% system,  0.0% nice, 73.6% idle

73% of CPU time is idle! So priorities will make no (or little)
difference.

>   PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
>   809 root      15   0 58312  14M  3744 S    11.8  5.7   1:12 X
>   946 visitor   15   0  9572 9572  3584 S     8.0  3.7   0:26 guispect
>   999 visitor   15   0  1616 1616  1324 S     2.2  0.6   0:01 spectrum
>   944 visitor   15   0  1184 1184   984 S     1.5  0.4   0:03 soundsrv2
>   939 visitor   15   0  1184 1184   984 R     1.4  0.4   0:06 soundsrv2
>  1000 visitor   15   0  1236 1236  1024 S     0.7  0.4   0:00 streamdist
>   943 visitor   15   0  1236 1236  1024 S     0.5  0.4   0:02 streamdist
>   912 visitor   15   0  4564 4564  3544 R     0.2  1.7   0:00 gnome-terminal

since there is lots of idle CPU time left, the only thing that could make
a difference is timeslice length.

to 'fix' this (temporarily), renice all the non-SCHED_FIFO processes to
nice +19, that will give them the minimum timeslice length.

still dropped sound? If this fixes it then we can think about ways to fix
it for real.

again, what does it need to cause the 'bad' situation - too much latency
in the sound delivery path causing the audio buffers to starve? (or audio
buffers to be dropped?)

> CPU states: 19.4% user, 27.7% system, 0.0% nice, 52.7% idle

idle time in this snapshot too.

	Ingo

