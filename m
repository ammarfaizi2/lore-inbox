Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318963AbSH1U7C>; Wed, 28 Aug 2002 16:59:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318966AbSH1U7C>; Wed, 28 Aug 2002 16:59:02 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:17930 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318963AbSH1U7A>; Wed, 28 Aug 2002 16:59:00 -0400
Date: Wed, 28 Aug 2002 14:05:43 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Dominik Brodowski <devel@brodo.de>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <cpufreq@www.linux.org.uk>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5.32] CPU frequency and voltage scaling (0/4)
In-Reply-To: <20020828223939.C816@brodo.de>
Message-ID: <Pine.LNX.4.33.0208281400330.16824-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 28 Aug 2002, Dominik Brodowski wrote:
> 
> #3 Then the cpufreq driver is called to actually set the CPU frequency. 
> 
> #3 is absolutely ready

#3 is _not_ ready, if it doesn't include a "policy" part in addition to
the frequency. That was what I started off talking about: on some CPU's
you absolutely do _not_ want to set a hard frequency, you want to tell the
CPU how to behave (possibly together with a frequency _range_).

Until that is done, no other upper layers can use this low-level 
functionality, since all upper layers would be forced to come up with a 
hard frequency goal.

THAT is the problem. If you want to build infrastructure for upper layers, 
then that infrastructure has to be able to pass down sufficient 
information from those upper layers.

Think of this as a driver abstraction layer. Some hardware will do more 
for you, some will do less. Some hardware is the equivalent of a dumb 
frame buffer (where software has to change frequency and voltage by hand, 
and be careful about every single step and the delays in between), while 
some other hardware contains internal accelerators where you just tell 
them what you want, and the hardware will do it for you asynchronously.

The current abstraction layer _thinks_ that all hardware is stupid, and is 
thus not actually usable with smart hardware. See?

			Linus

