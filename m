Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274683AbRJJEmi>; Wed, 10 Oct 2001 00:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274684AbRJJEm2>; Wed, 10 Oct 2001 00:42:28 -0400
Received: from paloma12.e0k.nbg-hannover.de ([62.159.219.12]:63367 "HELO
	paloma12.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S274683AbRJJEmQ>; Wed, 10 Oct 2001 00:42:16 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: 2.4.10-ac10-preempt lmbench output.
Date: Wed, 10 Oct 2001 06:42:37 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Robert Love <rml@tech9.net>, Andrew Morton <andrewm@uow.edu.au>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20011010035818.A556B1E760@Cantor.suse.de> <20011010062300.H726@athlon.random>
In-Reply-To: <20011010062300.H726@athlon.random>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20011010044225Z274683-760+23044@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 10. Oktober 2001 06:23 schrieb Andrea Arcangeli:
> On Wed, Oct 10, 2001 at 05:57:46AM +0200, Dieter Nützel wrote:

[...]
> > I get the dropouts (2~3 sec) after dbench 32 is running for 9~10 seconds.

It is mostly only _ONE_ dropout like above.
 
> > I've tried with RT artds and nice -20 mpg123.
> >
> > Kernel: 2.4.11-pre6 + 00_vm-1 + preempt
> >
> > Only solution:
> > I have to copy the test MPG3 file into /dev/shm.
>
> If copying the mp3 data into /dev/shm fixes the problem it could be also
> an I/O overload.

The above plus nice -20 mpg123 *.mp3
I've forgotten to clearify this, sorry.

Should I try 2.4.11 + 00_vm-1 or 2.4.11aa1, again?

> So if this is just an I/O overload (possible too) some possible fixes
> could be:
>
> 1) buy faster disk

:-)

But I've checked it with two SCSI disks.
IBM DDYS U160 10k for dbench 32 and
IBM DDRS UW 7.2k for the mp3s

=> the hiccup

> 2) try with elvtune -r 1 -w 2 /dev/hd[abcd] /dev/sd[abcd] that will try
>    to decrease the global I/O disk bandwith of the system, but it will
>    increase fairness

OK, after I had some sleep...

> > CPU (1 GHz Athlon II) is ~75% idle during the hiccup.
>
> Of course I can imagine. This is totally unrelated to scheduler
> latencies, it's either vm write throttling or I/O congestion so you
> don't have enough bandwith to read the file or both.

It is only _ONE_ time during the whole dbench 32 run.

> > The dbench processes are mostly in wait_page/wait_cache if I remember
> > right. So I think that you are right it is a file IO wait (latency)
> > problem.
>
> Yes.
>
> > Please hurry up with your read/write copy-user paths lowlatency patches
> > ;-)
>
> In the meantime you can use the preemption points in the copy-user, they
> can add a bit more of overhead but nothing interesting, I believe it's
> more a cleanup than an improvement to move the reschedule points in
> read/write as suggested by Andrew.
>
> BTW, this is the relevant patch:
>
> 	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.11
>aa1/00_copy-user-lat-5

GREAT.

> You're probably more interested in the possible heuristic that I've in
> mind to avoid xmms to wait I/O completion for the work submitted by
> dbench. Of course assuming the vm write throttling was a relevant cause
> of the dropouts, and that the dropouts weren't just due an I/O
> congestion (too low disk bendwith).

> BTW, to find out if the reason of the dropouts where the vm write
> throttling or the too low disk bandwith you can run ps l <pid_of_xmms>,

What do you mean here? I can't find a meaningfully ps option.

> if it says wait_on_buffer all the time it's the vm write throttling, if
> it says always something else it's the too low disk bandwith, I suspect
> as said above that you'll see both things because it is probably a mixed
> effect. If it's not vm write throttling only a faster disk or elvtune
> tweaking can help you, there's no renice-IO -n -20 that allows to
> prioritize the I/O bandwith to a certain application.

Thanks,
	Dieter
