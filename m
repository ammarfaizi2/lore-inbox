Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276341AbRI1WLW>; Fri, 28 Sep 2001 18:11:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276340AbRI1WLM>; Fri, 28 Sep 2001 18:11:12 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:52491 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276343AbRI1WLC>; Fri, 28 Sep 2001 18:11:02 -0400
Subject: Re: mm: critical shortage of bounce buffers
To: sp@scali.no (Steffen Persvold)
Date: Fri, 28 Sep 2001 23:16:16 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org (lkml)
In-Reply-To: <3BB4D072.4D3EE56B@scali.no> from "Steffen Persvold" at Sep 28, 2001 09:33:06 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15n5vc-00005n-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Its in the high mem handling routines. It means the machine stalled for
> > a moment doing I/O because it had no memory below 1Gb to use.
> 
> But why does it need to have memory below 1Gb ?? Normally, 32bit PCI DMA
> controllers (such as network cards and disk controllers) can access up to 4GB of
> physical memory within the machine, so unless you are using the CONFIG_HIGHMEM4G
> option it shouldn't need bounce buffers. Or am I missing something here
> (something like the second physical GB is actually in the address range
> 4GB->)???

The core code doesn't know if the device is PIO or DMA, and it cannot 
pass virtually unmapped objects to the block layer. This is what Jens has
been fixing.

