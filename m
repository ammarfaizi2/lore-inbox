Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289010AbSAIUS0>; Wed, 9 Jan 2002 15:18:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289001AbSAIUSL>; Wed, 9 Jan 2002 15:18:11 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:13073 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S289012AbSAIURr>; Wed, 9 Jan 2002 15:17:47 -0500
Date: Wed, 9 Jan 2002 12:15:59 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Davide Libenzi <davidel@xmailserver.org>,
        Mike Kravetz <kravetz@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
        george anzinger <george@mvista.com>
Subject: Re: [patch] O(1) scheduler, -D1, 2.5.2-pre9, 2.4.17
In-Reply-To: <Pine.LNX.4.33.0201091154440.2276-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0201091212380.7845-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 9 Jan 2002, Ingo Molnar wrote:
>
> 2.5.2-pre10-vanilla running the test at the default priority level:
>
>     # ./chat_s 127.0.0.1
>     # ./chat_c 127.0.0.1 10 1000
>
>     Average throughput : 124676 messages per second
>     Average throughput : 102244 messages per second
>     Average throughput : 115841 messages per second
>
>     [ system is unresponsive at the start of the test, but
>       once the 2.5.2-pre10 load-estimator establishes which task is
>       interactive and which one is not, the system becomes usable.
>       Load can be felt and there are frequent delays in commands. ]
>
> 2.5.2-pre10-vanilla running at nice level 19:
>
>     # nice -n 19 ./chat_s 127.0.0.1
>     # nice -n 19 ./chat_c 127.0.0.1 10 1000
>
>     Average throughput : 214626 messages per second
>     Average throughput : 220876 messages per second
>     Average throughput : 225529 messages per second
>
>     [ system is usable from the beginning - nice levels are working as
>       expected. Load can be felt while executing shell commands, but the
>       system is usable. Load cannot be felt in truly interactive
>       applications like editors.

Ingo, there's something wrong there.

Not a way in hell should "nice 19" cause the throughput to improve like
that. It looks like this is a result of "nice 19" simply doing _different_
scheduling, possibly more batch-like, and as such those numbers cannot
sanely be compared to anything else.

(And if they _are_ comparable, then you should be able to get the good
numbers even without "nice 19". Quite frankly it sounds to me like the
whole chat benchmark is another "dbench", ie doing unbalanced scheduling
_helps_ it performance-wise, which implies that it's probably a bad
benchmark to look at numbers for).

		Linus

