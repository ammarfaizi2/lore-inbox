Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273163AbRIPDv1>; Sat, 15 Sep 2001 23:51:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273165AbRIPDvR>; Sat, 15 Sep 2001 23:51:17 -0400
Received: from lsmls01.we.mediaone.net ([24.130.1.20]:23184 "EHLO
	lsmls01.we.mediaone.net") by vger.kernel.org with ESMTP
	id <S273163AbRIPDvJ>; Sat, 15 Sep 2001 23:51:09 -0400
Message-ID: <3BA421C2.761F1EDD@kegel.com>
Date: Sat, 15 Sep 2001 20:51:30 -0700
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-dan i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Vitaly Luban <vitaly@luban.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] Signal-per-fd for RT signals
In-Reply-To: <3BA2AFFF.C7B8C4DF@kegel.com> <3BA2E144.FB0E5D55@luban.org> <3BA2E99A.1134E382@kegel.com> <3BA350A7.7D39FC23@kegel.com> <3BA3C61A.DED5A27A@luban.org> <3BA3D10B.FE3C6C79@kegel.com> <3BA40FEC.A6E0557E@luban.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vitaly Luban wrote:
> 
> Dan Kegel wrote:
> 
> > But I doubt very much that SIGIO style readiness notification will ever
> > be used with files.  aio_{read,write} style completion notification is
> > much more appropriate for file I/O, and my proposal (if I make it) will not
> > affect that.
> 
> Well, when I have an app, that deals primarily with network I/O, and, at the
> same time has some file I/O, it's only logical to have all I/O handling within
> the same event loop, and if loop is RT-signals based...

I agree that having a single event source and event loop is attractive,
and want Linux to support it.  But my proposal doesn't get in the way of
that at all.  Let's say you use my patch to pick up network readiness events,
and have aio_{read,write}() send realtime signals when disk I/O is complete.
You can distinguish them nicely by using separate signal numbers, or you
can distinguish them based on the value of si_code (which will be SI_ASYNC
for the completion notifications, and SI_SIGIO or something like that for the
readiness notifications).
No problem, and you still have a unified event queue.

> > Thanks again for creating and maintaining your patch!  I look forward to
> > stress-testing the next version.
> 
> Could you please try attached one? It's mostly untested, but my home site
> will be down next week.
> 
> And thank you for your efforts also :)
> I'm looking forward to see a test case, all I could come up with happily
> runs on the old version.

OK, I'll see if I can whip together a test case tomorrow.  (No promises --
my wife is starting to wonder if I'll ever emerge from my office.)

- Dan
