Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278592AbRKAJLh>; Thu, 1 Nov 2001 04:11:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278593AbRKAJL1>; Thu, 1 Nov 2001 04:11:27 -0500
Received: from deadlock.et.tudelft.nl ([130.161.36.93]:38930 "EHLO
	deadlock.et.tudelft.nl") by vger.kernel.org with ESMTP
	id <S278592AbRKAJLO>; Thu, 1 Nov 2001 04:11:14 -0500
Date: Thu, 1 Nov 2001 10:11:13 +0100 (CET)
From: Joris van Rantwijk <joris@deadlock.et.tudelft.nl>
To: linux-kernel@vger.kernel.org
Subject: Bind to protocol with AF_PACKET doesn't work for outgoing packets 
Message-ID: <Pine.LNX.4.21.0111010944050.16656-100000@deadlock.et.tudelft.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I'm trying to see outgoing network packets through the AF_PACKET
interface. This works as long as I bind the packet socket with
sll_protocol==htons(ETH_P_ALL).  I would expect that I can filter
on IP packets by binding to sll_protocol==htons(ETH_P_IP), but when
I try it I suddenly see only the incoming packets and no outgoing at all.

I suspect this is because dev_queue_xmit_nit() only walks the ptype_all
chain (with the ETH_P_ALL taps) and doesn't process the ptype_base[]
lists. net_rx_action() processes ptype_all as well as ptype_base, so
it works fine for incoming packets.

So... Shouldn't dev_queue_xmit_nit() also process ptype_base then ?
Or is this just complete cluelessness on my part ?
(I'm rather new to this so I don't know how it's supposed to work)

I tried this with linux-2.4.12, but it seems relevant to 2.2.x
and 2.0.x as well.

Thanks,
  Joris van Rantwijk
joris@deadlock.et.tudelft.nl - http://deadlock.et.tudelft.nl/~joris/

