Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262185AbUKQD22@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262185AbUKQD22 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 22:28:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262189AbUKQD21
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 22:28:27 -0500
Received: from emulex.emulex.com ([138.239.112.1]:23036 "EHLO
	emulex.emulex.com") by vger.kernel.org with ESMTP id S262185AbUKQD0U convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 22:26:20 -0500
From: James.Smart@Emulex.Com
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: Potential issue with some implementations of pci_resource_start()
Date: Tue, 16 Nov 2004 22:25:55 -0500
Message-ID: <0B1E13B586976742A7599D71A6AC733C12E716@xbl3.ma.emulex.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Question on PCI
Thread-Index: AcTIPISJxofeC/SASRu4QFgETVGlSgDyA7Mg
To: <linux-kernel@vger.kernel.org>
Cc: <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


According to Documentation/pci.txt: pci_resource_start() is to return the bus start address of the bar. It should essentially be a portable way to obtain the bar value without reading PCI config space directly.

We have encountered at least 2 platforms (HP Integrity (IA-64) Olympia rx8620 partition, and a dual-processor IBM eServer pSeries p615) - where the contents of pci_resource_start() vary from the contents of the BARs in config space. For example:
on IA64 Olympia: pci_resource_start(pcidev,0) = 0x00000f0030040000; pci bar0 word 0xf0040004, bar1 word 0x0 
On PPC eServer:  pci_resource_start(pcidev,0) = 0x000003fd80000000; pci bar0 word 0xc0000004, bar1 word 0x0 

We have demonstrated this on both the 2.4.21 and 2.6.5 kernels.

Are these platform bugs that need to be corrected ? or is it a change in the pci_resource_start() definition ?

-- James
