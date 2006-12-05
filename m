Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968355AbWLEE6P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968355AbWLEE6P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 23:58:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968362AbWLEE6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 23:58:15 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:42392 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S968355AbWLEE6O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 23:58:14 -0500
Message-ID: <4574FC61.30804@garzik.org>
Date: Mon, 04 Dec 2006 23:58:09 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Martin Bligh <mbligh@google.com>
CC: Andrew Morton <akpm@osdl.org>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix up compiler warnings in megaraid driver
References: <4574D8EB.1060104@google.com>
In-Reply-To: <4574D8EB.1060104@google.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Bligh wrote:
> Fix up compiler warnings in megaraid driver
> 
> Signed-off-by: Martin J. Bligh <mbligh@google.com>
> 
> 
> ------------------------------------------------------------------------
> 
> diff -aurpN -X /home/mbligh/.diff.exclude linux-2.6.19/drivers/scsi/megaraid.c 2.6.19-megaraid/drivers/scsi/megaraid.c
> --- linux-2.6.19/drivers/scsi/megaraid.c	2006-12-04 17:52:00.000000000 -0800
> +++ 2.6.19-megaraid/drivers/scsi/megaraid.c	2006-12-04 18:24:03.000000000 -0800
> @@ -73,10 +73,14 @@ static unsigned short int max_mbox_busy_
>  module_param(max_mbox_busy_wait, ushort, 0);
>  MODULE_PARM_DESC(max_mbox_busy_wait, "Maximum wait for mailbox in microseconds if busy (default=MBOX_BUSY_WAIT=10)");
>  
> -#define RDINDOOR(adapter)		readl((adapter)->base + 0x20)
> -#define RDOUTDOOR(adapter)		readl((adapter)->base + 0x2C)
> -#define WRINDOOR(adapter,value)		writel(value, (adapter)->base + 0x20)
> -#define WROUTDOOR(adapter,value)	writel(value, (adapter)->base + 0x2C)
> +#define RDINDOOR(adapter)		readl((volatile void __iomem *) \
> +							(adapter)->base + 0x20)
> +#define RDOUTDOOR(adapter)		readl((volatile void __iomem *) \
> +							(adapter)->base + 0x2C)
> +#define WRINDOOR(adapter,value)		writel(value, (volatile void __iomem *)\
> +							(adapter)->base + 0x20)
> +#define WROUTDOOR(adapter,value)	writel(value, (volatile void __iomem *)\
> +							(adapter)->base + 0x2C)
>  
>  /*
>   * Global variables

I posted a better fix just yesterday...

	Jeff


