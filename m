Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265426AbUFSKH3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265426AbUFSKH3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 06:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265455AbUFSKH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 06:07:28 -0400
Received: from [213.146.154.40] ([213.146.154.40]:15564 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S265426AbUFSKHR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 06:07:17 -0400
Date: Sat, 19 Jun 2004 11:07:14 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Brian Lazara <blazara@nvidia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.7 and 2.4.27-pre6] new device support for forcedeth.c
Message-ID: <20040619100714.GA3554@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Brian Lazara <blazara@nvidia.com>, linux-kernel@vger.kernel.org
References: <1087629194.19311.24.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1087629194.19311.24.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 19, 2004 at 12:13:14AM -0700, Brian Lazara wrote:
> +#ifndef free_netdev
> +#define free_netdev(dev) kfree(dev);
> +#endif

free_netdev isn't a macro in 2.6, so you're going to blow up nicely.

> +#define PCI_DEVICE_ID_NVIDIA_NVENET_1  0x01C3
> +#define PCI_DEVICE_ID_NVIDIA_NVENET_2  0x0066
> +#define PCI_DEVICE_ID_NVIDIA_NVENET_3  0x00D6
> +#define PCI_DEVICE_ID_NVIDIA_NVENET_4  0x0086
> +#define PCI_DEVICE_ID_NVIDIA_NVENET_5  0x008C
> +#define PCI_DEVICE_ID_NVIDIA_NVENET_6  0x00E6
> +#define PCI_DEVICE_ID_NVIDIA_NVENET_7  0x00DF
> +#define PCI_DEVICE_ID_NVIDIA_NVENET_8  0x0056
> +#define PCI_DEVICE_ID_NVIDIA_NVENET_9  0x0057
> +#define PCI_DEVICE_ID_NVIDIA_NVENET_10 0x0037
> +#define PCI_DEVICE_ID_NVIDIA_NVENET_11 0x0038

The go to include/linux/pci_ids.h

> + *  Function pointers based on descriptor version
> + */
> +int (*nv_alloc_rx)(struct net_device *dev);
> +int (*nv_start_xmit)(struct sk_buff *skb, struct net_device *dev);
> +void (*nv_tx_done)(struct net_device *dev);
> +void (*nv_rx_process)(struct net_device *dev);

Better to put them into the per-device data structures or you're screwed
if you have two of those in a system (and even if that's totally impossible
global variables like that are still bad style.

