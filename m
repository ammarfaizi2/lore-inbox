Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315458AbSIDWfJ>; Wed, 4 Sep 2002 18:35:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315746AbSIDWfJ>; Wed, 4 Sep 2002 18:35:09 -0400
Received: from gra-lx1.iram.es ([150.214.224.41]:47376 "EHLO gra-lx1.iram.es")
	by vger.kernel.org with ESMTP id <S315458AbSIDWfJ>;
	Wed, 4 Sep 2002 18:35:09 -0400
Date: Thu, 5 Sep 2002 00:39:38 +0200 (CEST)
From: Gabriel Paubert <paubert@iram.es>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: TCP Segmentation Offloading (TSO)
In-Reply-To: <al3m2p$lnp$1@cesium.transmeta.com>
Message-ID: <Pine.LNX.4.33.0209050027270.7673-100000@gra-lx1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 Sep 2002, H. Peter Anvin wrote:

[Sorry HPA, I forgot to cc to linux-kernel the first time.]

> > P.S.
> >     Using "bswap" is little bit tricky.
> >
>
> It needs to be protected by CONFIG_I486 and alternate code implemented
> for i386 (xchg %al,%ah; rol $16,%eax, xchg %al,%ah for example.)

While it would work, this sequence is overkill. Unless I'm mistaken, the
only property of bswap which is used in this case is that it swaps even
and odd bytes, which can be done by a simple "roll $8,%eax" (or rorl).

I believe that bswap is one byte shorter than roll. In any case, using a
rotate might be the right thing to do on other architectures.

	Gabriel.


