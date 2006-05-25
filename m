Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965107AbWEYK1T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965107AbWEYK1T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 06:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965108AbWEYK1T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 06:27:19 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:37535 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965107AbWEYK1S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 06:27:18 -0400
Message-ID: <44758683.4070205@garzik.org>
Date: Thu, 25 May 2006 06:27:15 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Jiri Slaby <jirislaby@gmail.com>
CC: Greg KH <gregkh@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 3/3] pci: gt96100eth use pci probing
References: <20060525003151.598EAC7C19@atrey.karlin.mff.cuni.cz> <4474FFE1.4030202@garzik.org> <44758308.2040408@gmail.com>
In-Reply-To: <44758308.2040408@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby wrote:
>>> +unprobe:
>>> +    for (j = i; j > 0; j--) {
>>> +        struct gt96100_if_t *gtif = &gtifs[j - 1];
>>> +        gt96100_remove1(gtif);
>>> +    }
>>> +    kfree(gtifs);
>> upon failure, you fail to set drvdata back to NULL
> What is the purpose of setting this to NULL, other drivers don't do that too?

A simple grep(1) shows well over 300 cases that do this.

And it's just logical:  don't leave a pointer hanging around, after it 
has been kfree'd.


>>> +        struct gt96100_private *gp = netdev_priv(gtif->dev);
>>> +        unregister_netdev(gtif->dev);
>>> +        dmafree(RX_HASH_TABLE_SIZE, gp->hash_table_dma);
>>> +        dmafree(PKT_BUF_SZ*RX_RING_SIZE, gp->rx_buff);
>>> +        dmafree(sizeof(gt96100_rd_t) * RX_RING_SIZE
>>> +            + sizeof(gt96100_td_t) * TX_RING_SIZE,
>>> +            gp->rx_ring);
>>> +        free_netdev(gtif->dev);
>>> +        release_region(gtif->iobase, gp->io_size);
>> shouldn't this be using pci_request_regions() / pci_release_regions() ?
> There are GT96100_ETH{0,1}_BASEs instead of bars, 

Indeed.  I stand corrected.

	Jeff


