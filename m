Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277203AbRJDXeu>; Thu, 4 Oct 2001 19:34:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277265AbRJDXej>; Thu, 4 Oct 2001 19:34:39 -0400
Received: from peace.netnation.com ([204.174.223.2]:2573 "EHLO
	peace.netnation.com") by vger.kernel.org with ESMTP
	id <S277203AbRJDXeW>; Thu, 4 Oct 2001 19:34:22 -0400
Date: Thu, 4 Oct 2001 16:34:50 -0700
From: Simon Kirby <sim@netnation.com>
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
Message-ID: <20011004163450.A23708@netnation.com>
In-Reply-To: <20011004150119.B2373@netnation.com> <309761448.1002241541@[195.224.237.69]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <309761448.1002241541@[195.224.237.69]>; from linux-kernel@alex.org.uk on Fri, Oct 05, 2001 at 12:25:41AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2001 at 12:25:41AM +0100, Alex Bligh - linux-kernel wrote:

> > Ingo is not limiting interrupts to make it drop packets and forget things
> > just so that userspace can proceed.  Instead, he is postponing servicing
> > of the interrupts so that the card can batch up more packets and the
> > interrupt will retrieve more at once rather than continually leaving and
> > entering the interrupt to just pick up a few packets.  Without this, the
> > interrupt will starve everything else, and nothing will get done.
> 
> Ah OK. in this case already looking at interupt coalescing at firmware
> level which mitigates this 'earlier on', however even this
> stratgy fails at higher pps levels => i.e. in these circumstances
> the card buffer is already full-ish, as the interrupt has already been
> postponed, and postponing it further can only cause dropped packets
> through buffer overrun.

Right.  But right now, the fact that the packets are so small and are
arriving so fast makes the interrupt handler overhead starve everything
else, and interrupt mitigation can make a box that would otherwise be
dead work properly.  If the box gets even more packets and the CPU
saturates, then the box would be dead before without the patch anyway.

Simon-

[  Stormix Technologies Inc.  ][  NetNation Communications Inc. ]
[       sim@stormix.com       ][       sim@netnation.com        ]
[ Opinions expressed are not necessarily those of my employers. ]
