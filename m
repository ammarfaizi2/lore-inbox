Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268641AbRGZUO1>; Thu, 26 Jul 2001 16:14:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268683AbRGZUOR>; Thu, 26 Jul 2001 16:14:17 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:32268 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268641AbRGZUOH>; Thu, 26 Jul 2001 16:14:07 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [PATCH] gcc-3.0.1 and 2.4.7-ac1
Date: Thu, 26 Jul 2001 20:12:17 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <9jptj1$155$1@penguin.transmeta.com>
In-Reply-To: <20010726194800.A32053@vana.vc.cvut.cz> <E15PpJg-0004D5-00@the-village.bc.nu>
X-Trace: palladium.transmeta.com 996178436 21974 127.0.0.1 (26 Jul 2001 20:13:56 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 26 Jul 2001 20:13:56 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

In article <E15PpJg-0004D5-00@the-village.bc.nu>,
Alan Cox  <alan@lxorguk.ukuu.org.uk> wrote:
>>   following is patch which was needed for compiling 2.4.7-ac1
>> on box equipped with 'gcc version 3.0.1 20010721 (Debian prerelease)'.
>> As I did not see such complaint yet - here it is.
>>   If you think that gcc is too lazy on inlining (I think so...),
>> tell me and I'll complain to gcc team instead of here.
>
>Fix gcc. We use extern inline to say 'must be inlined' and that was the
>semantic it used to have. Some of our inlines will not work if the compiler
>uninlines them.

No, we had this fight with the gcc people a few years back, and they
have a very valid argument for the current semantics

 - "static inline" means "we have to have this function, if you use it
   but don't inline it, then make a static version of it in this
   compilation unit"

 - "extern inline" means "I actually _have_ an extern for this function,
   but if you want to inline it, here's the inline-version"

The only problem with "static inline" was some _really_ old gcc versions
that did the wrong thing and made a static version of the function in
_every_ compilation unit, whether it was needed or not. Those versions of
gcc do not work on the kernel anyway these days, so..

I think the current gcc semantics are (a) more powerful than the old one
and (b) have been in effect long enough that it's not painful for Linux
to just switch over to them. In short, we might actually want to start
taking advantage of them, and even if we don't we should just convert
all current users of "extern inline" to "static inline".

		Linus
