Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267286AbSKPPTz>; Sat, 16 Nov 2002 10:19:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267287AbSKPPTz>; Sat, 16 Nov 2002 10:19:55 -0500
Received: from natsmtp01.webmailer.de ([192.67.198.81]:60812 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S267286AbSKPPTx>; Sat, 16 Nov 2002 10:19:53 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Arnd Bergmann <arndb@de.ibm.com>
Reply-To: Arnd Bergmann <ibm.com@arndb.de>
To: "J.E.J. Bottomley" <James.Bottomley@steeleye.com>
Subject: Re: [RFC][PATCH] move dma_mask into struct device
Date: Sat, 16 Nov 2002 18:23:48 +0100
User-Agent: KMail/1.4.3
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Scsi <linux-scsi@vger.kernel.org>,
       Mike Anderson <andmike@us.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200211161823.48018.arndb@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J.E.J. Bottomley [James.Bottomley@steeleye.com] wrote:

> Attached is a patch which moves dma_mask into struct device and cleans up the 
> scsi mid-layer to use it (instead of using struct pci_dev).  The advantage to 
> doing this is probably most apparent on non-pci bus architectures where 
> currently you have to construct a fake pci_dev just so you can get the bounce 
> buffers to work correctly.

That does not sound like the right way to me. If you need to have the dma_mask
for the Scsi_Host, you should store it in Scsi_Host itself. A struct device
must never know about obscure architecture specific stuff like dma.

	Arnd <><
