Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261278AbTCJKQp>; Mon, 10 Mar 2003 05:16:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261276AbTCJKQp>; Mon, 10 Mar 2003 05:16:45 -0500
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:30364 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id <S261284AbTCJKQl>;
	Mon, 10 Mar 2003 05:16:41 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Mike Galbraith <efault@gmx.de>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.64-mm2->4 hangs on contest
Date: Mon, 10 Mar 2003 21:27:19 +1100
User-Agent: KMail/1.5
References: <200303102012.32465.kernel@kolivas.org> <5.2.0.9.2.20030310075720.00c832f8@pop.gmx.net> <5.2.0.9.2.20030310112452.00ce87b8@pop.gmx.net>
In-Reply-To: <5.2.0.9.2.20030310112452.00ce87b8@pop.gmx.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303102127.19847.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Mar 2003 21:29, Mike Galbraith wrote:
> At 11:05 AM 3/10/2003 +0100, Mike Galbraith wrote:
> >At 08:12 PM 3/10/2003 +1100, Con Kolivas wrote:
> >>On Mon, 10 Mar 2003 18:05, Mike Galbraith wrote:
> >> > At 01:29 PM 3/10/2003 +1100, you wrote:
> >> > >Tried running contest on 2.5.64-mm2 and mm4 and had the same thing
> >>
> >> happen.
> >>
> >> > > It will hang reliably during process_load. I tried not running
> >> > > process_load but it would still get stuck in one of the other loads
> >> > > (either a tar load or list load). I can simply stop contest at that
> >>
> >> stage
> >>
> >> > > but then the machine wont work well hanging at the console after a
> >>
> >> minute
> >>
> >> > > or so. This started at mm2 (doesn't happen with mm1).
> >> > >
> >> > >Here is the sysrq-p and sysrq-t output during process_load (which
> >> > > hangs every time):
> >> >
> >> > hmm, the below looks interesting to me...
> >> >
> >> > >ksoftirqd/0   R C129A000     2      1             3       (L-TLB)
> >> > >Call Trace:
> >> > >  [<c0118f3e>] ksoftirqd+0x5e/0x9c
> >> > >  [<c0118ee0>] ksoftirqd+0x0/0x9c
> >> > >  [<c0106f1d>] kernel_thread_helper+0x5/0xc
> >> >
> >> > I see that too with irman.  You could try renicing the shell you start
> >> > contest from to >= +12.  With irman, what appears to be cpu starvation
> >> > ceases to be a problem at exactly +12.  I also see kapmd constantly
> >>
> >> wanting
> >>
> >> > to run but not being serviced.
> >>
> >>Contest uses a modified process load from irman so it exhibits similar
> >>behaviour. Not sure what +12 actually tells me though :-(
> >
> >Aha!  No wonder your symptoms look so similar.  +12 is just a magic number
> >that works... found by trusty old trial and error method.  What I wanted
> >to see was if your hang would also go away with the same magic number, or
> >if renicing with any value helped you at all.
> >
> >>My simplistic understanding is that the pipe task in process_load gets
> >>constantly elevated as "interactive" by the new scheduler, and nothing
> >> else ever happens.
> >
> >Appears so.  I can make it "work" by doing a dinky (butt ugly:) tweak in
> >activate_task().
>
> Oh, what the heck.  Even a butt ugly patch that works has informational
> value.  Can you try the attached please?  If it works for you too, maybe
> it'll tell Ingo something.

Sure. How about attaching it?

Con
