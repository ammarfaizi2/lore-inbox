Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264624AbRGPQtZ>; Mon, 16 Jul 2001 12:49:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265449AbRGPQtP>; Mon, 16 Jul 2001 12:49:15 -0400
Received: from nixpbe.pdb.siemens.de ([192.109.2.33]:24269 "EHLO
	nixpbe.pdb.sbs.de") by vger.kernel.org with ESMTP
	id <S264624AbRGPQtK>; Mon, 16 Jul 2001 12:49:10 -0400
Date: Mon, 16 Jul 2001 18:51:10 +0200 (CEST)
From: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>
To: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
cc: Ben LaHaise <bcrl@redhat.com>, "David S. Miller" <davem@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Jens Axboe <axboe@suse.de>,
        Jes Sorensen <jes@sunsite.dk>
Subject: Re: (reposting) how to get DMA'able memory within 4GB on 64-bit
 machine
Message-ID: <Pine.LNX.4.30.0107161601480.23444-100000@biker.pdb.fsc.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

sorry to join in so late in this thread, but I think I should bring the
following to your attention:

Someone (David, I think) said that IA64 was handling 32-bit controllers
fine. To my experience, that depends strongly on the drivers.
At least for aic7xxx, it is not the case (I have documented the
related crashes on the linux-ia64 mailing lists during the last two
months). The driver is simply eating up buffer space in such vast amounts
that it freezes the software IO-memory management even at very moderate
load (you can use the "old" driver instead, but this doesn't look like a
long-term solution).

After some discussion, Justin Gibbs announced that he'll implement 39-bit
DMA addressing in the aic7xxx driver, and it appeared that this was
pretty much the only viable solution to make the "new" aic7xxx driver work on
IA64. I haven't looked at his new code yet, but I assume he's using the
IA64 approach.

It is likely that this will happen for other drivers as well, especially
those that need a lot of buffer space for good performance. Thus the IA-64
API will probably emerge as a matter-of-fact standard, and if something
better is to replace it, I think it should be decided upon quickly, so
that driver maintainers (and IA64) can adopt to it before everything has
to be written (and debugged) twice.

Regards,
Martin
-- 
Martin Wilck     <Martin.Wilck@fujitsu-siemens.com>
FSC EP PS DS1, Paderborn      Tel. +49 5251 8 15113



