Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136213AbRASVpr>; Fri, 19 Jan 2001 16:45:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136421AbRASVpi>; Fri, 19 Jan 2001 16:45:38 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:2061 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S136213AbRASVpV>; Fri, 19 Jan 2001 16:45:21 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Is sendfile all that sexy?
Date: 19 Jan 2001 13:45:09 -0800
Organization: Transmeta Corporation
Message-ID: <94ach5$mcs$1@penguin.transmeta.com>
In-Reply-To: <Pine.GSO.4.10.10101190951390.23899-100000@zeus.fh-brandenburg.de> <200101192018.XAA25263@ms2.inr.ac.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200101192018.XAA25263@ms2.inr.ac.ru>,
 <kuznet@ms2.inr.ac.ru> wrote:
>Hello!
>
>> It's about direct i/o from/to pages,
>
>Yes. Formally, there are no problems to send to tcp directly from io space.

Actually, as long as there is no "struct page" there _are_ problems.
This is why the NUMA stuff was brought up - it would require that there
be a mem_map for the PCI pages.. (to do ref-counting etc).

>But could someone explain me one thing. Does bus-mastering
>from io really work? And if it does, is it enough fast?
>At least, looking at my book on pci, I do not understand
>how such transfers are able to use bursts. MRM is banned for them...

It does work at least on some hardware.  But no, I don't think you can
depend on bursting (but I don't see why it couldn't work in theory). 

		Linus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
