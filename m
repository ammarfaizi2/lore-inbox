Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271286AbRH3Db3>; Wed, 29 Aug 2001 23:31:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271276AbRH3DbT>; Wed, 29 Aug 2001 23:31:19 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:13577 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S271275AbRH3DbI>; Wed, 29 Aug 2001 23:31:08 -0400
Date: Wed, 29 Aug 2001 20:28:20 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: David Lang <david.lang@digitalinsight.com>,
        Roman Zippel <zippel@linux-m68k.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
In-Reply-To: <20010829234316Z16134-32384+1075@humbolt.nl.linux.org>
Message-ID: <Pine.LNX.4.33.0108292018380.1062-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 30 Aug 2001, Daniel Phillips wrote:
>
> Yes, in the signed/unsigned case the comparison generated is always
> unsigned.

Well... No.

If you compare a signed integer with a unsigned char, the char gets
promoted to a _signed_ integer, and the comparison is signed. It is NOT
a unsigned comparison.

And THIS is one example of why it gets complicated.

The C logic for type expansion is just a tad too easy to get wrong, and
the strict type-checking you normally have with well-written ANSI C simply
does not exist for integer types. The compiler will silently just do the
promotion..

Somebody mentioned -Wsign-compare. Try it with the example above. It won't
warn at all, exactly because under C both sides of such a compare have the
_same_ sign, even if one is a "unsigned char", and the other is a "signed
int".

Try it yourself if you don't believe me.

Please guys. The issue of sign in comparisons are a LOT more complicated
than most of you seem to think.

		Linus

