Return-Path: <linux-kernel-owner+w=401wt.eu-S1751712AbXANXKn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751712AbXANXKn (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 18:10:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751714AbXANXKn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 18:10:43 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:33717 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751709AbXANXKm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 18:10:42 -0500
Date: Sun, 14 Jan 2007 23:22:19 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Christoph Biedl <linux-kernel.bfrz@manchmal.in-ulm.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: it821x trouble since 2.6.18
Message-ID: <20070114232219.3038987e@localhost.localdomain>
In-Reply-To: <1168811634@msgid.manchmal.in-ulm.de>
References: <1168811634@msgid.manchmal.in-ulm.de>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.10.4; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 2. Trying to understand what has happened I found the main difference
> is not in the driver but in ide-dma.c:
> 
> --- linux-2.6.17.14/drivers/ide/ide-dma.c   2006-06-18 01:49:35.000000000 +0000
> +++ linux-2.6.18.6/drivers/ide/ide-dma.c    2006-09-20 03:42:06.000000000 +0000
> @@ -752,7 +750,7 @@
>                         goto bug_dma_off;
>                 printk(", DMA");
>         } else if (id->field_valid & 1) {
> -               printk(", BUG");
> +               goto bug_dma_off;
>         }
>         return;
>  bug_dma_off:
> 
> 
> and reverting that change returns the old transfer rates. But that is
> probably not a good idea.

It should be just fine. 

> So I tried this again:

This is complete bogus. You simply poked random incorrect registers and
happened not to crash the chip, or confuse it, and since you have the
IT821x bios enabled it happened to have roughly valid configuration.

> and disabled CONFIG_BLK_DEV_IT821X - and now the disk is even faster
> than before:

For all the wrong reasons I would add.

