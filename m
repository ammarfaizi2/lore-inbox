Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422685AbWHZQ1y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422685AbWHZQ1y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Aug 2006 12:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422687AbWHZQ1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Aug 2006 12:27:54 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:64955 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1422685AbWHZQ1x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Aug 2006 12:27:53 -0400
Subject: Re: [patch 05/10] [TULIP] Defer tulip_select_media() to process
	context
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Valerie Henson <val_henson@linux.intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       Kyle McMartin <kyle@parisc-linux.org>, Jeff Garzik <jeff@garzik.org>
In-Reply-To: <20060826000303.523391000@linux.intel.com>
References: <20060826000227.818796000@linux.intel.com>
	 <20060826000303.523391000@linux.intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 26 Aug 2006 17:44:26 +0100
Message-Id: <1156610666.3007.290.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-08-25 am 17:02 -0700, ysgrifennodd Valerie Henson:
> +static inline void tulip_tx_timeout_complete(struct tulip_private *tp, void __iomem *ioaddr)
> +{
> +	/* Stop and restart the chip's Tx processes. */
> +	tulip_restart_rxtx(tp);
> +	/* Trigger an immediate transmit demand. */
> +	iowrite32(0, ioaddr + CSR1);

In mmio mode it will only be "immediate" if the caller is guaranteed to
read from the device and flush the iowrite ....


