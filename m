Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310540AbSCPUAV>; Sat, 16 Mar 2002 15:00:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310547AbSCPUAN>; Sat, 16 Mar 2002 15:00:13 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:28424 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S310540AbSCPUAC>; Sat, 16 Mar 2002 15:00:02 -0500
Date: Sat, 16 Mar 2002 11:58:22 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: <davidm@hpl.hp.com>
cc: <yodaiken@fsmlabs.com>, Paul Mackerras <paulus@samba.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [Lse-tech] Re: 10.31 second kernel compile
In-Reply-To: <15507.41057.35660.355874@napali.hpl.hp.com>
Message-ID: <Pine.LNX.4.33.0203161144340.31971-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 16 Mar 2002, David Mosberger wrote:
> 
> ia64 has an optional hardware walker which can operate in "hashed"
> mode or in "virtually mapped linear page table mode".  If you think
> you can do a TLB lookup faster in software, you can turn the walker
> off.

I used to be a sw fill proponent, but I've grown personally convinced that 
while sw fill is good, it needs a few things:

 - large on-chip TLB to avoid excessive trashing (ie preferably thousands
   of entries)

   This implies that the TLB should be split into a L1 and a L2, for all 
   the same reasons you split other caches that way (and with the L1
   probably being duplicated among all memory units)

 - ability to fill multiple entries in one go to offset the cost of taking 
   the trap.

Without that kind of support, the flexibility advantages of a sw fill just 
isn't enough to offset the advantage you can get from doing it in 
hardware (mainly the ability to not have to break your pipeline).

An in-memory hash table can of course be that L2, but I have this strong
suspicion that a forward-looking chip engineer would just have put the L2
on the die and made it architecturally invisible (so that moore's law can
trivially make it bigger in years to come).

		Linus

