Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261774AbVF1NzY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261774AbVF1NzY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 09:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261987AbVF1NzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 09:55:13 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:62902 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261774AbVF1Nxc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 09:53:32 -0400
Subject: Re: [PATCH] net: add driver for the NIC on Cell Blades
From: Arjan van de Ven <arjan@infradead.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, netdev@vger.kernel.org,
       linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       Jens Osterkamp <Jens.Osterkamp@de.ibm.com>,
       Utz Bacher <utz.bacher@de.ibm.com>
In-Reply-To: <200506281528.08834.arnd@arndb.de>
References: <200506281528.08834.arnd@arndb.de>
Content-Type: text/plain
Date: Tue, 28 Jun 2005 15:53:18 +0200
Message-Id: <1119966799.3175.32.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-06-28 at 15:28 +0200, Arnd Bergmann wrote:
> 
> +static void
> +spider_net_rx_irq_off(struct spider_net_card *card)
> +{
> +       u32 regvalue;
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&card->intmask_lock, flags);
> +       regvalue = spider_net_read_reg(card, SPIDER_NET_GHIINT0MSK);
> +       regvalue &= ~SPIDER_NET_RXINT;
> +       spider_net_write_reg(card, SPIDER_NET_GHIINT0MSK, regvalue);
> +       spin_unlock_irqrestore(&card->intmask_lock, flags);
> +}

I think you have a PCI posting bug here....

