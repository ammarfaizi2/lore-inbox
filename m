Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266379AbRGFK4x>; Fri, 6 Jul 2001 06:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266377AbRGFK4o>; Fri, 6 Jul 2001 06:56:44 -0400
Received: from indyio.rz.uni-sb.de ([134.96.7.3]:30500 "EHLO
	indyio.rz.uni-sb.de") by vger.kernel.org with ESMTP
	id <S266374AbRGFK4c>; Fri, 6 Jul 2001 06:56:32 -0400
Message-ID: <3B459958.F25665A8@stud.uni-saarland.de>
Date: Fri, 06 Jul 2001 10:56:24 +0000
From: Studierende der Universitaet des Saarlandes 
	<masp0008@stud.uni-sb.de>
Reply-To: manfred@colorfullife.com
Organization: Studierende Universitaet des Saarlandes
X-Mailer: Mozilla 4.08 [en] (X11; I; Linux 2.0.36 i686)
MIME-Version: 1.0
To: "Daniel A. Nobuto" <ramune@bigfoot.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: natsemi.c failure in 2.4.6
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>         Found that in 2.4.6, Natsetmi card I have doesn't receive
> traffic anymore.  It worked in 2.4.5, though.
> 
>         The natsemi card is forced to 10/half via mii-diag at boot,
> and given a different MAC address (due to some problems I had with
> the original MAC address and netbooting a sparc).  Forcing it to
> 100/full didn't work, either.

Could you try what happens without any special options? Default MAC
address, without mii-diag.

>  Basic mode control register 0x2100: Auto-negotiation disabled, with
>  Speed fixed at 100 mbps, full-duplex.

> [PC Linux 2.4.6] <--> p10/100 hub] <--> [SS4 NetBSD 1.5]

> Speed fixed at 100 mbps, full-duplex.

>  I'm advertising 05e1: Flow-control 100baseTx-FD 100baseTx 10baseT-FD 10baseT
>    Advertising no additional info pages.
>    IEEE 802.3 CSMA/CD protocol.
>  Link partner capability is 45e1: Flow-control 100baseTx-FD 100baseTx
>    10baseT-FD. 10baseT.  Negotiation  completed.

Something is wrong.
Are you sure it's a hub? The link partner ability says FullDuplex
capable, it's either a switch or the negotiation produced wrong results.

The natsemi nic advertises 5e1, but the speed is fixed at 100 mbps.
Probably a forced renegotiation after mii-diag changes is missing, and
the forced settings aren't used properly.

I'll look at it.

--
	Manfred
