Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318765AbSH1IQc>; Wed, 28 Aug 2002 04:16:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318767AbSH1IQc>; Wed, 28 Aug 2002 04:16:32 -0400
Received: from pizda.ninka.net ([216.101.162.242]:62870 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S318765AbSH1IQb>;
	Wed, 28 Aug 2002 04:16:31 -0400
Date: Wed, 28 Aug 2002 01:15:09 -0700 (PDT)
Message-Id: <20020828.011509.29049124.davem@redhat.com>
To: sp@scali.com
Cc: linux-kernel@vger.kernel.org, beowulf@beowulf.org
Subject: Re: Channel bonding GbE (Tigon3)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0208280933250.9999-100000@sp-laptop.isdn.scali.no>
References: <Pine.LNX.4.44.0208271934180.18659-100000@sp-laptop.isdn.scali.no>
	<Pine.LNX.4.44.0208280933250.9999-100000@sp-laptop.isdn.scali.no>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Steffen Persvold <sp@scali.com>
   Date: Wed, 28 Aug 2002 10:06:19 +0200 (CEST)

   > I have an idea that this happens because the packets are comming out of 
   > order into the receiving node (i.e the bonding device is alternating 
   > between each interface when sending, and when the receiving node gets the 
   > packets it is possible that the first interface get packets number 0, 2, 
   > 4 and 6 in one interrupt and queues it to the network stack before packet 
   > 1, 3, 5 is handled on the other interface).

That is exactly what is happening.  Packets are being reordered.

Welcome to one of the flaws of round-robin trunking. :-)

   > If this is the case, any ideas how to fix this...

Don't use round-robin, choose the output device based upon
hashing of some bits in the IP/TCP headers :-)

You won't get 2Gb/sec for a single TCP stream, but you will
for 2 or more.
