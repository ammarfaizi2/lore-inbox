Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130154AbRB1N1S>; Wed, 28 Feb 2001 08:27:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130156AbRB1N1I>; Wed, 28 Feb 2001 08:27:08 -0500
Received: from mailc.telia.com ([194.22.190.4]:65247 "EHLO mailc.telia.com")
	by vger.kernel.org with ESMTP id <S130154AbRB1N0z>;
	Wed, 28 Feb 2001 08:26:55 -0500
Content-Type: text/plain; charset=US-ASCII
From: Roger Larsson <roger.larsson@norran.net>
To: Andrew Morton <andrewm@uow.edu.au>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Rik van Riel <riel@conectiva.com.br>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Fwd: [pre PATCH] freezes]
Date: Wed, 28 Feb 2001 14:17:12 +0100
X-Mailer: KMail [version 1.2]
In-Reply-To: <3A9CE94C.A75B2D3C@uow.edu.au>
In-Reply-To: <3A9CE94C.A75B2D3C@uow.edu.au>
MIME-Version: 1.0
Message-Id: <01022814171200.00779@dox>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On the numlock issue...

There was a week when I got no freezes, that was after 2.4.2-pre1
so I looked around and tried to find the reason (2.4.1 freezed)
The only thing I could find was this...

But now they have reappeared!!!

I have started to use xosview on top to get a feel for what is happening.
The situation after freeze has been similar (2 captures with xosview this far
one with KTimeMon

_Programs running_
term (konsole) running
xosview
kppp
kmail
konqueror
(started in quickly one after another)

Load above 1 (latest CPU0 has been different 100% and 9%)
MEM        91M (both times!)
SWAP 0  (could be a rounding problem in xosview)
PAGE 0
INTS 0,4 (one time 15 the other time 12)

The MEM & SWAP is interesting.
I have 96M RAM. Lots and lots of swap space
"Adding Swap: 530136k swap-space (priority -1)
 Adding Swap: 133048k swap-space (priority -2)"
Cache was about as big as USED+SHARE, BUFF only
a few precent about the size of FREE.

When the freeze happened MEM was rising, I wonder if
I got the freeze when hitting swap...

I retry with wider xosview...

/RogerL

On Wednesday 28 February 2001 13:04, Andrew Morton wrote:
> Alan, this 2.2 patch seems very sane to me.
>
> If we take a page fault in (say) the get_user() in write_chan()
> then handle_mm_fault() will run in state TASK_INTERRUPTIBLE.  If
> a filesystem calls schedule() without setting task->state it's
> lights out.  reiserfs_get_block() is one such.
>
> It can't hurt.
>
> But I don't see why this should cause numlock to
> stop working...
>
>
>
> -------- Original Message --------
> Subject: [pre PATCH] freezes
> Date: Thu, 15 Feb 2001 15:29:12 +0100
> From: Roger Larsson <roger.larsson@norran.net>
> To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
>
>
> --------------Boundary-00=_OWYSLVSP7YK356P9A2LT
> Content-Type: text/plain;
>   charset="iso-8859-1"
> Content-Transfer-Encoding: 8bit
>
> Hi,
>
> I have had occasional freezes (complete NumLock won't work) for some time.
> I blamed HW, irq conflicts, temperature problems, ...
>
> But suddenly with 2.4.2-pre1 the problems disappeared!
>
> Since 2.4.2-pre1 was rather short I took the time to try to find out what
> could be the fix.
>
> I found one candidate, the setting of  TASK_RUNNING in handle_mm_fault.
>
> Since the problem had appeared on both 2.4 and 2.2.18 I started to try to
> reproduce the problem in an unpatched 2.2 - it took some time, got the
> freeze today.
>
> During this time I have tried to collect information of the freezes on KDE
> mailing lists - I do now have three additional reports (one running 2.2.17)
> Hardware has varied.
>
> I have now compiled and installed this patch but since it can't be proven
> to fix the problem I submit it now.
>
> /RogerL

-- 
Home page:
  none currently
