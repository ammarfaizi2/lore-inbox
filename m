Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133025AbRAQUkA>; Wed, 17 Jan 2001 15:40:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132996AbRAQUju>; Wed, 17 Jan 2001 15:39:50 -0500
Received: from p3EE0E419.dip.t-dialin.net ([62.224.228.25]:61200 "EHLO
	router.abc") by vger.kernel.org with ESMTP id <S132815AbRAQUji>;
	Wed, 17 Jan 2001 15:39:38 -0500
Message-ID: <3A6602F8.BB3F7ECA@baldauf.org>
Date: Wed, 17 Jan 2001 21:39:20 +0100
From: Xuan Baldauf <xuan--lkml@baldauf.org>
Organization: Medium.net
X-Mailer: Mozilla 4.76 [en] (Win98; U)
X-Accept-Language: de-DE,en
MIME-Version: 1.0
To: Padraig Brady <Padraig@AnteFacto.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Relative CPU time limit
In-Reply-To: <3A65E573.D004302B@baldauf.org> <3A65EDE2.4030204@AnteFacto.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Padraig Brady wrote:

> man setrlimit (or ulimit)
> This is per user though, and only related
> to user accounting really as you can only
> set a limit on the number of CPU seconds
> used.

Yet this is _not_ what I want, especially not for server processes. :-)

>
>
> I would also really like the ability
> to throttle any processes back to a certain
> % of CPU, and extending this to throttling
> users to certain CPU limits which would be
> useful also.
>
> Obviously you would set it up so that all
> available CPU is used, for e.g. if you
> had 2 CPU bound processes running and you
> allocated 1 to 40% and the other 60%, when
> either terminates the other should increase
> to the available CPU (I can't see any reason
> why you would forceably limit a process' CPU
> usage if there was free CPU).
>
> Could the current scheduling logic that uses
> the nice value of a process, do this, and all
> I would have to do is have a % specifying wrapper
> around this?

The nice values have to be dynamic. I seem to happen to see the behaviour that
regardless of which nice value I assign to httpd, great user load kann make the
whole machine slow down to load ~200. (A horribly slow php script *sigh*) I want
to limit the sum of all apache processes (which happen to run with the same UID)
to eat no more than 80% of the available CPU time, at least if there are any
other processes requesting the CPU. The background is that I'm unable to log in
to the server when the load is at 200. Apache is already at nice 5 while sshd is
at nice 0.

Xuân.

>
>
> Any other ideas or will I get hacking..
>
> Padraig.
>
> Xuan Baldauf wrote:
>
> > Hello, (maybe a FAQ, but could not find this question)
> >
> > is it possible with linux2.4 to limit the relative CPU time
> > per process or per UID? I saw something like this about 5
> > years ago on solaris machines, but I have not access to
> > solaris machines anymore. I do not mean limiting the
> > absolute CPU time (e.g. "the process should run 20minutes at
> > maximum and shall be killed after that time), but the
> > relative CPU time (e.g. "apache should consume at most 80%
> > of my servers CPU time and shall be throttled if it was to
> > consume more").
> >
> > Thanx,
> > Xuân. :-)
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > Please read the FAQ at http://www.tux.org/lkml/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
