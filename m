Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265149AbTL2W6z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 17:58:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265150AbTL2W6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 17:58:55 -0500
Received: from [24.35.117.106] ([24.35.117.106]:61321 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S265149AbTL2W6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 17:58:51 -0500
Date: Mon, 29 Dec 2003 17:58:44 -0500 (EST)
From: Thomas Molina <tmolina@cablespeed.com>
X-X-Sender: tmolina@localhost.localdomain
To: Linus Torvalds <torvalds@osdl.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0 performance problems
In-Reply-To: <Pine.LNX.4.58.0312291420370.1586@home.osdl.org>
Message-ID: <Pine.LNX.4.58.0312291755080.5835@localhost.localdomain>
References: <Pine.LNX.4.58.0312291647410.5288@localhost.localdomain>
 <Pine.LNX.4.58.0312291420370.1586@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Dec 2003, Linus Torvalds wrote:

> 
> 
> On Mon, 29 Dec 2003, Thomas Molina wrote:
> >
> > I just finished a couple of comparisons between 2.4 and 2.6 which seem to 
> > confirm my impressions.  I understand that the comparison may not be 
> > apples to apples and my methods of testing may not be rigorous, but here 
> > it is.  In contrast to some recent discussions on this list, this test is 
> > a "real world" test at which 2.6 comes off much worse than 2.4.  
> 
> Are you sure you have DMA enabled on your laptop disk? Your 2.6.x system 
> times are very high - much bigger than the user times. That sounds like 
> PIO to me.

It certainly looks like DMA is enabled.  Under 2.4 I get:

[root@lap root]# hdparm /dev/hda

/dev/hda:
 multcount    = 16 (on)
 IO_support   =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 2584/240/63, sectors = 39070080, start = 0


Under 2.6  I get:

[root@lap root]# hdparm /dev/hda

/dev/hda:
 multcount    = 16 (on)
 IO_support   =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    = 256 (on)
 geometry     = 38760/16/63, sectors = 39070080, start = 0


Relevant items from my 2.6 configuration file:

CONFIG_GENERIC_ISA_DMA=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
# CONFIG_IDEDMA_PCI_WIP is not set
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_DMA_NONPCI is not set

