Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286953AbRL1SDL>; Fri, 28 Dec 2001 13:03:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286952AbRL1SDC>; Fri, 28 Dec 2001 13:03:02 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:36110 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S286948AbRL1SCv>; Fri, 28 Dec 2001 13:02:51 -0500
Date: Fri, 28 Dec 2001 10:06:35 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: "Jeffrey W. Baker" <jwb@saturn5.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.17 absurd number of context switches
In-Reply-To: <Pine.LNX.4.33.0112280940060.23655-100000@windmill.gghcwest.com>
Message-ID: <Pine.LNX.4.40.0112280959280.1466-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Dec 2001, Jeffrey W. Baker wrote:

>
>
> On Fri, 28 Dec 2001, Alan Cox wrote:
>
> > > Check out those figures for context switches!  30,000 switches per second
> > > with only three runnable processes and practically no block I/O seems
> > > quite high to me.  You can also see that the system is spending half its
> > ..
> > > Is this a scheduler worst-case, something to be expected, or something I
> > > can work around?
> >
> > The scheduler is _good_ at the three process case. Run some straces it looks
> > more like postgres is doing wacky yield based locks.
>
> All I see in strace is semop forever
>
> [pid 10076]      0.000054 semop(1179648, 0xbfffe6e8, 1 <unfinished ...>
> [pid 10077]      0.000224 <... semop resumed> ) = 0
> [pid 10077]      0.000077 semop(1179648, 0xbfffe1e8, 1) = 0
> [pid 10077]      0.000057 semop(1179648, 0xbfffe0f8, 1 <unfinished ...>
> [pid 10076]      0.000128 <... semop resumed> ) = 0
> [pid 10076]      0.000035 semop(1179648, 0xbfffe6a8, 1) = 0
> [pid 10076]      0.000127 semop(1179648, 0xbfffe758, 1 <unfinished ...>
> [pid 10077]      0.000085 <... semop resumed> ) = 0
> [pid 10077]      0.000075 semop(1179648, 0xbfffe0f8, 1) = 0
> [pid 10077]      0.000155 semop(1179648, 0xbfffdfb8, 1 <unfinished ...>
> [pid 10076]      0.000401 <... semop resumed> ) = 0
> [pid 10076]      0.000034 semop(1179648, 0xbfffe758, 1) = 0
> [pid 10076]      0.000046 semop(1179648, 0xbfffe758, 1 <unfinished ...>
> [pid 10077]      0.000113 <... semop resumed> ) = 0
> [pid 10077]      0.000040 semop(1179648, 0xbfffdf78, 1) = 0
> [pid 10077]      0.000051 semop(1179648, 0xbfffdfc8, 1 <unfinished ...>
> [pid 10076]      0.000317 <... semop resumed> ) = 0
> [pid 10076]      0.000055 semop(1179648, 0xbfffe718, 1) = 0
> [pid 10076]      0.000083 semop(1179648, 0xbfffe8d8, 1 <unfinished ...>
> [pid 10077]      0.000217 <... semop resumed> ) = 0
> [pid 10077]      0.000091 semop(1179648, 0xbfffdfc8, 1) = 0
> [pid 10077]      0.000057 semop(1179648, 0xbfffdfa8, 1 <unfinished ...>
> [pid 10076]      0.000191 <... semop resumed> ) = 0
> [pid 10076]      0.000037 semop(1179648, 0xbfffe898, 1) = 0
> [pid 10076]      0.000054 semop(1179648, 0xbfffe928, 1 <unfinished ...>
> [pid 10077]      0.000056 <... semop resumed> ) = 0
> [pid 10077]      0.000034 semop(1179648, 0xbfffdf68, 1) = 0

It's not the a sys_sched_yield() problem. probably and IPC_NOWAIT issue




- Davide


