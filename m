Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317107AbSH0Vcq>; Tue, 27 Aug 2002 17:32:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317264AbSH0Vcq>; Tue, 27 Aug 2002 17:32:46 -0400
Received: from pizda.ninka.net ([216.101.162.242]:50833 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317107AbSH0Vcp>;
	Tue, 27 Aug 2002 17:32:45 -0400
Date: Tue, 27 Aug 2002 14:31:17 -0700 (PDT)
Message-Id: <20020827.143117.108811619.davem@redhat.com>
To: alan@lxorguk.ukuu.org.uk
Cc: andre@linux-ide.org, linux-kernel@vger.kernel.org
Subject: Re: readsw/writesw readsl/writesl
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1030469124.5695.9.camel@irongate.swansea.linux.org.uk>
References: <Pine.LNX.4.10.10208262321150.24156-100000@master.linux-ide.org>
	<20020827.003027.26962443.davem@redhat.com>
	<1030469124.5695.9.camel@irongate.swansea.linux.org.uk>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Alan Cox <alan@lxorguk.ukuu.org.uk>
   Date: 27 Aug 2002 18:25:24 +0100

   On Tue, 2002-08-27 at 08:30, David S. Miller wrote:
   > It used to be an optimization when cpus were really slow.
   
   readsl becomes relevant once people start shipping bridges that can do
   asynchronous pci mmio read or burst mode to order however
   
This would be relevant if the MMIO address were to increment,
but bursting from the same MMIO word?  That's what readsl
is meant to do, just as insl does for port I/O addresses.

UltraSPARC can do what you mention using 64-byte block loads and
stores, the same ones we use for fast memcpy/memset.  It just looks
like a huge 64-byte MMIO on the pci bus.
