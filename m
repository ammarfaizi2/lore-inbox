Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267940AbTBEMQb>; Wed, 5 Feb 2003 07:16:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267939AbTBEMP2>; Wed, 5 Feb 2003 07:15:28 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:11601 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S267933AbTBEMOs>; Wed, 5 Feb 2003 07:14:48 -0500
From: Alan Cox <alan@redhat.com>
Message-Id: <200302051224.h15COLj03064@devserv.devel.redhat.com>
Subject: Re: 2.4.21-pre4: PDC ide driver problems with shared interrupts
To: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Wed, 5 Feb 2003 07:24:21 -0500 (EST)
Cc: alan@redhat.com, skraw@ithnet.com (Stephan von Krawczynski),
       linux-kernel@vger.kernel.org
In-Reply-To: <1044443761.685.44.camel@zion.wanadoo.fr> from "Benjamin Herrenschmidt" at Feb 05, 2003 12:16:02 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ide_dma_intr() called while the drive was busy. This is strange for a
> simple reason: Even if we got the wrong interrupt (shared interrupt),
> __ide_dma_test_irq() should have returned 0, and so ide_dma_intr
> shouldn't have been called.

Ok the other mail makes more sense now 8)

> drive->waiting_for_dma is set before setting up the handler and
> issuing the command, and while the DMA engine is indeed started
> only after sending the command, it's INTR bit have been cleared
> previously (I suppose it can't be stale, or can it while the DMA
> haven't been started yet ? In this case we would need to take
> the lock here).

I'd have to go digging. I think that can occur however.

Andre ?
