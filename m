Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129754AbRBUWFQ>; Wed, 21 Feb 2001 17:05:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130059AbRBUWFG>; Wed, 21 Feb 2001 17:05:06 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:33037 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130040AbRBUWEx>; Wed, 21 Feb 2001 17:04:53 -0500
Subject: Re: Very high bandwith packet based interface and performance problems
To: nyet@curtis.curtisfong.org (Nye Liu)
Date: Wed, 21 Feb 2001 22:07:32 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20010221140055.A8113@curtis.curtisfong.org> from "Nye Liu" at Feb 21, 2001 02:00:55 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14VhQ7-0002s0-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> that because the kernel was getting 99% of the cpu, the application was
> getting very little, and thus the read wasn't happening fast enough, and

Seems reasonable

> This is NOT what I'm seeing at all.. the kernel load appears to be
> pegged at 100% (or very close to it), the user space app is getting
> enough cpu time to read out about 10-20Mbit, and FURTHERMORE the kernel
> appears to be ACKING ALL the traffic, which I don't understand at all
> (e.g. the transmitter is simply blasting 300MBit of tcp unrestricted)

TCP _requires_ the remote end ack every 2nd frame regardless of progress.

> With udp, we can get the full 300MBit throughput, but only if we shape
> the load to 300Mbit. If we increase the load past 300 MBit, the received
> frames (at the user space udp app) drops to 10-20MBit, again due to
> user-space application scheduling problems.

How is your incoming traffic handled architecturally - irq per packet or
some kind of ring buffer with irq mitigation.  Do you know where the cpu
load is - is it mostly the irq servicing or mostly network stack ?



