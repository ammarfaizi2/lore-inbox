Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261651AbVCNRxu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261651AbVCNRxu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 12:53:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261652AbVCNRwF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 12:52:05 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:49058 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261651AbVCNRsK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 12:48:10 -0500
Subject: Re: User mode drivers: part 2: PCI device handling (patch 1/2 for
	2.6.11)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Peter Chubb <peterc@gelato.unsw.edu.au>
Cc: Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <16948.55096.598031.618338@wombat.chubb.wattle.id.au>
References: <16945.4717.402555.893411@berry.gelato.unsw.EDU.AU>
	 <20050311071825.GA28613@kroah.com>
	 <16945.22566.593812.759201@wombat.chubb.wattle.id.au>
	 <20050311152106.GA32584@kroah.com>
	 <16948.55096.598031.618338@wombat.chubb.wattle.id.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1110822361.17740.141.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 14 Mar 2005 17:46:02 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-03-14 at 00:13, Peter Chubb wrote:
> Greg> see mmap(2)
> 
> mmap maps a file's contents into your own virtual memory.
> usr_pci_map maps part of your own virtual memory into pci bus space
> for a particular device (using the IOMMU if your machine has one), and
> returns a scatterlist of bus addresses to hand to the device.

You can't really do it that way around because you don't know what the
memory constraints of the device are compared to your user pages.
Suppose your user pages are in high memory over 4GB and the device is
32bit DMA constrained ? You don't want bounce buffers clearly.

In addition you have to be very careful about shared pages when doing
DMA because you don't want to DMA into a COW page but that is handleable
(as is done by O_DIRECT)

Alan

