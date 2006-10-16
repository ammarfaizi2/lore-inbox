Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422955AbWJPXsq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422955AbWJPXsq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 19:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422942AbWJPXsq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 19:48:46 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:55277 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1422955AbWJPXsp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 19:48:45 -0400
Message-ID: <45341A59.6000402@pobox.com>
Date: Mon, 16 Oct 2006 19:48:41 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pata_marvell: Marvell 6101/6145 PATA driver
References: <1161013206.24237.85.camel@localhost.localdomain> <20061016163134.4560d253.akpm@osdl.org>
In-Reply-To: <20061016163134.4560d253.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Mon, 16 Oct 2006 16:40:06 +0100
> Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> 
>> +static int marvell_pre_reset(struct ata_port *ap)
>> +{
>> +	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
>> +	u32 devices;
>> +	unsigned long bar5;
>> +	void __iomem *barp;
>> +	int i;
>> +
>> +	/* Check if our port is enabled */
>> +
>> +	bar5 = pci_resource_start(pdev, 5);
>> +	barp = ioremap(bar5, 0x10);
> 
> hm.  pci_resource_start() returns a possibly-64-bit resource_size_t
> nowadays.  But ioremap() doesn't know how to remap such a thing.

These days, pci_iomap() should be used anyway.

	Jeff



