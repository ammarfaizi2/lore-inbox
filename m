Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318916AbSH1TwE>; Wed, 28 Aug 2002 15:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318925AbSH1TwE>; Wed, 28 Aug 2002 15:52:04 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:31492 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318916AbSH1TwD>; Wed, 28 Aug 2002 15:52:03 -0400
Date: Wed, 28 Aug 2002 12:58:47 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Cort Dougan <cort@fsmlabs.com>, Dominik Brodowski <devel@brodo.de>,
       <cpufreq@www.linux.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5.32] CPU frequency and voltage scaling (0/4)
In-Reply-To: <1030562708.7190.59.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.33.0208281249520.4507-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 28 Aug 2002, Alan Cox wrote:
> 
> Systems designers are designing on the basis of thermal slowdowns being
> the optimal way to build some systems. Its actually quite reasonable for
> many workloads.

Absolutely. Thermal policy is often an overriding thing, where even 
non-transmeta CPU's will simply do the decision "on their own", without 
input from the OS. That's simply because some designs will literally not 
work above certain temperatures and do not have the heat sink capacity to 
get out of a tight spot by purely external cooling. 

But that's just one part of it. Even aside from thermal concerns, you want 
to drop frequency aggressively when the machine is idle, because dropping 
the frequency allows you to drop the voltage and effetively gets you a 
cubed power reduction (which not only saves your battery, but also cools 
the chip down so that when you _do_ start going full speed again you have 
more thermal headroom).

So in order to avoid the thermal shutdown, you need to be proactive about 
the frequency. Which again means that a user-level "once a second" or 
"once in a blue moon" approach is fundamentally flawed.

I don't disagree with _also_ being able to set the frequency statically. 
However, I do disagree with an interface that seems to be _purely_ 
designed for this, and nothing else. 

		Linus

