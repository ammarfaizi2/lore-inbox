Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280857AbRKLR6j>; Mon, 12 Nov 2001 12:58:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280889AbRKLR6a>; Mon, 12 Nov 2001 12:58:30 -0500
Received: from [195.63.194.11] ([195.63.194.11]:38920 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S280857AbRKLR6T>; Mon, 12 Nov 2001 12:58:19 -0500
Message-ID: <3BF01A14.26A5F78@evision-ventures.com>
Date: Mon, 12 Nov 2001 19:51:00 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
Reply-To: dalecki@evision.ag
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: dalecki@evision.ag, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: PATCH 2.4.14 mregparm=3 compilation fixes
In-Reply-To: <Pine.LNX.4.33.0111120838110.15242-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Mon, 12 Nov 2001, Martin Dalecki wrote:
> >
> > The attached patch is fixing compilation and running
> > of the kernel with -mregparm=3 on IA32. The fixes excluding
> > the change in arch/i386/Makefile of course apply to the stock kernel
> > as well, so Linus please include it in 2.4.15 - it just won't hurt...
> 
> I certainly won't enable it in the stock kernel, considering the bad track
> record gcc has had with regparm under register pressure, but the
> "asmlinkage" parts look like real fixes.

Yes that was always my intention. The chunk changing the CFLAGS wasn't
deleted from the patch only for the purpose of referrence. I did hope
that I made this clear in my announcement, but i failed apparently ;-).

Despite this I would like to make clear that I have compiled my own
"RedHat 7.2" compatible kernel-RPM set with the patch applied already
and
didn't encounter any problems thus far... Even an ORACLE DB just started
without noticing that anything changed beneath it.
Since this all was done on my notebook, I can say that there where even 
no problems with any of the "less mature" kernel parts 
like USB handling, CardBus and so on and so on
(Anybody please note: I didn't say "immature" just "less mature",
more like "fresh" no pun intendid.)

Apparently GCC got really much better in regard of this stuff recently.
I'm using RedHat GCC 2.96 brand gcc-2.96-99...
And I reiterate that I'm just happy running a whole
kernel compiled with mregparm=3 without any anomalities thus far.

> However, it's kind of sad to make some of the more timing-critical stuff
> (like schedule_tail) be asmlinkage - it might be worth it to do it the
> other way around, and make it FASTCALL() and change the assembly code to
> pass arguments in registers. That way, the calling convention is still the
> same on both regparm=3 and without, but instead of defaulting to the slow
> method we'd default to the fast one..

Yes that's right. However if you look close than you will notice, that
asmlinkage is quite a bad name. There should be a asmlinkage with
mregparm=3
ideally and a syslinkage macro for system call entry points with
mregparm=0 there.
And then fixes are fixes and with the current semantics my patch is
really just fixing bugs. (Tougth not "tragical" ones). So if I see
this fix applied I will make the above described improvements in 2.5
;-).
They are not difficult anyway, just a bit tedious... and then they would
affect a bit more code around there. In esp. the system call
declarations
and we have a lot of them already ;-).


So long...
