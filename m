Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275818AbRJYRf5>; Thu, 25 Oct 2001 13:35:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275778AbRJYRfr>; Thu, 25 Oct 2001 13:35:47 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:53775 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S275861AbRJYRff>; Thu, 25 Oct 2001 13:35:35 -0400
Message-ID: <3BD84C76.9A7DE8CA@zip.com.au>
Date: Thu, 25 Oct 2001 10:31:34 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.12-ac6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Radivoje Todorovic <radivojet@jaspur.com>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [NETWORK MODULE PERFORMANCE]: How to measure it?
In-Reply-To: <BOEOJGNGENIJJMAOLHHCEEIKCEAA.radivojet@jaspur.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Radivoje Todorovic wrote:
> 
> Hello,
> 
> I am confronted with somewhat hard problem. Say one develops Network Module
> X, i.e. using Netfilter hooks. X will (simply) mangle the packets and then
> forward them or do whatever. How can I measure the performance of X module?
> I am not sure exactly what I am asking but say, I have a Linux router with X
> module running and I need to get information what is the CPU usage under
> heavy traffic with, and without X module. Actually it would be nice to see
> the latency per-packet that X introduces and how it changes if the volume of
> traffic increases.
> 

The most precise tool known to mankind is cyclesoak :)
It's at http://www.uow.edu.au/~andrewm/linux/#zc and there's
a README in the tarball.

cyclesoak measures subtractively - rather than measuring the
load of your software, it measures how much other system
load slows it down.  For networking it gives results which
are repeatable down to about 0.2% of system capacity.  So
you should run a known workload both with and without your
netfilter code and record the difference in cyclesoak output.

Currently it tries to lump memory bandwidth load and CPU cycle
load into a single metric, which doesn't work very well - these
things are orthogonal and should be reported separately.  That's
on my TTD list.

-
