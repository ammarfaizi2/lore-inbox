Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262949AbTDIJSJ (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 05:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262951AbTDIJSJ (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 05:18:09 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:25094
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S262949AbTDIJSH (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 05:18:07 -0400
Date: Wed, 9 Apr 2003 02:29:09 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Soeren Sonnenburg <kernel@nn7.de>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.21pre6 (__ide_dma_test_irq) called while not waiting
In-Reply-To: <1049879881.2774.40.camel@fortknox>
Message-ID: <Pine.LNX.4.10.10304090227490.12558-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Does the broadcom driver have a test for who owns the intq?
If it is eating the hpt370's interrupt, well you already see the picture.

Andre Hedrick
LAD Storage Consulting Group

On 9 Apr 2003, Soeren Sonnenburg wrote:

> I have a hpt370 based controller which shares an irq with a broadcom
> bcm4401 network adaptor.
> 
> when transferring stuff over the network the ide controller drops the
> dma for all disks on the controller repeatedly... so it is not a
> cable/disk problem but a problem in the nic's driver/the hpt driver.
> 
> however this stuff only happens when I put high load on the nic. the
> drives form a software raid and reconstructing it does not cause any
> trouble...
> 
> here is my setup:
> 7:   28328328          XT-PIC  ide4, ide5, eth0
> 
> 
> hdi: 4 bytes in FIFO
> hdi: timeout waiting for DMA
> hdi: (__ide_dma_test_irq) called while not waiting
> hdi: dma_intr: status=0x58 { DriveReady SeekComplete DataRequest }
> 
> hdk: dma_intr: status=0x58 { DriveReady SeekComplete DataRequest }
> 
> hdk: status timeout: status=0xd0 { Busy }
> 
> hdk: DMA disabled
> hdk: drive not ready for command
> ide4: reset: success
> ide5: reset: success
> 
> Thanks,
> Soeren.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

