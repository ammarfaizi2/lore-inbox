Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318165AbSHZRgl>; Mon, 26 Aug 2002 13:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318169AbSHZRgk>; Mon, 26 Aug 2002 13:36:40 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:13060 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318165AbSHZRgW>; Mon, 26 Aug 2002 13:36:22 -0400
Date: Mon, 26 Aug 2002 10:42:34 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
cc: Manfred Spraul <manfred@colorfullife.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2.5.31] transparent PCI-to-PCI bridges
In-Reply-To: <20020826175747.A27952@jurassic.park.msu.ru>
Message-ID: <Pine.LNX.4.33.0208261038440.15474-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 26 Aug 2002, Ivan Kokshaysky wrote:
> 
> Ok. Updated patch appended.

Please don't do it like this: I hate code that changes standard PCI data 
structure meaning (in this case the "class" thing) behind peoples back.. 
Some other user might well want to look at the original class member, and 
rewriting it to a magic value just to make the transparency check pass 
sounds like a bad idea to me.

So instead, I would suggest that you add a single-bit "transparent" field
to the PCI structure, and initialize it to "(class & 0xff) == 1" when
initializing the device data. Then, any fixup can just set the transparent
bit to 1.

That would make the code more robust, and more readable in my opionion.

Ok?

		Linus

