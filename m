Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316434AbSIIFDE>; Mon, 9 Sep 2002 01:03:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316437AbSIIFDE>; Mon, 9 Sep 2002 01:03:04 -0400
Received: from pizda.ninka.net ([216.101.162.242]:43931 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316434AbSIIFDD>;
	Mon, 9 Sep 2002 01:03:03 -0400
Date: Sun, 08 Sep 2002 22:00:08 -0700 (PDT)
Message-Id: <20020908.220008.79156946.davem@redhat.com>
To: phillips@arcor.de
Cc: imran.badr@cavium.com, linux-kernel@vger.kernel.org
Subject: Re: Calculating kernel logical address ..
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <E17oGD2-0006lP-00@starship>
References: <E17nUee-0006Lc-00@starship>
	<20020907.170151.84915731.davem@redhat.com>
	<E17oGD2-0006lP-00@starship>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Daniel Phillips <phillips@arcor.de>
   Date: Sun, 8 Sep 2002 20:44:17 +0200

   > For anything else you're in non-portablt land, including and
   > in partiular:
   > 
   > 1) kernel stack addresses
   
   Could you elaborate on what bad things happen here?
   
Kernel stack allocation is defined per-architecture.  On
sun4c sparc systems, we carve virtual pages out from the kernel
address space and hard map them into the TLB by hand.

   > 2) addresses within the main kernel image text/data/bss
   
   Yep.  MIPS's KSEG0 (a stupid design if there ever was one)

Actually, KSEG0 the most Linux friendly design in the world
particularly in 64-bit mode.  There is no need to have page tables at
all for the main kernel physical memory map.  It would shave a lot of
code from the sparc64 TLB miss handlers if I didn't have to handle
PAGE_OFFSET pages, for example.

Alpha does something akin to KSEG0 as well.

I pine constantly for it appearing some day on a future UltraSPARC
revision :-)
