Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267573AbTBXVyS>; Mon, 24 Feb 2003 16:54:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267577AbTBXVyS>; Mon, 24 Feb 2003 16:54:18 -0500
Received: from sccrmhc02.attbi.com ([204.127.202.62]:48605 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP
	id <S267573AbTBXVyR>; Mon, 24 Feb 2003 16:54:17 -0500
Subject: Re: [PATCH] elapsed times wrap
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel@vger.kernel.org
Cc: hugh@veritas.com, kai@tp1.ruhr-uni-bochum.de
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 24 Feb 2003 17:00:45 -0500
Message-Id: <1046124046.32116.264.camel@cube>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins writes:
> On Sat, 22 Feb 2003, Kai Germaschewski wrote:
>> On Sat, 22 Feb 2003, Hugh Dickins wrote:

>>> Userspace shows huge elapsed time across jiffies wrap:
>>> with USER_HZ less then HZ, sys_times needs jiffies_64
>>> to calculate its retval.
>>
>> That makes me wonder, aren't all uses of
>> jiffies_to_clock_t() broken then? 
>
> I believe you're right, but it's less obvious to me
> that the other uses really want fixing e.g. would we
> be happy to maintain utime,stime,cutime,cstime as
> 64-bit on a 32-bit machine?
>
>> Well, all which take an absolute time as an argument at least.
>
> Yes, it's much more important to fix those where userspace
> habitually takes the difference.  That certainly applies
> to the return value from sys_times, but I don't see any
> other cases as clear (though userspace may have good reason
> to take the difference of any of them).
>
> Perhaps a procps expert can advise?

That depends on how much you care about the problems.
Some that come to mind:

The OOM killer will be more likely to kill the wrong process.
CPU usage stats will be worthless junk.

On a 4-way box, you can hit troubles with cutime after
just 2 weeks of usage.

Consider changing just cutime. It's the value most likely
to wrap. Plain utime would be the second priority.


