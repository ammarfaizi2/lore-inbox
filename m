Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261796AbVE0EmK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261796AbVE0EmK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 00:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261766AbVE0EmK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 00:42:10 -0400
Received: from mail.dvmed.net ([216.237.124.58]:64220 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261724AbVE0EmC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 00:42:02 -0400
Message-ID: <4296A517.3020502@pobox.com>
Date: Fri, 27 May 2005 00:41:59 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Playing with SATA NCQ
References: <20050526140058.GR1419@suse.de>
In-Reply-To: <20050526140058.GR1419@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> @@ -189,7 +194,7 @@
>  	.ioctl			= ata_scsi_ioctl,
>  	.queuecommand		= ata_scsi_queuecmd,
>  	.eh_strategy_handler	= ata_scsi_error,
> -	.can_queue		= ATA_DEF_QUEUE,
> +	.can_queue		= ATA_MAX_QUEUE,
>  	.this_id		= ATA_SHT_THIS_ID,
>  	.sg_tablesize		= AHCI_MAX_SG,
>  	.max_sectors		= ATA_MAX_SECTORS,
> @@ -200,7 +205,7 @@
>  	.dma_boundary		= AHCI_DMA_BOUNDARY,
>  	.slave_configure	= ata_scsi_slave_config,
>  	.bios_param		= ata_std_bios_param,
> -	.ordered_flush		= 1,
> +	.ordered_flush		= 0, /* conflicts with NCQ for now */
>  };
>  
>  static struct ata_port_operations ahci_ops = {

Also, you'll probably want to implement ata_scsi_change_queue_depth, and 
reference it in ahci.c (and other NCQ-capable drivers).

	Jeff


