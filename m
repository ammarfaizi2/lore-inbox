Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281273AbRKHB2P>; Wed, 7 Nov 2001 20:28:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281288AbRKHB2G>; Wed, 7 Nov 2001 20:28:06 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:40200 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S281273AbRKHB1x>; Wed, 7 Nov 2001 20:27:53 -0500
Date: Wed, 7 Nov 2001 17:22:35 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andreas Dilger <adilger@turbolabs.com>
cc: "David S. Miller" <davem@redhat.com>, <tim@physik3.uni-rostock.de>,
        <jgarzik@mandrakesoft.com>, <andrewm@uow.edu.au>,
        <linux-kernel@vger.kernel.org>, <netdev@oss.sgi.com>, <ak@muc.de>,
        <kuznet@ms2.inr.ac.ru>
Subject: Re: [PATCH] net/ipv4/*, net/core/neighbour.c jiffies cleanup
In-Reply-To: <20011107173626.S5922@lynx.no>
Message-ID: <Pine.LNX.4.33.0111071718420.15523-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 7 Nov 2001, Andreas Dilger wrote:
>
> No, only a limited number of them cast to a signed value, which means
> that a large number of them get the comparison wrong in the case of
> jiffies wrap (where the difference is a large unsigned value, and not
> a small negative number).

No.

Unsigned arithmetic is fine. The _correct_ way to test whether something
is in within

	[ start , start+HZ ]

is to do

	if (jiffies - start <= HZ)

try it. The C language guarantees that unsigned arithmetic works in a
"modulo power of two" fashion, which means that it _is_ ok to do
arithmetic on unsigned longs, and jiffy wrapping does not matter. No need
to cast to "signed" or anything else.

In short: It is wrong to do

	if (jiffies <= start+HZ)

and it is _right_ to do

	if (jiffies - start <= HZ)

(as long as "start" is "unsigned long" like jiffies).

		Linus

