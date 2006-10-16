Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422930AbWJPXb7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422930AbWJPXb7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 19:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422932AbWJPXb6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 19:31:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:44475 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422930AbWJPXb5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 19:31:57 -0400
Date: Mon, 16 Oct 2006 16:31:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: Re: [PATCH] pata_marvell: Marvell 6101/6145 PATA driver
Message-Id: <20061016163134.4560d253.akpm@osdl.org>
In-Reply-To: <1161013206.24237.85.camel@localhost.localdomain>
References: <1161013206.24237.85.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Oct 2006 16:40:06 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> +static int marvell_pre_reset(struct ata_port *ap)
> +{
> +	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
> +	u32 devices;
> +	unsigned long bar5;
> +	void __iomem *barp;
> +	int i;
> +
> +	/* Check if our port is enabled */
> +
> +	bar5 = pci_resource_start(pdev, 5);
> +	barp = ioremap(bar5, 0x10);

hm.  pci_resource_start() returns a possibly-64-bit resource_size_t
nowadays.  But ioremap() doesn't know how to remap such a thing.
