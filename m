Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261970AbVBLB76@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261970AbVBLB76 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 20:59:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262382AbVBLB75
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 20:59:57 -0500
Received: from siaag1ae.compuserve.com ([149.174.40.7]:2184 "EHLO
	siaag1ae.compuserve.com") by vger.kernel.org with ESMTP
	id S261970AbVBLB7V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 20:59:21 -0500
Date: Fri, 11 Feb 2005 20:55:18 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH 2.6.11-rc2 02/04] ide: __ide_do_rw_disk()
  rewritten ide_write_taskfil
To: Tejun Heo <htejun@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-ide <linux-ide@vger.kernel.org>
Message-ID: <200502112058_MC3-1-95CC-5FF2@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  6 Feb 2005 at 20:26:55 +0900, Tejun Heo wrote:

> +     if (drive->using_dma &&
> +         !(hwif->no_lba48_dma && block + rq->nr_sectors > 1ULL << 28)) {
> +             /* DMA */
> +             if (hwif->dma_setup(drive))
> +                     goto fallback_to_pio;
> +             if (rq_data_dir(rq) == READ) {
> +                     command = lba48 ? WIN_READDMA_EXT : WIN_READDMA;
> +                     if (drive->vdma)
> +                             command = lba48 ? WIN_READ_EXT : WIN_READ;
> +             } else {
> +                     command = lba48 ? WIN_WRITEDMA_EXT : WIN_WRITEDMA;
> +                     if (drive->vdma)
> +                             command = lba48 ? WIN_WRITE_EXT : WIN_WRITE;
>               }
> -             /* fallback to PIO */
> -             ide_init_sg_cmd(drive, rq);
> +             hwif->dma_exec_cmd(drive, command);
> +             hwif->dma_start(drive);
> +             return ide_started;
>       }


  Should that be "block + rq->nr_sectors >= 1ULL << 28"?

  Legal sector numbers for LBA28 range from 0 thru (1 << 28 - 1).

  LBA28 _capacities_ range from 1 thru (1 << 28) sectors.

  And why is it using 1ULL some places and 1UL in others in the ide driver?

--
Chuck
