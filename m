Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932594AbWJBCNJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932594AbWJBCNJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 22:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932595AbWJBCNI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 22:13:08 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:22695 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932594AbWJBCNF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 22:13:05 -0400
Subject: Re: [-mm patch] aic7xxx: check irq validity (was Re: 2.6.18-mm2)
From: Arjan van de Ven <arjan@infradead.org>
To: Matthew Wilcox <matthew@wil.cx>
Cc: linux-scsi@vger.kernel.org, "Linux-Kernel," <linux-kernel@vger.kernel.org>,
       "J.A. Magall??n" <jamagallon@ono.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       Frederik Deweerdt <deweerdt@free.fr>, Jeff Garzik <jeff@garzik.org>
In-Reply-To: <20061001193616.GF16272@parisc-linux.org>
References: <20060928014623.ccc9b885.akpm@osdl.org>
	 <20060929155738.7076f0c8@werewolf> <20060929143949.GL5017@parisc-linux.org>
	 <1159550143.13029.36.camel@localhost.localdomain>
	 <20060929235054.GB2020@slug>
	 <1159573404.13029.96.camel@localhost.localdomain>
	 <20060930140946.GA1195@slug> <451F049A.1010404@garzik.org>
	 <20061001142807.GD16272@parisc-linux.org>
	 <1159729523.2891.408.camel@laptopd505.fenrus.org>
	 <20061001193616.GF16272@parisc-linux.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Mon, 02 Oct 2006 04:12:21 +0200
Message-Id: <1159755141.2891.434.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Network drivers use their eth%d name.  USB drivers use [eu]hci_hcd:usb%d.
> Others tend to use the driver name.  Changing them all to be 0000:00:1d.2
> isn't really an improvement in the readability of /proc/interrupts, IMO.

hmm ok; how about allowing name to be NULL, and if it's NULL, use the
pci name?

> 
> So, current proposal:
> 
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

that's a tough question. I'd almost suggest making such things
properties of the pdev, but sample-random is so far away from PCI
related that it makes no sense I suppose ;(

(others do I think)

One other interesting question is if this function can/should be used to
use MSI transparently (after pci_enable_msi() obviously)

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com

