Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751365AbWIIH05@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365AbWIIH05 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 03:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751366AbWIIH04
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 03:26:56 -0400
Received: from gate.crashing.org ([63.228.1.57]:27790 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751365AbWIIH04 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 03:26:56 -0400
Subject: Re: Opinion on ordering of writel vs. stores to RAM
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, segher@kernel.crashing.org, davem@davemloft.net
In-Reply-To: <17666.11971.416250.857749@cargo.ozlabs.ibm.com>
References: <17666.8433.533221.866510@cargo.ozlabs.ibm.com>
	 <Pine.LNX.4.64.0609081928570.27779@g5.osdl.org>
	 <17666.11971.416250.857749@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Sat, 09 Sep 2006 17:24:41 +1000
Message-Id: <1157786681.31071.168.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I suspect the best thing at this point is to move the sync in writeX()
> before the store, as you suggest, and add an "eieio" before the load
> in readX().  That does mean that we are then relying on driver writers
> putting in the mmiowb() between a writeX() and a spin_unlock, but at
> least that is documented.

Well, why keep the sync in writel then ? Isn't it agreed that the driver
should use an explicit barrier ? Or did I misunderstand Linus ?

Ben.


