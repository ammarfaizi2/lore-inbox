Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261755AbULNXZu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261755AbULNXZu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 18:25:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261777AbULNXYu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 18:24:50 -0500
Received: from [213.146.154.40] ([213.146.154.40]:63385 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261755AbULNXP7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 18:15:59 -0500
Date: Tue, 14 Dec 2004 23:15:55 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Dale Farnsworth <dale@farnsworth.org>
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
       Ralf Baechle <ralf@linux-mips.org>, Russell King <rmk@arm.linux.org.uk>,
       Manish Lachwani <mlachwani@mvista.com>,
       Brian Waite <brian@waitefamily.us>,
       "Steven J. Hill" <sjhill@realitydiluted.com>
Subject: Re: [PATCH 3/6] mv643xx_eth: fix hw checksum generation on transmit
Message-ID: <20041214231555.GB11617@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dale Farnsworth <dale@farnsworth.org>, linux-kernel@vger.kernel.org,
	Jeff Garzik <jgarzik@pobox.com>, Ralf Baechle <ralf@linux-mips.org>,
	Russell King <rmk@arm.linux.org.uk>,
	Manish Lachwani <mlachwani@mvista.com>,
	Brian Waite <brian@waitefamily.us>,
	"Steven J. Hill" <sjhill@realitydiluted.com>
References: <20041213220949.GA19609@xyzzy> <20041213221541.GC19951@xyzzy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041213221541.GC19951@xyzzy>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +			dev_kfree_skb_irq((struct sk_buff *)
> +                                                  pkt_info.return_info);

pkt_info.return_info already is a pointer to struct sk_buff

> +			/* CPU already calculated pseudo header checksum. */
> +			if (skb->nh.iph->protocol == IPPROTO_UDP) {
> +				pkt_info.cmd_sts |= ETH_UDP_FRAME;
> +				pkt_info.l4i_chk = skb->h.uh->check;
> +			}
> +			else if (skb->nh.iph->protocol == IPPROTO_TCP)
> +				pkt_info.l4i_chk = skb->h.th->check;
> +			else {

			} else if (skb->nh.iph->protocol == IPPROTO_TCP) {
				pkt_info.l4i_chk = skb->h.th->check;
			} else {

> +	pkt_info.buf_ptr = pci_map_single(0, skb->data, skb->len,
> +							PCI_DMA_TODEVICE);

s/0/NULL/ to avoid sparse warnings

> +	/*
> +	 * The hardware requires that each buffer that is <= 8 bytes
> +	 * in length must be aligned on an 8 byte boundary.
> +	 */
> +        if (p_pkt_info->byte_cnt <= 8 && p_pkt_info->buf_ptr & 0x7) {

please use tabs, not spaces for indentation.

>  #ifdef MV64340_CHECKSUM_OFFLOAD_TX
> -        int tx_first_desc;
> +        int tx_busy_desc = mp->tx_first_desc_q;

Again.

