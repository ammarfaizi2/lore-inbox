Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262722AbVE1Nxu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262722AbVE1Nxu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 09:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262723AbVE1Nxu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 09:53:50 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:17856 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S262722AbVE1Nxt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 09:53:49 -0400
Subject: Re: ISA DMA controller hangs
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <42987450.9000601@drzeus.cx>
References: <42987450.9000601@drzeus.cx>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1117288285.2685.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 28 May 2005 14:51:26 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2005-05-28 at 14:38, Pierre Ossman wrote:
> I've been having some problems with ISA DMA transfers failing. They work
> fine until the machine does a suspend-to-ram. After that all DMA
> transfers stall. Does perhaps the DMA controller need a kick in the ***
> after a suspend? I'm no expert on the ISA DMA controller so I could use
> some help here.

The DMA controller has some bits of state which are potentially in need
of restoration as well as a need to ensure you don't suspend while it is
running I would imagine. Even for bus masters I believe you would need
to restore the DMA enable bits.

See include/asm-i386/dma.h but note that some registers have side
effects and the dma_outb etc are used to get required delays on some PCs

Alan

