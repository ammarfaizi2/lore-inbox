Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319297AbSH2Sk4>; Thu, 29 Aug 2002 14:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319298AbSH2Sk4>; Thu, 29 Aug 2002 14:40:56 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:27654 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S319297AbSH2Sk4>; Thu, 29 Aug 2002 14:40:56 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [PATCH][2.5.32] CPU frequency and voltage scaling (0/4)
Date: Thu, 29 Aug 2002 18:47:39 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <aklq8b$220$1@penguin.transmeta.com>
References: <Pine.LNX.4.44.0208281649540.27728-100000@home.transmeta.com> <1030618420.7290.112.camel@irongate.swansea.linux.org.uk>
X-Trace: palladium.transmeta.com 1030646692 6046 127.0.0.1 (29 Aug 2002 18:44:52 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 29 Aug 2002 18:44:52 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1030618420.7290.112.camel@irongate.swansea.linux.org.uk>,
Alan Cox  <alan@lxorguk.ukuu.org.uk> wrote:
>>  { min-Hz, max-Hz, policy }
>> 
>
>For a few of the processors "event-hz" or similar would be nice. The
>Geode supports hardware assisted bursting to full processor speed when
>doing SMM, I/O and IRQ handling.

Hmm.. I would assume that you'd just use the high frequency for that?
So, for example, assuming you have a 600/300 Geode, when you do

	{ 0, ~0UL, "power-save" }

that would tell the Geode driver to run at 300MHz normally
("power-save"), and at 600Mhz when doing critical events. 

In contrast, a

	{ 0, ~0UL, "performance" }

mode would mean that it always runs at 600MHz (modulo heat throttling,
of course).

And a

	{ 300, 300, "power-save" }

means that you want the chip to always run at 300MHz, even when handling
critical events.

I don't know the exact details of what kinds of frequencies the Geode
supports, but it sounds to me like you don't really need another
frequency value.. 

		Linus
