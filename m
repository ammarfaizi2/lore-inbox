Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267184AbSLECYY>; Wed, 4 Dec 2002 21:24:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267188AbSLECYY>; Wed, 4 Dec 2002 21:24:24 -0500
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:7878 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S267184AbSLECYY>; Wed, 4 Dec 2002 21:24:24 -0500
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] generic device DMA implementation
References: <200212042146.gB4Lkw804422@localhost.localdomain>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 05 Dec 2002 11:31:10 +0900
In-Reply-To: <200212042146.gB4Lkw804422@localhost.localdomain>
Message-ID: <buou1htryc1.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley <James.Bottomley@steeleye.com> writes:
> > How is the driver supposed to tell whether a given dma_addr_t value
> > represents consistent memory or not?  It seems like an
> > (arch-specific) `dma_addr_is_consistent' function is necessary, but
> > I couldn't see one in your patch.
> 
> If you have a machine that has both consistent and inconsistent blocks, you 
> need to encode that in dma_addr_t (which is a platform definable type).
> 
> The sync functions would just decode the type and either nop or perform the 
> sync.

My thinking was that a driver might want to do things like --

  if (dma_addr_is_consistent (some_funky_addr)) {
    do it quickly;
  } else
    do_it_the_slow_way (some_funky_addr);

in other words, something besides just calling the sync functions, in
the case where the memory was consistent.

-Miles
-- 
Suburbia: where they tear out the trees and then name streets after them.
