Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316889AbSG3WBw>; Tue, 30 Jul 2002 18:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316928AbSG3WBv>; Tue, 30 Jul 2002 18:01:51 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:6 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316889AbSG3WBh>; Tue, 30 Jul 2002 18:01:37 -0400
Date: Tue, 30 Jul 2002 15:04:45 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Brad Hards <bhards@bigpond.net.au>
cc: Alexander Viro <viro@math.psu.edu>, Greg KH <greg@kroah.com>,
       Vojtech Pavlik <vojtech@suse.cz>, <linux-kernel@vger.kernel.org>,
       <linuxconsole-dev@lists.sourceforge.net>
Subject: Re: [patch] Input cleanups for 2.5.29 [2/2]
In-Reply-To: <200207310747.35605.bhards@bigpond.net.au>
Message-ID: <Pine.LNX.4.33.0207301459530.2051-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 31 Jul 2002, Brad Hards wrote:
>
> Here is an extract from <linux/types.h>
> typedef         __u8            uint8_t;
> typedef         __u16           uint16_t;

Yes, and the thing you snipped from it was that it's inside a #ifdef.

Now, that #ifdef will be on for the __KERNEL__, but somebody else might
have compiled with some -traditional switch or other that disabled
"uint8_t" or just screwed it up some other way.

> > ICBW, but wasn't uint<n>_t only promised to be at least <n> bits?
> I am not sure I understand the point you are trying to make.

I think the point Viro is making is that uint8_t actually exists on things 
like old cray's too, even if end sup being a 64-bit entity.

I don't think that is correct, though. I think that comes from another
(proposed but not implemented) C language extension that would have
allowed something like that, namely the

	int X:17;

syntax, where X would be guaranteed to be "17 bits or more". I don't 
remember.

		Linus

