Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261263AbTJMAMJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 20:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261267AbTJMAMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 20:12:09 -0400
Received: from fw.osdl.org ([65.172.181.6]:18837 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261263AbTJMAMH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 20:12:07 -0400
Date: Sun, 12 Oct 2003 17:15:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: Felipe W Damasio <felipewd@terra.com.br>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org,
       Cciss-discuss@lists.sourceforge.net
Subject: Re: [PATCH] release_region in cciss block driver
Message-Id: <20031012171513.7bac1562.akpm@osdl.org>
In-Reply-To: <3F81744E.3080105@terra.com.br>
References: <3F816DE5.8060009@terra.com.br>
	<20031006134225.GA972@suse.de>
	<3F81744E.3080105@terra.com.br>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felipe W Damasio <felipewd@terra.com.br> wrote:
>
> --- linux-2.6.0-test6/drivers/block/cciss.c.orig	2003-10-06 10:18:01.000000000 -0300
>  +++ linux-2.6.0-test6/drivers/block/cciss.c	2003-10-06 10:25:04.000000000 -0300
>  @@ -2185,6 +2185,7 @@
>   		schedule_timeout(HZ / 10); /* wait 100ms */
>   	}
>   	if (scratchpad != CCISS_FIRMWARE_READY) {
>  +		release_io_mem(c);
>   		printk(KERN_WARNING "cciss: Board not ready.  Timed out.\n");
>   		return -1;
>   	}

It seems to me that the driver is already performing this function
in the caller.


static int __devinit cciss_init_one(struct pci_dev *pdev,
	const struct pci_device_id *ent)
{
	...
	if (cciss_pci_init(hba[i], pdev) != 0)
		goto clean1;
	...
clean1:
	release_io_mem(hba[i]);
	free_hba(i);
	return(-1);
}

