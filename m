Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275233AbTHMPUf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 11:20:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275232AbTHMPUf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 11:20:35 -0400
Received: from crosslink-village-512-1.bc.nu ([81.2.110.254]:53496 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S275233AbTHMPU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 11:20:26 -0400
Subject: Re: 2.6.0-test3-mm1: scheduling while atomic (ext3?)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030813142055.GC9179@wotan.suse.de>
References: <20030813014746.412660ae.akpm@osdl.org.suse.lists.linux.kernel>
	 <20030813091958.GA30746@gates.of.nowhere.suse.lists.linux.kernel>
	 <20030813025542.32429718.akpm@osdl.org.suse.lists.linux.kernel>
	 <1060772769.8009.4.camel@localhost.localdomain.suse.lists.linux.kernel>
	 <20030813042544.5064b3f4.akpm@osdl.org.suse.lists.linux.kernel>
	 <1060774803.8008.24.camel@localhost.localdomain.suse.lists.linux.kernel>
	 <p7365l17o70.fsf@oldwotan.suse.de>
	 <1060778924.8008.39.camel@localhost.localdomain>
	 <20030813131457.GD32290@wotan.suse.de>
	 <1060783794.8008.62.camel@dhcp23.swansea.linux.org.uk>
	 <20030813142055.GC9179@wotan.suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1060788009.8957.5.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 13 Aug 2003 16:20:11 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-08-13 at 15:20, Andi Kleen wrote:
> stuff is basically useless in the kernel because it only helps with data
> sets significantly bigger than your cache, and we usually only deal
> with 4K chunks of everything.

Could be. I didnt write that code. I think Manfred also played with the
copy tricks that came from the AMD slides.

> The K6 has it, right?
> Is there a "more original" 3dnow that what has been in the K6?

K6-II/III does. I don't know about original K6. but I believe it
doesn't. The original 3Dnow was a joint Cyrix/AMD thing and it lacks 
several instructions later added (including prefetch). The later Cyrix
also has a couple of the additional ones but not prefetch.
 
> > "Mummy it doesnt work like I personally have decreed it shall lets break
> > it and screw all the users". Thats the Dan Bernstein school of charm
> 
> It doesn't work like the AMD instruction reference manual describes it.

Well there is a suprise, AMD didn't design it 8)

> Of course it should be fixed, but the fix as it is a bug workaround
> doesn't have to be very fast. So it would be ok to just clear the 3dnow bit.
> But then to handle the K6 case (which is interesting, I didn't know) too it
> would be probably better to define a separate bit. 

What else checks the 3Dnow bit ?

> > We want a pseudobit - otherwise we'll break other code that checks
> > 3dnow is present properly.
> 
> Ok. I will do that when I'm back next week unless someone beats me
> to it ;-)

Some kind of "has prefetch and its actually useful" 8)

> > If you misalign the instruction you don't seem to get the exception on
> > Athlon, dunno about the Opteron errata or if the opteron errata bites in
> > 32bit. If it does I guess we should clear mmx, xmm for Opteron by your
> > arguments ;)
> 
> I didn't know about the misalignment bit. Interesting. Misalignment to
> what boundary?

I'll have to go check again. Its something RH internal testing found
when people were going "uh what the hell is going on here" 8)

> But is it slower than an aligned execution? If yes I would prefer my 
> solution because it keeps the fast path as fast as possible.

Has AMD confirmed that your solution is ok for the K7 as well as K8 - ie
that if we hit the errata the fixup recovers the CPU from whatever
lunatic state it is now in  ?

