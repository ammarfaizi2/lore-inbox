Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280862AbRKBWnC>; Fri, 2 Nov 2001 17:43:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280861AbRKBWmx>; Fri, 2 Nov 2001 17:42:53 -0500
Received: from 216-239-45-7.google.com ([216.239.45.7]:43608 "EHLO
	corp.google.com") by vger.kernel.org with ESMTP id <S280860AbRKBWmk>;
	Fri, 2 Nov 2001 17:42:40 -0500
Message-ID: <3BE3215A.9000302@google.com>
Date: Fri, 02 Nov 2001 14:42:34 -0800
From: Ben Smith <ben@google.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Google's mm problem - not reproduced on 2.4.13
In-Reply-To: <E15yzlQ-00021P-00@starship.berlin> <20011102181758Z16039-4784+420@humbolt.nl.linux.org> <9ruvkd$jh1$1@penguin.transmeta.com> <3BE30B3D.1080505@google.com> <9rv2nc$kgi$1@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Anyway, I posted a suggested patch that should fix the behaviour, but it
> doesn't fix the fundamental problem with locking the wrong kinds of
> pages (ie you're definitely on your own if you happen to lock down most

> of the low 1GB of an intel machine).


I've tried the patch you sent and it doesn't help. I applied the patch 
to 2.4.13-pre7 and it hung the machine in the same way (ctrl-alt-del 
didn't work). The last few lines of vmstat before the machine hung look 
like this:
  0  1  0      0 133444   5132 3367312   0   0 31196     0 1121  2123 
0   6  94
  0  1  0      0  63036   5216 3435920   0   0 34338    14 1219  2272 
0   5  95
  2  0  1      0   6156   1828 3494904   0   0 31268     0 1130  2198 
0  23  77
  1  0  1      0   3596    864 3498488   0   0  2720    16 1640  1068 
0  88  12


> It would be interesting to hear whether that is equally true in the new
> VM that doesn't necessarily page stuff out unless it can show that the
> memory pressure is actually from VM mappings.
> 
> How big is your mlock area during real load? Still the "max the kernel
> will allow"? Or is that just a benchmark/test kind of thing?

I haven't had a chance to try my real app yet, but my test application 
is a good simulation of what the real program does, minus any of the 
accessing of the data that it maps. Since it's the only application 
running, and for performance reasons we'd need all of our data in 
memory, we map the "max the kernel will allow".

As another note, I've re-written my test application to use madvise 
instead of mlock, on a suggestion from Andrea. It also doesn't work. For 
2.4.13, after running for a while, my test app hangs, using one CPU, and 
kswapd consumes the other CPU. I was eventually able to kill my test app.

I've also re-written my test app to use anonymous mmap, followed by a 
mlock and read()'s. This actually does work without problems, but 
doesn't really do what we want for other reasons.
  - Ben

Ben Smith
Google, Inc.

