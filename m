Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271242AbRHOPwr>; Wed, 15 Aug 2001 11:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271243AbRHOPwh>; Wed, 15 Aug 2001 11:52:37 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:29707 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271242AbRHOPwW>; Wed, 15 Aug 2001 11:52:22 -0400
Subject: Re: Implications of PG_locked and reference count in page structures....
To: mheinz@infiniconsys.com (Michael Heinz)
Date: Wed, 15 Aug 2001 16:55:06 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <no.id> from "Michael Heinz" at Aug 15, 2001 11:39:49 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15X30c-0003Nq-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So, what I want to do is this: given a pointer to a previously 
> kmalloc'ed block, and the length of that block, I want to (a) identify 
> each page associated with the block and (b) lock each page. It appears 
> that I can lock the page either by incrementing it's reference count, or 
> by setting the PG_locked flag for the page.

If the block was allocated with kmalloc it isnt pageable. That means all you
need to do is to use the virt_to_bus() call. If you are doing PCI DMA
however the preferred approach from 2.4 onwards is the pci_alloc_* API
(see Documentation/DMA-mapping.txt)

> Which method is preferred? Is there another method I should be using 
> instead?

You should be fine. If they were user pages then you would want to look
at the kiovec support for mapping user pages and locking them down. For
kernel allocated buffers it is nice and easy.

The only other oddment to note is that ISA bus DMA requires GFP_DMA as a 
kmalloc flag, PCI DMA does not (GFP_DMA is "below 16Mb please")

Alan
