Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318818AbSHRDxy>; Sat, 17 Aug 2002 23:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318833AbSHRDxy>; Sat, 17 Aug 2002 23:53:54 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:23054 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318818AbSHRDxx>; Sat, 17 Aug 2002 23:53:53 -0400
Date: Sat, 17 Aug 2002 21:01:20 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Robert Love <rml@tech9.net>
cc: Oliver Xymoron <oxymoron@waste.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] (0/4) Entropy accounting fixes
In-Reply-To: <1029642713.863.2.camel@phantasy>
Message-ID: <Pine.LNX.4.44.0208172058200.1640-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 17 Aug 2002, Robert Love wrote:
> 
> [1] this is why I wrote my netdev-random patches.  some machines just
>     have to take the entropy from the network card... there is nothing
>     else.

I suspect that Oliver is 100% correct in that the current code is just
_too_ trusting. And parts of his patches seem to be in the "obviously
good" category (ie the xor'ing of the buffers instead of overwriting).

So I think that if we just made the code be much less trusting (say, 
consider the TSC information per interrupt to give only a single bit of 
entropy, for example), and coupled that with making network devices always 
be considered sources of entropy, we'd have a reasonable balance. 

		Linus

