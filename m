Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286177AbRLTGZN>; Thu, 20 Dec 2001 01:25:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286179AbRLTGZD>; Thu, 20 Dec 2001 01:25:03 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:48657 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S286177AbRLTGYv>; Thu, 20 Dec 2001 01:24:51 -0500
Date: Wed, 19 Dec 2001 22:23:27 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "David S. Miller" <davem@redhat.com>
cc: <bcrl@redhat.com>, <cs@zip.com.au>, <billh@tierra.ucsd.edu>,
        <linux-kernel@vger.kernel.org>, <linux-aio@kvack.org>
Subject: Re: aio
In-Reply-To: <20011219.221245.02301926.davem@redhat.com>
Message-ID: <Pine.LNX.4.33.0112192218020.19433-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 19 Dec 2001, David S. Miller wrote:
>
> Ok, TUX can do it.  Now list for me some server that really matters
> other than web and ftp?

Now now, that's unfair. We should be able to do it in user space.

I think the question you _should_ be lobbying at Ben and the other aio
people is how the aio stuff could do zero-copy from disk cache to the
network, ie do the things that Tux does internally where it does
nonblocking reads from disk ad then sends them out non-blocking to the
network without havign to copy the data _or_ have to use extremely
expensive TLB mapping tricks to get at it..

Ie tie the "sendfile" and "aio" threads together, and ask Ben if we can do
aio-sendfile and have thousands of asynchronous sendfiles going on at the
same time, like Tux can do. And if not, then why not? Missing or bad
interfaces?

Ben? Doing user-space IO is all well and good, but that extra copy and TLB
stuff kills you. Tell us how to do it ;)

		Linus

