Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129375AbRAaNgw>; Wed, 31 Jan 2001 08:36:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130924AbRAaNgn>; Wed, 31 Jan 2001 08:36:43 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:16903 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129375AbRAaNge>; Wed, 31 Jan 2001 08:36:34 -0500
Subject: Re: Kernel 2.2.18: Protocol 0008 is buggy
To: lists@cyclades.com (Ivan Passos)
Date: Wed, 31 Jan 2001 13:37:04 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Linux Kernel List)
In-Reply-To: <Pine.LNX.4.10.10101301831460.24409-100000@main.cyclades.com> from "Ivan Passos" at Jan 30, 2001 06:58:43 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14NxRb-0002Ku-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The msg comes from net/core/dev.c, and this device is using the Cisco HDLC 
> protocol in drivers/net/hdlc.c . However, AFAIK, 0008 and 0608 represent
> IP and ARP (respectively), not Cisco HDLC. So ...
> 
> What I'd like to know is: what exactly causes this msg?? It seems that
> it's printed when someone sends a packet without properly setting 
> skb->nh.raw first, but who's supposed to set skb->nh.raw?? The HW driver??
> The data link (HDLC) driver?? The kernel protocol drivers? How should I go
> about fixing this problem, where should I start??

It should be set before netif_rx() is called on the packet. Typically that
means the driver or its support code sets protocol and nh.raw and if a
second header is pulled up then they are set again by whichever code does that
and calls netif_rx again

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
