Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291787AbSB0DCs>; Tue, 26 Feb 2002 22:02:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291776AbSB0DCj>; Tue, 26 Feb 2002 22:02:39 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:31753 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S291775AbSB0DCZ>;
	Tue, 26 Feb 2002 22:02:25 -0500
Message-ID: <3C7C4BED.CD0A03BF@zip.com.au>
Date: Tue, 26 Feb 2002 19:01:01 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-rc2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: george anzinger <george@mvista.com>
CC: wwp <subscript@free.fr>, linux-kernel@vger.kernel.org
Subject: Re: low latency & preemtible kernels
In-Reply-To: <20020226141144.248506fa.subscript@free.fr> <3C7C4520.2783D895@mvista.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

george anzinger wrote:
> 
> wwp wrote:
> >
> > Hi there,
> >
> > here's a newbie question:
> > is it UNadvisable to apply both preempt-kernel-rml and low-latency patches
> > over a 2.4.18 kernel?
> >
> > thanx in advance
> >
> > --
> I believe that the preempt kernel patch or one related to it does the
> low-latency stuff in a more economical way,

Sigh.  Not to single you out, George - I see abject misunderstanding
and misinformation about this sort of thing all over the place.

So let's make some statements:

- preemption is more expensive that explicit scheduling points.   Always
  was, always shall be.

- Anyone who has performed measurements knows that preemption is
  ineffective.  Worst-case latencies are still up to 100 milliseconds.

- preemptability is a *basis* for getting a maintainable low-latency
  kernel.   And that's the reason why I support its merge into 2.5.  Same
  with Ingo, I expect.

  But there's a lot of icky stuff to be done yet to make it effective.

> i.e. takes advantage of the
> preemption code to implement the low-latency stuff.  See the lock-break
> patch that rml has.  It should be right next to the preempt patch.

lock-break is missing the cross-SMP reschedule hack, so on SMP it'll
still have very high worst-case latencies.  If all the other parts
of the low-latency patch were included then preempt+lock-break should
give better results than low-latency.

-
