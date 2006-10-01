Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932259AbWJATnJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932259AbWJATnJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 15:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932253AbWJATnI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 15:43:08 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:18067 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932252AbWJATnE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 15:43:04 -0400
Message-ID: <45201A39.6020500@garzik.org>
Date: Sun, 01 Oct 2006 15:42:49 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Matthew Wilcox <matthew@wil.cx>
CC: Arjan van de Ven <arjan@infradead.org>, linux-scsi@vger.kernel.org,
       "Linux-Kernel," <linux-kernel@vger.kernel.org>,
       "J.A. Magall??n" <jamagallon@ono.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       Frederik Deweerdt <deweerdt@free.fr>
Subject: Re: [-mm patch] aic7xxx: check irq validity (was Re: 2.6.18-mm2)
References: <20060928014623.ccc9b885.akpm@osdl.org> <20060929155738.7076f0c8@werewolf> <20060929143949.GL5017@parisc-linux.org> <1159550143.13029.36.camel@localhost.localdomain> <20060929235054.GB2020@slug> <1159573404.13029.96.camel@localhost.localdomain> <20060930140946.GA1195@slug> <451F049A.1010404@garzik.org> <20061001142807.GD16272@parisc-linux.org> <1159729523.2891.408.camel@laptopd505.fenrus.org> <20061001193616.GF16272@parisc-linux.org>
In-Reply-To: <20061001193616.GF16272@parisc-linux.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote:
> Others tend to use the driver name.  Changing them all to be 0000:00:1d.2
> isn't really an improvement in the readability of /proc/interrupts, IMO.

agreed


> Passing pdev as the data is a good idea for practically no device driver.

agreed


> It's rare to actually want the pci_device down in the interrupt handler;
> normally you want the device private data.  Using pci_get_drvdata(pdev)
> as the data would make sense for both sym2 and tg3.  I don't feel like

Using pci_get_drvdata() is a pretty good idea


> int pci_request_irq(struct pci_dev *pdev, irq_handler_t handler,
> 			const char *name)
> {
> 	if (!valid_irq(pdev->irq)) {
> 		dev_printk(KERN_ERR, &pdev->dev, "invalid irq\n");
> 		return -EINVAL;
> 	}
> 
> 	return request_irq(pdev->irq, handler, IRQF_SHARED, name,
> 				pci_get_drvdata(pdev));
> }
> 
> But what about IRQF_SAMPLE_RANDOM?

I still like having a flags argument though.  It's enough of an open 
question, and I bet there will be a new flag or two in the future that 
PCI drivers will want to use.

	Jeff


