Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132373AbREHMZW>; Tue, 8 May 2001 08:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132395AbREHMZM>; Tue, 8 May 2001 08:25:12 -0400
Received: from medusa.sparta.lu.se ([194.47.250.193]:17760 "EHLO
	medusa.sparta.lu.se") by vger.kernel.org with ESMTP
	id <S132373AbREHMZD>; Tue, 8 May 2001 08:25:03 -0400
Date: Tue, 8 May 2001 13:09:40 +0200 (MET DST)
From: Bjorn Wesen <bjorn@sparta.lu.se>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [Question] Explanation of zero-copy networking
In-Reply-To: <Pine.LNX.3.95.1010507145625.6441A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.3.96.1010508125601.2292A-100000@medusa.sparta.lu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 May 2001, Richard B. Johnson wrote:
> Basically, "no copy" is an academic exercise. It makes the first
> packet get sent more quickly, after which everything slows to
> the natural bandwidth of the system.
> 
> If you used a server for multicast-only.  In other words,  you
> just spewed out unidirectional data, you still slow to the rate
> at which the media can take the data.  And CPUs can obtain or
> generate these data a lot faster than 100-base can sink them.

This is an awfully PC-centric way of putting things. You assume that the
only ones who use Linux are those with a 1 ghz CPU and those 66 mhz PCI
boards and whatever. You simply cannot make that assumption anymore; the
diversity of Linux HW these days is so broad that the sweet spot between
CPU cycles, memory bandwidth etc which controls the code optimization
fluctuates wildly.

A simple kernel profile of one of our embedded Linux systems for example
show csum_partial_copy limiting the performance. Now for us zero-copy
cannot be implemented anyway because we don't have a checksumming ethernet
controller but if we had, we could enhance performance by 50% by skipping
the copy perhaps. And there definitely are no 1 GHZ embedded CPU's in the
same price range to choose instead, or Rambus memories etc.. raw power
simply is not an option sometimes.

It's still true of course that it's not obvious that the cycles spent on
copying can be used for anything better in all cases.

However, the beauty of open-source is that there is no need to debate over
whether something should be done or not. If someone feels the need, it
will be coded and if it's good people will use it. In this case, if anyone
gets a 200% boost in performance, they probably won't listen to the
argument that "it's academic" afterwards :) And some others might go
twiddle their hardware and skip the zero-copy mechanism altogether.

-BW

