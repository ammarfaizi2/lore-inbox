Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318175AbSIEUM2>; Thu, 5 Sep 2002 16:12:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318176AbSIEUM2>; Thu, 5 Sep 2002 16:12:28 -0400
Received: from chaos.analogic.com ([204.178.40.224]:1408 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S318175AbSIEUM0>; Thu, 5 Sep 2002 16:12:26 -0400
Date: Thu, 5 Sep 2002 16:16:52 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Peter Surda <shurdeek@panorama.sth.ac.at>
cc: linux-kernel@vger.kernel.org
Subject: Uptime timer-wrap
In-Reply-To: <20020905180253.GC2567@noir.cb.ac.at>
Message-ID: <Pine.LNX.3.95.1020905160808.141A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Sep 2002, Peter Surda wrote:

> Dear kernel developers and other guys with deep linux knowledge,
> 
> I am posting here because I think this is an interesting story, and even if
> noone can find a answer now, maybe this can serve as a reference for future.
> 
> I am not sure what information is relevant to the story, so I'll try to
> mention anything I consider relevant.
[SNIPPED timer-wrap story]

I tried to simulate your observation by making a driver that
set the 'jiffies' count upon an 'open'. The idea was to get
the jiffies count to something close to wrap so I didn't have to
wait a long time.

Anyway, I found that setting the jiffies count to more than a
few hundred counts into the future, causes the machine to halt
with no interrupts (no Capslock, no NumLock, no network ping, etc).

The machine just stops and I don't understand why. 


	spin_lock_irqsave(&xlock, flags);
        jiffies += 0x1000;
	spin_lock_irqrestore(&xlock, flags);

	... works just fine, but, changing 0x1000 to 0x7fffffff causes
the machine to stop as reported. 

Does anybody have a clue?


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

