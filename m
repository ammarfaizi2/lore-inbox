Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318069AbSHUIkS>; Wed, 21 Aug 2002 04:40:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318075AbSHUIkS>; Wed, 21 Aug 2002 04:40:18 -0400
Received: from users.linvision.com ([62.58.92.114]:25485 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S318069AbSHUIkS>; Wed, 21 Aug 2002 04:40:18 -0400
Date: Wed, 21 Aug 2002 10:44:10 +0200
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Oliver Xymoron <oxymoron@waste.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] (0/4) Entropy accounting fixes
Message-ID: <20020821104410.A25461@bitwizard.nl>
References: <20020818025913.GF21643@waste.org> <Pine.LNX.4.44.0208172006050.1491-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0208172006050.1491-100000@home.transmeta.com>
User-Agent: Mutt/1.3.22.1i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 17, 2002 at 08:08:36PM -0700, Linus Torvalds wrote:
> 
> On Sat, 17 Aug 2002, Oliver Xymoron wrote:
> > 
> > Let me clarify that 2-5 orders thing. The kernel trusts about 10 times
> > as many samples as it should, and overestimates each samples' entropy
> > by about a factor of 10 (on x86 with TSC) or 1.3 (using 1kHz jiffies).
> 
> Lookin gat the code, your _new_ code just throws samples away _entirely_ 
> just because some random event hasn't happened (the first thing I noticed 
> was the context switch testing, there may be others there that I just 
> didn't react to).

Oliver, 

Let me state that with a proper mixing function you should always 
mix in possible entropy sources, even if they CAN be controlled
from the outside. 

If you mistrust the source, feel free to add (almost) zero to the 
"proven entropy". 

Now, how about keeping both a conservative and a bit more liberal
count of the entropy in the pool? Then we can have three device
nodes, which provide random entropy. One should follow YOUR rules, 
and can only be used on desktop machines with humans typing and
mousing at the console (that's your proposition for "random"). 
The other is useful for random numbers for keys and such (that's 
our current "random"). The last is our old urandom. 

				Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
