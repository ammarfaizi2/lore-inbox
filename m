Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263162AbUE2Q75@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263162AbUE2Q75 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 12:59:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265233AbUE2Q75
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 12:59:57 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27344 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263162AbUE2Q7z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 12:59:55 -0400
Message-ID: <40B8C17B.307@pobox.com>
Date: Sat, 29 May 2004 12:59:39 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Brad Campbell <brad@wasp.net.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: libata regression 2.6.6-rc1 -> 2.6.6-rc2 located
References: <40B8BF05.9020703@wasp.net.au>
In-Reply-To: <40B8BF05.9020703@wasp.net.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brad Campbell wrote:
> diff -urN linux-2.6.5-a/drivers/scsi/sata_promise.c 
> linux-2.6.5-b/drivers/scsi/sata_promise.c
> --- linux-2.6.5-a/drivers/scsi/sata_promise.c   2004-05-29 
> 19:53:40.000000000 +0400
> +++ linux-2.6.5-b/drivers/scsi/sata_promise.c   2004-05-29 
> 19:41:47.000000000 +0400
> @@ -1180,14 +1180,14 @@
> 
>  static void pdc_tf_load_mmio(struct ata_port *ap, struct ata_taskfile *tf)
>  {
> -       if (tf->protocol != ATA_PROT_DMA)
> +       if (tf->protocol == ATA_PROT_PIO)
>                 ata_tf_load_mmio(ap, tf);
>  }
> 
> 
>  static void pdc_exec_command_mmio(struct ata_port *ap, struct 
> ata_taskfile *tf)
>  {
> -       if (tf->protocol != ATA_PROT_DMA)
> +       if (tf->protocol == ATA_PROT_PIO)
>                 ata_exec_command_mmio(ap, tf);
>  }

Great work, thanks.

Short term, I'll revert this patch.  The change was more of a 
"preparation for the future", and not strictly required.

I think I understand why, but I'll need to ponder a bit more on the long 
term solution.

	Jeff




