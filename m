Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266469AbUHVVl1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266469AbUHVVl1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 17:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266319AbUHVVjm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 17:39:42 -0400
Received: from the-village.bc.nu ([81.2.110.252]:13712 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266351AbUHVViy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 17:38:54 -0400
Subject: RE: Cursed Checksums
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Josan Kadett <corporate@superonline.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <S268085AbUHVUD4/20040822200356Z+207@vger.kernel.org>
References: <S268085AbUHVUD4/20040822200356Z+207@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1093206990.25041.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 22 Aug 2004 21:36:30 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2004-08-22 at 22:03, Josan Kadett wrote:
> Perhaps there is a way to recompute IP header checksums before they get into
> the interface? As I outlined, I have found a way to manipulate IP source
> address before the packet is flushed to system, but a means of recalculating
> the IP header checksum after that manipulation should be found. Because even
> if I ignore IP header CRC in one system, all other boxes connected to this
> machine has to be patched the same. That is impossible anyway.
> 
> Only if I could find a way to recalculate the checksum in IP headers by
> doing a simple hack to the kernel, everything would be alright. 

Providing your hardware isn't doing the checksums then you can do 
this. Each ethernet packet driver with pass packets up to the 
layer above (netif_rx()). Something like

	skb->protocol = eth_type_trans(...)
	/* Check packet here */
	whack_packet(skb->h.raw skb->len);
	netif_rx(skb);

in the driver. Before the netif_rx you can validly mangle the bits


