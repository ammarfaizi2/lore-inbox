Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268856AbRHWQaQ>; Thu, 23 Aug 2001 12:30:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268908AbRHWQaA>; Thu, 23 Aug 2001 12:30:00 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:33031 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S268900AbRHWQ3u>;
	Thu, 23 Aug 2001 12:29:50 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200108231629.UAA06901@ms2.inr.ac.ru>
Subject: Re: Problems with kernel-2.2.19-6.2.7 from RH update for 6.2
To: dyp@perchine.com (Denis Perchine)
Date: Thu, 23 Aug 2001 20:29:50 +0400 (MSK DST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010823014559.38E6D1FD74@mx.webmailstation.com> from "Denis Perchine" at Aug 23, 1 11:32:47 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> > Where? httpd does not connect().
> 
> For read/write. Although it is incorrect to compare as thttpd is serving =
> more=20
> than one connect.

It is even worse. Useless operation in data path. read/write will return
the error, if connection died in any case.


> > I see. If tuning is goal, it is right way. Amount of syscalls is the sa=
> me
> > as with alarm, but logic is cleaner.
> 
> Logic with alarms will not work in multithreaded case.

I meaned _your_ logic is cleaner . :-)


> I assume that using SO_RCVTIME/SO_SNDTIME would be better in terms of=20
> performance. 

Not very much. But code becomes simpler.

Select() is better sometimes, f.e. when program uses signals
(and glibc uses signals _internally_ when multithreaded, breaking lots
 of things, do you know this? :-)). In this case you need to raclulate
remaining time to restart poll/read/write, linux select returns it.

> layer to use sync IP... 

What is "sync"?


> be (approximately)? if we assume that I have lots of connects which trans=
> fers=20
> small amount of data in each (1-2K).

It depends. The advantage of read/write with SO_*TIMEO is that
in all 100% of cases data arrive in time or you send immeadiately
and appear in right place and do not waste cache and cycles to exit from
select and to enter to read/write. Also, select() is pretty
suboptimal.

Alexey
