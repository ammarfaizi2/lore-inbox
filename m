Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129106AbRBNUwQ>; Wed, 14 Feb 2001 15:52:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129136AbRBNUwH>; Wed, 14 Feb 2001 15:52:07 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:57105 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129106AbRBNUvw>; Wed, 14 Feb 2001 15:51:52 -0500
Subject: Re: MTU and 2.4.x kernel
To: roger@kea.grace.cri.nz
Date: Wed, 14 Feb 2001 20:51:45 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, roger@kea.grace.cri.nz
In-Reply-To: <200102142039.PAA07913@whio.grace.cri.nz> from "roger@maths.grace.cri.nz" at Feb 14, 2001 03:39:09 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14T8tv-00060Y-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Kernel 2.4.x apparently disregards my ppp options MTU setting of 552
> and sets mss=536 (=> MTU=576). Kernel 2.2.16 sets mss=512 correctly.
> Is this a kernel bug or what?

The kernel is entitled to set an MSS that may cause fragmentation. So no
it isnt a bug.

	536 + 40 = 576

Im not sure why it made that choice but it is allowed to.
(cc'd to netdev to see if they know)

> Description: Typically Netscape/Lynx will connect to a remote site but
> will not download (it will hang indefinitely). When the browser is in 

Typically indicates your ISP has path mtu problems.

> the browser is locked for almost all remote sites, I _am_ able to
> connect to (the web page of) the proxy server itself. And after I do
> this the browser is *unlocked*, and I can connect/download from any web
> address. However this only lasts for 5 minutes or so, after which time

That would be a cached pmtu for that connection. I suspect the connections
via the proxy server are not sending back valid ICMP fragmentation required
frames for path mtu discovery.  That would suggest the problem is the ISP.
2.2 happened to cover this up for the case of a single host directly connected
to a modem with a low mtu.

Alan

