Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272372AbRIFBuh>; Wed, 5 Sep 2001 21:50:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272387AbRIFBu0>; Wed, 5 Sep 2001 21:50:26 -0400
Received: from smarty.smart.net ([207.176.80.102]:2574 "EHLO smarty.smart.net")
	by vger.kernel.org with ESMTP id <S272372AbRIFBuS>;
	Wed, 5 Sep 2001 21:50:18 -0400
From: Rick Hohensee <humbubba@smarty.smart.net>
Message-Id: <200109060151.VAA29489@smarty.smart.net>
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
To: linux-kernel@vger.kernel.org
Date: Wed, 5 Sep 2001 21:51:58 -0400 (EDT)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>VDA
>#define min2(a,b) ({ \
>    typeof(a) __a = (a); \
>    typeof(b) __b = (b); \
>    if( sizeof(a) != sizeof(b) ) BUG(); \
>    if( ~(typeof(a))0 > 0 && ~(typeof(b))0 < 0) BUG(); \
>    if( ~(typeof(a))0 < 0 && ~(typeof(b))0 > 0) BUG(); \
>    (__a < __b) ? __a : __b; \
>    })
>
>#define min3(type,a,b) ({ \
>    type __a = (a); \
>    type __b = (b); \
>    if( sizeof(a) > sizeof(type) ) BUG(); \
>    if( sizeof(b) > sizeof(type) ) BUG(); \
>    (__a < __b) ? __a : __b; \
>    })
>


DesJardin's argument is finely crafted, but does this support it? Is min3
intended to be what Linus was talking about? I usually use m4 when I need
conditionals in macros, and I don't use C conditional statements much, but
isn't what Linus was saying simply something like...


#define min(type,a,b)		(type) a < (type) b ? (type) a : (type) b ;


Looking at the trade-offs should account for the simplicity. Even if my
code is wrong, it's about reflective of the required complexity, y/n?
The simple form doesn't catch things. That's OK for a default. Maybe
that's what you want. If it's simple you know what you have, regardless. 
"programmer error" is frequently a sign of compiler mis-design.

One reason I'm speaking in support of Linus on this one is that there's
something oddly Forth-like to a simple min(type,a,b). No coder nowhere
knows simplicity like Chuck Moore. Linux is ripe for a bit of that. The
other thing about the 3-arg min thing is that it's rather original, and it
amuses me to see Linus get disrespected for a quantum of real creativity
in his own forum. Linux is also ripe for a bit of free thinking. What's
open source for if all it helps is closed minds?

Rick Hohensee
                www.
                           cLIeNUX
                                          .com
                                                        humbubba@smart.net
