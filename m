Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288819AbSANGZj>; Mon, 14 Jan 2002 01:25:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288820AbSANGZ3>; Mon, 14 Jan 2002 01:25:29 -0500
Received: from femail13.sdc1.sfba.home.com ([24.0.95.140]:52934 "EHLO
	femail13.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S288819AbSANGZM>; Mon, 14 Jan 2002 01:25:12 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Daniel Phillips <phillips@bonn-fries.net>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, rml@tech9.net (Robert Love)
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Date: Sun, 13 Jan 2002 17:23:13 -0500
X-Mailer: KMail [version 1.3.1]
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), arjan@fenrus.demon.nl,
        linux-kernel@vger.kernel.org
In-Reply-To: <E16Pn2o-0007I8-00@the-village.bc.nu> <E16Q09g-0000kn-00@starship.berlin>
In-Reply-To: <E16Q09g-0000kn-00@starship.berlin>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020114062512.LOBA7324.femail13.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 14 January 2002 12:59 am, Daniel Phillips wrote:
> On January 13, 2002 04:59 pm, Alan Cox wrote:
> > > > I disable a single specific interrupt, I don't disable the timer
>
> interrupt.
>
> > > > Your code doesn't seem to handle that.
> > >
> > > It can if we increment the preempt_count in disable_irq_nosync and
> > > decrement it on enable_irq.
> >
> > A driver that knows about how its irq is handled and that it is sole
> > user (eg ISA) may and some do leave it disabled for hours at a time
>
> Good point.  Preemption would be disabled for that thread if we mindlessly
> shut it off for every irq_disable.  For that driver we probably just want
> to leave preemption enabled, it can't hurt.

Once we return to user space, we can preempt again.  If preemption is still 
disabled upon return from the syscall, I'd say it's okay to switch it back on 
now. :)

Unless I'm missing something fundamental...?

Rob
