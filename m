Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261261AbVEPEG4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261261AbVEPEG4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 00:06:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261266AbVEPEG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 00:06:56 -0400
Received: from mail.dvmed.net ([216.237.124.58]:16794 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261261AbVEPEGy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 00:06:54 -0400
Message-ID: <42881C58.40001@pobox.com>
Date: Mon, 16 May 2005 00:06:48 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: akpm@osdl.org
CC: T-Bone@parisc-linux.org, grundler@parisc-linux.org,
       varenet@parisc-linux.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       Netdev <netdev@oss.sgi.com>
Subject: Re: patch tulip-natsemi-dp83840a-phy-fix.patch added to -mm tree
References: <200505101955.j4AJtX9x032464@shell0.pdx.osdl.net>
In-Reply-To: <200505101955.j4AJtX9x032464@shell0.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

akpm@osdl.org wrote:
> +
> +					/* flush posted writes */
> +					ioread32(ioaddr + CSR15);
> +
> +					/* Sect 3.10.3 in DP83840A.pdf (p39) */
> +					udelay(500);
> +
> +					/* Section 4.2 in DP83840A.pdf (p43) */
> +					/* and IEEE 802.3 "22.2.4.1.1 Reset" */
> +					while (timeout-- &&
> +						(tulip_mdio_read (dev, phy_num, MII_BMCR) & BMCR_RESET))
> +						udelay(100);


Note that while the patch creates the correct behavior, the delays above 
occur inside spin_lock_irqsave() and/or timer context.

I have been to get HP to fix this patch's delay problem for -years-.

	Jeff


