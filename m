Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318795AbSHRCWp>; Sat, 17 Aug 2002 22:22:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318796AbSHRCWp>; Sat, 17 Aug 2002 22:22:45 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:41738 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318795AbSHRCWo>; Sat, 17 Aug 2002 22:22:44 -0400
Date: Sat, 17 Aug 2002 19:30:02 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Oliver Xymoron <oxymoron@waste.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] (0/4) Entropy accounting fixes
In-Reply-To: <20020818021522.GA21643@waste.org>
Message-ID: <Pine.LNX.4.44.0208171923330.1310-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 17 Aug 2002, Oliver Xymoron wrote:
> 
> Net effect: a typical box will claim to generate 2-5 _orders of magnitude_
> more entropy than it actually does. 

On the other hand, if you are _too_ anal you won't consider _anything_ 
"truly random", and /dev/random becomes practically useless on things that 
don't have special randomness hardware.

To me it sounds from your description that you may well be on the edge of 
"too anal". Real life _has_ to be taken into account, and not accepting 
entropy because of theoretical issues is _not_ a good idea.

Quite frankly, I'd rather have a usable /dev/random than one that runs out
so quickly that it's unreasonable to use it for things like generating
4096-bit host keys for sshd etc.

In particular, if a machine needs to generate a strong random number, and 
/dev/random cannot give that more than once per day because it refuses to 
use things like bits from the TSC on network packets, then /dev/random is 
no longer practically useful.

Theory is theory, practice is practice. And theory should be used to 
_analyze_ practice, but should never EVER be the overriding concern.

So please also do a writeup on whether your patches are _practical_. I 
will not apply them otherwise.

			Linus

