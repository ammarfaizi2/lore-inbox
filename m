Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271666AbRH0Hjb>; Mon, 27 Aug 2001 03:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271658AbRH0HjW>; Mon, 27 Aug 2001 03:39:22 -0400
Received: from fungus.teststation.com ([212.32.186.211]:6150 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S271665AbRH0HjP>; Mon, 27 Aug 2001 03:39:15 -0400
Date: Mon, 27 Aug 2001 09:39:13 +0200 (CEST)
From: Urban Widmark <urban@teststation.com>
To: Ben Greear <greearb@candelatech.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
        Stephan von Krawczynski <skraw@ithnet.com>
Subject: Re: VIA Rhine problem in 2.4.9-pre4
In-Reply-To: <3B89CF75.376CBE5B@candelatech.com>
Message-ID: <Pine.LNX.4.10.10108270914330.9807-100000@ada.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Aug 2001, Ben Greear wrote:

> I believe the problem was that my program that reads information out of
> the drivers (IP, mask, MTU, QLEN, and the MII-diag flags) was in a very
> tight loop, and so was almost constantly trying to read the information.

Ah ...

Reading the MII in the driver is done while holding the driver lock, so
there could definitly be some interaction with the xmit. That was
suggested before, but I couldn't see how.

Or it could just be that if someone does mdio things at the wrong time the
chip gets "confused".


> I fixed that problem, and haven't seen the NIC lock up since.  If I
> get a chance, I'm going to make a stand-alone GPL version of that code, and when
> I do I'll add an option to stress the kernel/drivers and see if I can
> reproduce this NIC lockup.

I for one would be interested in an isolated testcase of this failure, GPL
or otherwise, and see if I can trigger this on my machines.

/Urban

