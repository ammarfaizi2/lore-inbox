Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132571AbRATC0f>; Fri, 19 Jan 2001 21:26:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132809AbRATC0O>; Fri, 19 Jan 2001 21:26:14 -0500
Received: from mtiwmhc28.worldnet.att.net ([204.127.131.36]:52630 "EHLO
	mtiwmhc28.worldnet.att.net") by vger.kernel.org with ESMTP
	id <S132560AbRATCZ5>; Fri, 19 Jan 2001 21:25:57 -0500
Message-ID: <3A68F855.6F16F152@att.net>
Date: Fri, 19 Jan 2001 21:30:45 -0500
From: Michael Lindner <mikel@att.net>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: David Schwartz <davids@webmaster.com>
CC: linux-kernel@vger.kernel.org, Chris Wedgwood <cw@f00f.org>
Subject: Re: PROBLEM: select() on TCP socket sleeps for 1 tick even if data 
 available
In-Reply-To: <NCBBLIEPOCNJOAEKBEAKAEHINCAA.davids@webmaster.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks CW and DS for the prompt replies. However, although each
addressed the (flawed) example I included, neither addressed the
problem described in the text.

I wrote:
> > If select() is waiting for data to become available on a
> > TCP socket FD, and
> > data becomes available, it doesn't return until the next clock tick.

David Schwartz wrote:
>         This program doesn't demonstrate anything except that Linux's sleep time is
> granular. This shouldn't be news to anyone. If you don't force a reschedule,
> everything works the way it's supposed to:

The sample program you included doesn't show anything other
than that select() doesn't sleep at all if there's already
data available when select() starts. That was not my claim
either.

My problem is that if data is NOT available when select()
starts, but becomes available immediately afterwards, select()
doesn't wake up immediately, but sleeps for 1/100 second.
In other words, select doesn't wake up immediately when
data becomes available, but on the next clock tick. This is
not the experience I've had with any other OS I've used,
and is a source of great latency in my application. Since
I am passing data from one process to another, and that
data is generated as a result of data received via a select(),
the next delivery occurs a clock tick later, with the machine
mostly idle.

It can be argued that there's no law governing the latency of
select() waking up, and that my application is expecting
too much. Yet, it runs on other UNIXes and Windows, and I'd
like to be able to get the same high performance out of Linux.

P.S. Chris Wedgwood writes:
	"The time passed to slect is a _minimum_ "

but the man page for select says:
	"timeout  is  an  upper bound on the amount of time elapsed
       before select returns."

who is right?

--
Mike Lindner
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
