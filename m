Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267106AbSLDVj3>; Wed, 4 Dec 2002 16:39:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267107AbSLDVj3>; Wed, 4 Dec 2002 16:39:29 -0500
Received: from host194.steeleye.com ([66.206.164.34]:15368 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S267106AbSLDVj2>; Wed, 4 Dec 2002 16:39:28 -0500
Message-Id: <200212042146.gB4Lkw804422@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Miles Bader <miles@gnu.org>
cc: James Bottomley <James.Bottomley@SteelEye.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] generic device DMA implementation 
In-Reply-To: Message from Miles Bader <miles@gnu.org> 
   of "05 Dec 2002 06:21:42 +0900." <87smxdiiop.fsf@tc-1-100.kawasaki.gol.ne.jp> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 04 Dec 2002 15:46:58 -0600
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

miles@gnu.org said:
> How is the driver supposed to tell whether a given dma_addr_t value
> represents consistent memory or not?  It seems like an (arch-specific)
> `dma_addr_is_consistent' function is necessary, but I couldn't see one
> in your patch. 

well, the patch was only for x86, which is fully consistent.  For parisc, that 
becomes a field for the dma accessor functions.

However, even on parisc, the (supported) machines are either entirely 
consistent or entirely inconsistent.

If you have a machine that has both consistent and inconsistent blocks, you 
need to encode that in dma_addr_t (which is a platform definable type).

The sync functions would just decode the type and either nop or perform the 
sync.

James


