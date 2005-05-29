Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261447AbVE2Vjc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261447AbVE2Vjc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 17:39:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261448AbVE2Vjc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 17:39:32 -0400
Received: from mail.macqel.be ([194.78.208.39]:45576 "EHLO mail.macqel.be")
	by vger.kernel.org with ESMTP id S261447AbVE2Vj2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 17:39:28 -0400
Message-Id: <200505292138.j4TLcrJ28536@mail.macqel.be>
Subject: Re: PATCH : ppp + big-endian = kernel crash
In-Reply-To: <20050529.135257.98862077.davem@davemloft.net> from "David S. Miller"
 at "May 29, 2005 01:52:57 pm"
To: "David S. Miller" <davem@davemloft.net>
Date: Sun, 29 May 2005 23:38:53 +0200 (CEST)
CC: linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org
From: "Philippe De Muyter" <phdm@macqel.be>
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have also sent this message to uclinux-dev, where it can be of interest.

David S. Miller wrote :
> From: "Philippe De Muyter" <phdm@macqel.be>
> Date: Sun, 29 May 2005 21:48:42 +0200 (CEST)
> 
> > +		/* If the address of the packet is odd now, fix it. */
> > +		if ((unsigned long)skb->data & 1) {
> > +			unsigned char *p;
> 
> And now it will crash when a packet is only 2-byte aligned
> when the input packet processing does the first access
> to the IP address in the packet header.

Actually, my fix has been tested extensively, and m68k's won't crash when
accessing 4-bytes words on only 2-byte aligned addresses.  If you mean
that I moved the packet in the wrong direction to get the best alignment,
this can easily be fixed.

> 
> Please make your m68k port handle unaligned memory accesses
> in kernel mode properly instead.
> 

Do you mean that ip_rcv may not assume that packets are properly aligned ?

And some non-mmu m68k (Coldfires) do not provide enough information in
exception frames to restart instructions on an address error in the general
case.

Best regards

Philippe
