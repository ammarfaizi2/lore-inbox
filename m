Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317300AbSGOFQS>; Mon, 15 Jul 2002 01:16:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317326AbSGOFQR>; Mon, 15 Jul 2002 01:16:17 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:60174 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317300AbSGOFQQ>; Mon, 15 Jul 2002 01:16:16 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: HZ, preferably as small as possible
Date: Mon, 15 Jul 2002 05:15:50 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <agtlq6$iht$1@penguin.transmeta.com>
References: <3D2DBB7B.9020600@evision-ventures.com> <Pine.LNX.3.96.1020711162333.5732C-100000@gatekeeper.tmr.com>
X-Trace: palladium.transmeta.com 1026710346 25883 127.0.0.1 (15 Jul 2002 05:19:06 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 15 Jul 2002 05:19:06 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.3.96.1020711162333.5732C-100000@gatekeeper.tmr.com>,
Bill Davidsen  <davidsen@tmr.com> wrote:
>On Thu, 11 Jul 2002, Martin Dalecki wrote:
>
>> vmstat.c:
>> 
>> hz = sysconf(_SC_CLK_TCK);	/* get ticks/s from system */
>> 
>> And yes I know the libproc is *evil* in this area.
>> The rest should be an implementation detail of sysconf().
>
>Yes, any of the changes need to make the dynamic value available to
>programs.

No they don't.

Have people looked at the 2.5.x patches?

CLK_TCK is 100 on x86. As it has always been. User land should never
care about whatever random value the kernel happens to use for the
actual timer tick at that particular moment. Especially since the kernel
internal timer tick may well be variable some day.

The fact that libproc believes that HZ can change is _their_ problem.
I've told people over and over that user-level HZ is a constant (and, on
x86, that constant is 100), and that won't change.

So in current 2.5.x times() still counts at 100Hz, and /proc files that
export clock_t still show the same 100Hz rate.

The fact that the kernel internally counts at some different rate should
be _totally_ invisible to user programs (except they get better latency
for stuff like select() and other timeouts).

		Linus
