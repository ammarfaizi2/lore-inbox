Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283626AbRLRPfZ>; Tue, 18 Dec 2001 10:35:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282941AbRLRPfG>; Tue, 18 Dec 2001 10:35:06 -0500
Received: from m749-mp1-cvx1b.edi.ntl.com ([62.253.10.237]:18926 "EHLO
	pinkpanther.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S282547AbRLRPew>; Tue, 18 Dec 2001 10:34:52 -0500
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200112181429.fBIETsf15577@pinkpanther.swansea.linux.org.uk>
Subject: Re: Scheduler ( was: Just a second ) ...
To: torvalds@transmeta.com (Linus Torvalds)
Date: Tue, 18 Dec 2001 14:29:54 +0000 (GMT)
Cc: wli@holomorphy.com (William Lee Irwin III),
        linux-kernel@vger.kernel.org (Kernel Mailing List),
        jgarzik@mandrakesoft.com (Jeff Garzik)
In-Reply-To: <Pine.LNX.4.33.0112172153410.2416-100000@penguin.transmeta.com> from "Linus Torvalds" at Dec 17, 2001 10:09:22 
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well, looking at the issue, the problem is probably not just in the sb
> driver: the soundblaster driver shares the output buffer code with a
> number of other drivers (there's some horrible "dmabuf.c" code in common).

The sb driver is fine

> A number of sound drivers will use the same logic.

Most hardware does

> Quite frankly I don't know the sound infrastructure well enough to make
> any more intelligent suggestions about other decoders or similar to try,
> at this point I just start blathering.

some of the sound stuff uses very short fragments to get accurate 
audio/video synchronization. Some apps also do it gratuitously when they
should be using other API's. Its also used sensibly for things like
gnome-meeting where its worth trading CPU for latency because 1K of
buffering starts giving you earth<->moon type conversations

> But yes, I bet you'll also see much less impact of this if you were to
> switch to more modern hardware.

Not really - the app asked for an event every 32 bytes. This is an app not
kernel problem.

> at 2*2 bytes per sample and 44kHz would mean that a 1kB DMA buffer empties
> in less than 1/100th of a second, but at least it should be < 200 irqs/sec
> rather than >400).

With a few exceptions the applications tend to use 4K or larger DMA chunks
anyway. Very few need tiny chunks.

Alan

