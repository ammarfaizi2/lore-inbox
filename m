Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267645AbRG0PTS>; Fri, 27 Jul 2001 11:19:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267642AbRG0PTI>; Fri, 27 Jul 2001 11:19:08 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:47373 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S267645AbRG0PSs>;
	Fri, 27 Jul 2001 11:18:48 -0400
Message-Id: <200107270032.EAA00456@mops.inr.ac.ru>
Subject: Re: Subtleties of the 0.0.0.0 netmask (inet_ifa_match)
To: pflau@us.ibm.COM (Allen Lau)
Date: Fri, 27 Jul 2001 04:32:00 +0400 (MSD)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <OFDE143062.D41C03AC-ON85256A95.000B439D@raleigh.ibm.com> from "Allen Lau" at Jul 26, 1 06:15:01 am
From: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hello!

>   o Does addresses with 0.0.0.0 netmask have scope RT_SCOPE_NOWHERE?

Why?

>   o and does it imply that routing would never route to them?

Even if you set this, it does not imply anything, but that address
will not be used on any packet while automaitc source address selection.


>   o Are there subtle differences between 0.0.0.0 and 255.255.255.255 netmasks?

Subtle? :-) They are on exactly opposite poles.


> The inet_ifa_match function seems to be wrong with 0.0.0.0 netmask.
...
> The 0.0.0.0 netmask matches everything!

Of course. Zero mask matches everything.


> Will there be any routing problems if we use the 0.0.0.0 netmask?

No problems provided you wanted this.
F.e. default route is route with netmask zero, it matches all,
so that all the addresses are routed there.
It is exactly which happens in your setup, but all the addresses
fall to loopback.


Looking at your original purpose, you wanted mask 255.255.255.255.

Alexey
