Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262297AbUKQMwl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262297AbUKQMwl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 07:52:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262300AbUKQMwl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 07:52:41 -0500
Received: from alog0317.analogic.com ([208.224.222.93]:21888 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262297AbUKQMwj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 07:52:39 -0500
Date: Wed, 17 Nov 2004 07:51:36 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: James.Smart@Emulex.Com
cc: linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: Potential issue with some implementations of pci_resource_start()
In-Reply-To: <0B1E13B586976742A7599D71A6AC733C12E716@xbl3.ma.emulex.com>
Message-ID: <Pine.LNX.4.61.0411170748240.5837@chaos.analogic.com>
References: <0B1E13B586976742A7599D71A6AC733C12E716@xbl3.ma.emulex.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Nov 2004 James.Smart@Emulex.Com wrote:

>
> According to Documentation/pci.txt: pci_resource_start() is to return the bus start address of the bar. It should essentially be a portable way to obtain the bar value without reading PCI config space directly.
>
> We have encountered at least 2 platforms (HP Integrity (IA-64) Olympia rx8620 partition, and a dual-processor IBM eServer pSeries p615) - where the contents of pci_resource_start() vary from the contents of the BARs in config space. For example:
> on IA64 Olympia: pci_resource_start(pcidev,0) = 0x00000f0030040000; pci bar0 word 0xf0040004, bar1 word 0x0
> On PPC eServer:  pci_resource_start(pcidev,0) = 0x000003fd80000000; pci bar0 word 0xc0000004, bar1 word 0x0
>
> We have demonstrated this on both the 2.4.21 and 2.6.5 kernels.
>
> Are these platform bugs that need to be corrected ? or is it a change in the pci_resource_start() definition ?
>
> -- James

pic_resource_start() is supposed to give you something that
ioremap() can use. On 64-bit platforms it is unlikely to be
a physical address, but a "cookie" that ioremap() knows about.

If you want the physical address you are going to have to read
the registers directly. It will give you a number that is useless
as an address, though.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by John Ashcroft.
                  98.36% of all statistics are fiction.
