Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262240AbUKQJ6l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262240AbUKQJ6l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 04:58:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262253AbUKQJ6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 04:58:41 -0500
Received: from vanessarodrigues.com ([192.139.46.150]:3244 "EHLO
	jaguar.mkp.net") by vger.kernel.org with ESMTP id S262240AbUKQJ6j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 04:58:39 -0500
To: James.Smart@Emulex.Com
Cc: <linux-kernel@vger.kernel.org>, <greg@kroah.com>
Subject: Re: Potential issue with some implementations of pci_resource_start()
References: <0B1E13B586976742A7599D71A6AC733C12E716@xbl3.ma.emulex.com>
From: Jes Sorensen <jes@wildopensource.com>
Date: 17 Nov 2004 04:58:38 -0500
In-Reply-To: <0B1E13B586976742A7599D71A6AC733C12E716@xbl3.ma.emulex.com>
Message-ID: <yq01xesajap.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "James" == James Smart <James.Smart@Emulex.Com> writes:

James> According to Documentation/pci.txt: pci_resource_start() is to
James> return the bus start address of the bar. It should essentially
James> be a portable way to obtain the bar value without reading PCI
James> config space directly.

According to Documentation/pci.txt:
pci_resource_start()            Returns bus start address for a given
PCI region

James> We have encountered at least 2 platforms (HP Integrity (IA-64)
James> Olympia rx8620 partition, and a dual-processor IBM eServer
James> pSeries p615) - where the contents of pci_resource_start() vary
James> from the contents of the BARs in config space. For example: on
James> IA64 Olympia: pci_resource_start(pcidev,0) =
James> 0x00000f0030040000; pci bar0 word 0xf0040004, bar1 word 0x0 On
James> PPC eServer: pci_resource_start(pcidev,0) = 0x000003fd80000000;
James> pci bar0 word 0xc0000004, bar1 word 0x0

James> We have demonstrated this on both the 2.4.21 and 2.6.5 kernels.

James> Are these platform bugs that need to be corrected ? or is it a
James> change in the pci_resource_start() definition ?

pci_resource_start will rather give you a cookie that you can pass to
iomap() (ioremap() in the old API) etc. You shouldn't be relying on
the physical bar content for anything in a Linux driver.

Are you unable to access the space after mapping it?

Cheers,
Jes

