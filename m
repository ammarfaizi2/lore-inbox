Return-Path: <linux-kernel-owner+w=401wt.eu-S1422642AbXAHQeG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422642AbXAHQeG (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 11:34:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422635AbXAHQeG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 11:34:06 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:55639 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422642AbXAHQeF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 11:34:05 -0500
Message-ID: <45A27278.9000007@pobox.com>
Date: Mon, 08 Jan 2007 11:34:00 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Alan <alan@lxorguk.ukuu.org.uk>
CC: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sata_via: PATA support, resubmit
References: <20070108122659.00c22754@localhost.localdomain>	<45A24159.7060001@pobox.com>	<20070108154249.6d8f5697@localhost.localdomain>	<45A2688E.3080503@pobox.com> <20070108164050.60633505@localhost.localdomain>
In-Reply-To: <20070108164050.60633505@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan wrote:
>> Just separate PATA and SATA operations.  That way everything works as 
>> expected, and you don't unintentionally add lovely oopses all over the 
>> place.
> 
> Ok - based on your pointers to [ab]using port_start you want something
> like this for now, with the port_start evaporating when Tejun's probe
> changes go in ?
> 
> Signed-off-by: Alan Cox <alan@redhat.com>

Looks good to me, modulo minor comments below...



> +static void vt6421_set_pio_mode(struct ata_port *ap, struct ata_device *adev)
> +{
> +	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
> +	static const u8 pio_bits[] = { 0xA8, 0x65, 0x65, 0x31, 0x20 };
> +	if (ap->port_no == PATA_PORT)
> +		pci_write_config_byte(pdev, PATA_PIO_TIMING, pio_bits[adev->pio_mode - XFER_PIO_0]);
> +}
> +
> +static void vt6421_set_dma_mode(struct ata_port *ap, struct ata_device *adev)
> +{
> +	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
> +	static const u8 udma_bits[] = { 0xEE, 0xE8, 0xE6, 0xE4, 0xE2, 0xE1, 0xE0, 0xE0 };
> +	if (ap->port_no == PATA_PORT)
> +		pci_write_config_byte(pdev, PATA_UDMA_TIMING, udma_bits[adev->pio_mode - XFER_UDMA_0]);
> +}

You can kill the '== PATA_PORT' tests now.

	Jeff


