Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263803AbREYQpD>; Fri, 25 May 2001 12:45:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263798AbREYQox>; Fri, 25 May 2001 12:44:53 -0400
Received: from team.iglou.com ([192.107.41.45]:17326 "EHLO iglou.com")
	by vger.kernel.org with ESMTP id <S263797AbREYQoi>;
	Fri, 25 May 2001 12:44:38 -0400
Date: Fri, 25 May 2001 12:44:35 -0400
From: Jeff Mcadams <jeffm@iglou.com>
To: Paul Mackerras <paulus@samba.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SyncPPP Generic PPP merge
Message-ID: <20010525124435.A24448@iglou.com>
In-Reply-To: <002501c0e48f$ffed1e40$0c00a8c0@diemos> <E1533Ra-0005hC-00@the-village.bc.nu> <20010524185333.B7667@iglou.com> <15117.44426.899390.29151@tango.paulus.ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <15117.44426.899390.29151@tango.paulus.ozlabs.org>; from paulus@samba.org on Fri, May 25, 2001 at 10:55:38AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also sprach Paul Mackerras
>Jeff Mcadams writes:
>> Indeed.  And let me just throw out another thought.  A clean
>> abstraction of the various portions of the PPP functionality is
>> beneficial in other ways.  My personal pet project being to add L2TP
>> support to the kernel eventually.  A good abstraction of the framing
>> capabilities and basic PPP processing would be rather useful in that
>> project.

>That is exactly what ppp_generic.c is intended to do - it abstracts out
>the framing and encapsulation and low-level transport of PPP frames
>into ppp "channels" (see for example ppp_async.c, ppp_synctty.c) while
>ppp_generic.c does the basic PPP processing (compression, multilink,
>handling the network interface device etc.).

>You should be able to write an L2TP channel to work with ppp_generic -
>all your code would need to know about is how to take a PPP frame and
>encapsulate and send it, and how to receive and decapsulate PPP frames.

>[Note to myself: send in a Documentation/ppp_generic.txt which
>describes the interface between ppp_generic.c and the channels.]

That's all well and good...and useful...and I'll probably take advantage
of it...but I think you missed my point (although I have no doubt that
my point was not at all clear!)

L2TP potentially has to convert a PPP frame that is given to it to or
from async or sync framing.  ppp_async.c has a ppp_async_encode()
function that would be useful to me in L2TP...it'd kinda suck to have to
duplicate that functionality.  Although it looks like the corresponding
decoding funcationality is tied up in ppp_async_input() which kinda
sucks a bit as well.

Anyway...the idea being that it would be nice to be able to have easy
access to some of the functionality that's part of the channels
currently, but could conceivably be abstracted out even further.

The question, I guess, then becomes whether its worth it to do this
extra layer of abstraction and adding another layer of interaction
between modules for the benefit that it provides.  I certainly wouldn't
squabble if the general concensus was that it wasn't worth it.  :)

Oh, and before anyone points this out, yes, L2TP changing the framing of
the PPP frame above is definitely a violation of layering...if you'd
like, I can point out plenty of other places where L2TP violates
layering principles.  :)

>> I would agree that such a project would be 2.5 material.

>Do it today if you like, I can't see that adding a new PPP channel
>could break anything else, it would be like adding a new driver.

Well...L2TP support is 2.5 material as far as I'm concerned because I'm
not much of a programmer in general, and have never done any kernel
programming...so I'm still getting up to speed on things, and it'll
probably take me until fairly well into 2.5 to even really consider
unleashing a kernel-level creation of my own onto the world.  :)
-- 
Jeff McAdams                            Email: jeffm@iglou.com
Head Network Administrator              Voice: (502) 966-3848
IgLou Internet Services                        (800) 436-4456
