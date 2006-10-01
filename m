Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932216AbWJATGV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216AbWJATGV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 15:06:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932215AbWJATGV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 15:06:21 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:14757 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932216AbWJATGU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 15:06:20 -0400
Subject: Re: [-mm patch] aic7xxx: check irq validity (was Re: 2.6.18-mm2)
From: Arjan van de Ven <arjan@infradead.org>
To: Matthew Wilcox <matthew@wil.cx>
Cc: linux-scsi@vger.kernel.org, "Linux-Kernel," <linux-kernel@vger.kernel.org>,
       "J.A. Magall??n" <jamagallon@ono.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       Frederik Deweerdt <deweerdt@free.fr>, Jeff Garzik <jeff@garzik.org>
In-Reply-To: <20061001142807.GD16272@parisc-linux.org>
References: <20060928014623.ccc9b885.akpm@osdl.org>
	 <20060929155738.7076f0c8@werewolf> <20060929143949.GL5017@parisc-linux.org>
	 <1159550143.13029.36.camel@localhost.localdomain>
	 <20060929235054.GB2020@slug>
	 <1159573404.13029.96.camel@localhost.localdomain>
	 <20060930140946.GA1195@slug> <451F049A.1010404@garzik.org>
	 <20061001142807.GD16272@parisc-linux.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Sun, 01 Oct 2006 21:05:23 +0200
Message-Id: <1159729523.2891.408.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> .
> 
> And it doesn't need to be a __must_check.  There's no point -- it has
> no side-effects.  The only reason to call it is if you want the answer
> to the question.  You had the sense of the return code wrong too; you
> want to use it as:
> 
> int pci_request_irq(struct pci_dev *pdev, irq_handler_t handler,
> 			unsigned long flags, const char *name, void *data)
> {
> 	if (!valid_irq(pdev->irq)) {
> 		dev_printk(KERN_ERR, &pdev->dev, "invalid irq\n");
> 		return -EINVAL;
> 	}
> 
> 	return request_irq(pdev->irq, handler, flags | IRQF_SHARED, name, data);
> }


well... why not go one step further and eliminate the flags argument
entirely? And use pci_name() for the name (so eliminate the argument ;)
and always pass pdev as data, so that that argument can go away too....

that'll cover 99% of the request_irq() users for pci devices.. and makes
it really nicely simple and consistent.

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com

