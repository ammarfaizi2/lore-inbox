Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271161AbRHTKHA>; Mon, 20 Aug 2001 06:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271155AbRHTKGv>; Mon, 20 Aug 2001 06:06:51 -0400
Received: from [195.63.194.11] ([195.63.194.11]:43278 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S271163AbRHTKGc>; Mon, 20 Aug 2001 06:06:32 -0400
Message-ID: <3B80E01B.2C61FF8@evision-ventures.com>
Date: Mon, 20 Aug 2001 12:02:03 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-12 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: Oliver Xymoron <oxymoron@waste.org>, linux-kernel@vger.kernel.org,
        riel@conectiva.com.br
Subject: Re: [PATCH] let Net Devices feed Entropy, updated (1/2)
In-Reply-To: <Pine.LNX.4.30.0108182234250.31188-100000@waste.org> <998193404.653.12.camel@phantasy>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> 
> On 18 Aug 2001 22:36:00 -0500, Oliver Xymoron wrote:
> > But your claim is there _is_ entropy. If you think there is, go ahead and
> > use it. Via /dev/urandom. Yes, I know it's theoretically not secure, but
> > then neither is what you're proposing.
> 
> I am only continuing this because I want to explain...
> 
> I claim there is entropy from what?  The difference between interrupts
> for net devices?  Everyone agrees that there is.  The issues is that an
> external attacker could influence the interrupts to the net device, and
> thus make some assumptions about the state.  That is why this patch is
> configurable.  Do as you please.  As I said, some people want it or need
> it.

I think you are just wrong - nobody really needs this patch. /dev/random
or /dev/urandom ar *both* anyway just complete overkill in terms of 
practical security. /dev/urandom is in esp silly, since it is providing
a md5 hash
implementation inside the kernel, which could be *compleatly* and
entierly
done inside user land.

> Again, /dev/urandom is just as "secure" as /dev/random.  Its the same
> pool.  The same stuff.  Except that /dev/random blocks when the entropy
> count hits 0.
> 
> Now, this count is purely theoretical, too.  Its an estime of the amount
> of entropy -- lack of determinability -- in the pool of bytes.

Wrong. Don't let you confuse yourself by the way the term entropy is
used in
the documentation of /dev/random - it's an abuse of the mathematical
definition anyway. The more appriopriate term there
would be: signal source variability estimate.

> Even when it reaches 0, since the pool is still unknown (only previous
> output may be known) and the output is hashed, its still pretty much
> undeterminable.  But mathematically and theoretically, our entropy
> estimate says it is not.

You mean - there is no known algorithm with polynomial time
behaviour enabling us to calculate the next value of this function
from the previous ones - Not more nor less - no pysics and
entropy involved. If you assume this holds true it's mathematically
entierly sufficient that a single only seed value is not known.
