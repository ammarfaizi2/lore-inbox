Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272338AbRH3Qyx>; Thu, 30 Aug 2001 12:54:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272335AbRH3Qyg>; Thu, 30 Aug 2001 12:54:36 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:18962 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S271986AbRH3Qyb>; Thu, 30 Aug 2001 12:54:31 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
Date: Thu, 30 Aug 2001 19:01:25 +0200
X-Mailer: KMail [version 1.3.1]
Cc: David Lang <david.lang@digitalinsight.com>,
        Roman Zippel <zippel@linux-m68k.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0108292018380.1062-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0108292018380.1062-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010830165447Z16272-32385+540@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On August 30, 2001 05:28 am, Linus Torvalds wrote:
> On Thu, 30 Aug 2001, Daniel Phillips wrote:
> >
> > Yes, in the signed/unsigned case the comparison generated is always
> > unsigned.
> 
> Well... No.
> 
> If you compare a signed integer with a unsigned char, the char gets
> promoted to a _signed_ integer, and the comparison is signed. It is NOT
> a unsigned comparison.

Lets not go into how stupid that is.  Yes, things changed between K&R 
editions 1 and 2, in a misguided attempt to make things less "surprising" the 
drafters just introduced additional confusion.

> And THIS is one example of why it gets complicated.
>
> The C logic for type expansion is just a tad too easy to get wrong, and
> the strict type-checking you normally have with well-written ANSI C simply
> does not exist for integer types. The compiler will silently just do the
> promotion..
> 
> Somebody mentioned -Wsign-compare. Try it with the example above. It won't
> warn at all, exactly because under C both sides of such a compare have the
> _same_ sign, even if one is a "unsigned char", and the other is a "signed
> int".
> 
> Try it yourself if you don't believe me.
> 
> Please guys. The issue of sign in comparisons are a LOT more complicated
> than most of you seem to think.

More than anything, it shows that education is needed, not macro patch-ups.
We have exactly the same issues with < and >, should we introduce 
three-argument macros to replace them?

--
Daniel
