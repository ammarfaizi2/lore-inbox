Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265038AbUF1Pry@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265038AbUF1Pry (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 11:47:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265042AbUF1Pry
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 11:47:54 -0400
Received: from mail024.syd.optusnet.com.au ([211.29.132.242]:52446 "EHLO
	mail024.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S265038AbUF1Prt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 11:47:49 -0400
Message-ID: <40E03D94.6030804@kolivas.org>
Date: Tue, 29 Jun 2004 01:47:32 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7 (X11/20040615)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: root@chaos.analogic.com
Cc: Timothy Miller <miller@techsource.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Nice 19 process still gets some CPU
References: <40E035CE.1020401@techsource.com> <40E03376.20705@kolivas.org> <40E03C2D.5000809@techsource.com> <40E03844.1080000@kolivas.org> <Pine.LNX.4.53.0406281131190.4245@chaos>
In-Reply-To: <Pine.LNX.4.53.0406281131190.4245@chaos>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Richard B. Johnson wrote:
| On Tue, 29 Jun 2004, Con Kolivas wrote:
|
|
|>-----BEGIN PGP SIGNED MESSAGE-----
|>Hash: SHA1
|>
|>Timothy Miller wrote:
|>|
|>|
|>| Con Kolivas wrote:
|>|
|>|>
|>|> It definitely should _not_ starve. That is the unixy way of doing
|>|> things. Everything must go forward. Around 5% cpu for nice 19 sounds
|>|> just right. If you want scheduling only when there's spare cpu cycles
|>|> you need a sched batch(idle) implementation.
|>|>
|>|>
|>|
|>| Well, since I can't rewrite the app, I can't make it sched batch.  Nice
|>| values are an easy thing to get at for anything that's running.
|>|
|>| Besides, comparing nice 0 to nice 19, I'd expect something more like a
|>| 100:1 ratio or worse.  (That is, I don't expect nice to be linear.)
|>|
|>| Maybe this is just me, but when I set a process to the worst possible
|>| priority (nice 19), I expect it only to run when nothing else needs the
|>| CPU.
|>
|>
|>Sched batch is a kernel modification, and a simple wrapper will allow
|>you  to run _any_ program as sched batch without modifying it's source.
|>
|>The design has had that ratio of 20:1 for a very long time so now is not
|>the time to suddenly decide it should be different. However if you want
|>to make it 100:1 for your machine feel free to edit kernel/sched.c
|>and change
|>#define MIN_TIMESLICE		( 10 * HZ / 1000)
|>to
|>#define MIN_TIMESLICE		( 1 * HZ / 1000)
|>
|>That will give you more what you're looking for.
|>
|>Con
|
|
|
| And if HZ is 100, you have gone from 1 to 0 which probably
| means you haven't done anything. It seems that if a process
| is computable, it will always get the CPU at least for one
| tick.

Well that aint half obvious. He implied he was running a vanilla kernel
which does not support setting Hz.

|
| The original poster wants it to not get the CPU if there is
| anything else that is computable. Since the scheduler looks
| at each task in turn, I don't think that ever happens with
| the either SCHED_FIFO or SCHED_RR. Maybe he can change the
| policy to SCHED_OTHER and see if that works.

Errr sched other is sched normal by the way. What he's looking for is
sched batch.

|
| The granularity of -19 to +19 is not really very good for
| fine process control in Unix..

You're kidding. How often do you need that fine control? I feel a sched
batch implementation is required... which is why I made one. I've not
bothered to even begin to try pushing it upstream because it is not
securely enough constructed to prevent DoS when a semaphore is held. I
don't think anyone will fully tackle this problem any time soon.

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFA4D2UZUg7+tp6mRURAstVAJ9L0i1A94cPhIZvgMK5jfIE4GC5qgCdGRc6
F9FlyerkoUD9etNA6qfK1cE=
=XMkX
-----END PGP SIGNATURE-----
