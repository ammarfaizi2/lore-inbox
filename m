Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277247AbRJDWBP>; Thu, 4 Oct 2001 18:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277244AbRJDWBF>; Thu, 4 Oct 2001 18:01:05 -0400
Received: from peace.netnation.com ([204.174.223.2]:43281 "EHLO
	peace.netnation.com") by vger.kernel.org with ESMTP
	id <S277248AbRJDWAv>; Thu, 4 Oct 2001 18:00:51 -0400
Date: Thu, 4 Oct 2001 15:01:19 -0700
From: Simon Kirby <sim@netnation.com>
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
Message-ID: <20011004150119.B2373@netnation.com>
In-Reply-To: <Pine.LNX.4.33.0110031528370.6272-100000@localhost.localdomain> <302737894.1002234496@[195.224.237.69]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <302737894.1002234496@[195.224.237.69]>; from linux-kernel@alex.org.uk on Thu, Oct 04, 2001 at 10:28:17PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2001 at 10:28:17PM +0100, Alex Bligh - linux-kernel wrote:

> In at least one environment known to me (router), I'd rather it
> kept accepting packets, and f/w'ing them, and didn't switch VTs etc.
> By dropping down performance, you've made the DoS attack even
> more successful than it would otherwise have been (the kiddie
> looks at effect on the host at the end).

No.

Ingo is not limiting interrupts to make it drop packets and forget things
just so that userspace can proceed.  Instead, he is postponing servicing
of the interrupts so that the card can batch up more packets and the
interrupt will retrieve more at once rather than continually leaving and
entering the interrupt to just pick up a few packets.  Without this, the
interrupt will starve everything else, and nothing will get done.

By postponing servicing of the interrupt (and thus increasing latency
slightly), throughput will actually increase.

Obviously, if the card Rx buffers overflow because the interrupts weren't
serviced quickly enough, then packets will be dropped.  This is still
better than the machine not being able to actually do anything with the
received packets (and also not able to do anything else such as allow the
administrator to figure out what is happening).

Simon-

[  Stormix Technologies Inc.  ][  NetNation Communications Inc. ]
[       sim@stormix.com       ][       sim@netnation.com        ]
[ Opinions expressed are not necessarily those of my employers. ]
