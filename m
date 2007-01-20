Return-Path: <linux-kernel-owner+w=401wt.eu-S965388AbXATUq1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965388AbXATUq1 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 15:46:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965386AbXATUq1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 15:46:27 -0500
Received: from homer.mvista.com ([63.81.120.155]:23912 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S965384AbXATUq0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 15:46:26 -0500
Message-ID: <45B27F9A.9070001@ru.mvista.com>
Date: Sat, 20 Jan 2007 23:46:18 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/15] ide: make ide_hwif_t.ide_dma_host_on void
References: <20070119003058.14846.43637.sendpatchset@localhost.localdomain> <20070119003220.14846.14258.sendpatchset@localhost.localdomain>
In-Reply-To: <20070119003220.14846.14258.sendpatchset@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello again. :-)

Bartlomiej Zolnierkiewicz wrote:

> [PATCH] ide: make ide_hwif_t.ide_dma_host_on void

> * since ide_hwif_t.ide_dma_host_on is called either when drive->using_dma == 1
>   or when return value is discarded make it void, also drop "ide_" prefix
> * make __ide_dma_host_on() void and drop "__" prefix

    Below are some nits which also apply to the previous patch...

> Index: b/drivers/ide/pci/atiixp.c
> ===================================================================
> --- a/drivers/ide/pci/atiixp.c
> +++ b/drivers/ide/pci/atiixp.c
> @@ -101,7 +101,7 @@ static u8 atiixp_dma_2_pio(u8 xfer_rate)
>  	}
>  }
>  
> -static int atiixp_ide_dma_host_on(ide_drive_t *drive)
> +static void atiixp_ide_dma_host_on(ide_drive_t *drive)
>  {

    Would seem logical to get rid of ide_ in this function's name also...

>  	struct pci_dev *dev = drive->hwif->pci_dev;
>  	unsigned long flags;
[...]
> Index: b/drivers/ide/pci/sgiioc4.c
> ===================================================================
> --- a/drivers/ide/pci/sgiioc4.c
> +++ b/drivers/ide/pci/sgiioc4.c
[...]
> @@ -307,13 +307,8 @@ sgiioc4_ide_dma_test_irq(ide_drive_t * d
>  	return sgiioc4_checkirq(HWIF(drive));
>  }
>  
> -static int
> -sgiioc4_ide_dma_host_on(ide_drive_t * drive)
> +static void sgiioc4_ide_dma_host_on(ide_drive_t * drive)

    Same comment here...

>  {
> -	if (drive->using_dma)
> -		return 0;
> -
> -	return 1;
>  }
>  
>  static void sgiioc4_ide_dma_host_off(ide_drive_t * drive)
> @@ -610,7 +605,7 @@ ide_init_sgiioc4(ide_hwif_t * hwif)
>  	hwif->ide_dma_on = &sgiioc4_ide_dma_on;
>  	hwif->dma_off_quietly = &sgiioc4_ide_dma_off_quietly;
>  	hwif->ide_dma_test_irq = &sgiioc4_ide_dma_test_irq;
> -	hwif->ide_dma_host_on = &sgiioc4_ide_dma_host_on;
> +	hwif->dma_host_on = &sgiioc4_ide_dma_host_on;
>  	hwif->dma_host_off = &sgiioc4_ide_dma_host_off;
>  	hwif->ide_dma_lostirq = &sgiioc4_ide_dma_lostirq;
>  	hwif->ide_dma_timeout = &__ide_dma_timeout;

    Unrelated note: not sure why this default value needs explicit assignemnt...

MBR, Sergei
