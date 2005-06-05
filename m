Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261488AbVFEHDV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261488AbVFEHDV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 03:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261489AbVFEHDV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 03:03:21 -0400
Received: from mail.dvmed.net ([216.237.124.58]:45764 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261488AbVFEHC7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 03:02:59 -0400
Message-ID: <42A2A39B.5020103@pobox.com>
Date: Sun, 05 Jun 2005 03:02:51 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: axboe@suse.de, James.Bottomley@steeleye.com, bzolnier@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH Linux 2.6.12-rc5-mm2 07/09] blk: update libata to use
 the new blk_ordered.
References: <20050605055337.6301E65A@htj.dyndns.org> <20050605055337.13444DD8@htj.dyndns.org>
In-Reply-To: <20050605055337.13444DD8@htj.dyndns.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:
> 07_blk_update_libata_to_use_new_ordered.patch
> 
> 	Reflect changes in SCSI midlayer and updated to use the new
> 	ordered request implementation.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

I would prefer separate patches for:

* implement support for FUA bit in libata SCSI simulator

* update libata for your ordered flush changes



> Index: blk-fixes/drivers/scsi/ahci.c
> ===================================================================
> --- blk-fixes.orig/drivers/scsi/ahci.c	2005-06-05 14:50:11.000000000 +0900
> +++ blk-fixes/drivers/scsi/ahci.c	2005-06-05 14:53:35.000000000 +0900
> @@ -203,7 +203,6 @@ static Scsi_Host_Template ahci_sht = {
>  	.dma_boundary		= AHCI_DMA_BOUNDARY,
>  	.slave_configure	= ata_scsi_slave_config,
>  	.bios_param		= ata_std_bios_param,
> -	.ordered_flush		= 1,
>  };
>  
>  static struct ata_port_operations ahci_ops = {
> Index: blk-fixes/drivers/scsi/ata_piix.c
> ===================================================================
> --- blk-fixes.orig/drivers/scsi/ata_piix.c	2005-06-05 14:50:11.000000000 +0900
> +++ blk-fixes/drivers/scsi/ata_piix.c	2005-06-05 14:53:35.000000000 +0900
> @@ -123,7 +123,6 @@ static Scsi_Host_Template piix_sht = {
>  	.dma_boundary		= ATA_DMA_BOUNDARY,
>  	.slave_configure	= ata_scsi_slave_config,
>  	.bios_param		= ata_std_bios_param,
> -	.ordered_flush		= 1,
>  };
>  
>  static struct ata_port_operations piix_pata_ops = {
> Index: blk-fixes/drivers/scsi/sata_nv.c
> ===================================================================
> --- blk-fixes.orig/drivers/scsi/sata_nv.c	2005-06-05 14:50:11.000000000 +0900
> +++ blk-fixes/drivers/scsi/sata_nv.c	2005-06-05 14:53:35.000000000 +0900
> @@ -206,7 +206,6 @@ static Scsi_Host_Template nv_sht = {
>  	.dma_boundary		= ATA_DMA_BOUNDARY,
>  	.slave_configure	= ata_scsi_slave_config,
>  	.bios_param		= ata_std_bios_param,
> -	.ordered_flush		= 1,
>  };
>  
>  static struct ata_port_operations nv_ops = {
> Index: blk-fixes/drivers/scsi/sata_promise.c
> ===================================================================
> --- blk-fixes.orig/drivers/scsi/sata_promise.c	2005-06-05 14:50:11.000000000 +0900
> +++ blk-fixes/drivers/scsi/sata_promise.c	2005-06-05 14:53:35.000000000 +0900
> @@ -104,7 +104,6 @@ static Scsi_Host_Template pdc_ata_sht = 
>  	.dma_boundary		= ATA_DMA_BOUNDARY,
>  	.slave_configure	= ata_scsi_slave_config,
>  	.bios_param		= ata_std_bios_param,
> -	.ordered_flush		= 1,
>  };
>  
>  static struct ata_port_operations pdc_ata_ops = {
> Index: blk-fixes/drivers/scsi/sata_sil.c
> ===================================================================
> --- blk-fixes.orig/drivers/scsi/sata_sil.c	2005-06-05 14:50:11.000000000 +0900
> +++ blk-fixes/drivers/scsi/sata_sil.c	2005-06-05 14:53:35.000000000 +0900
> @@ -135,7 +135,6 @@ static Scsi_Host_Template sil_sht = {
>  	.dma_boundary		= ATA_DMA_BOUNDARY,
>  	.slave_configure	= ata_scsi_slave_config,
>  	.bios_param		= ata_std_bios_param,
> -	.ordered_flush		= 1,
>  };
>  
>  static struct ata_port_operations sil_ops = {
> Index: blk-fixes/drivers/scsi/sata_sis.c
> ===================================================================
> --- blk-fixes.orig/drivers/scsi/sata_sis.c	2005-06-05 14:50:11.000000000 +0900
> +++ blk-fixes/drivers/scsi/sata_sis.c	2005-06-05 14:53:35.000000000 +0900
> @@ -90,7 +90,6 @@ static Scsi_Host_Template sis_sht = {
>  	.dma_boundary		= ATA_DMA_BOUNDARY,
>  	.slave_configure	= ata_scsi_slave_config,
>  	.bios_param		= ata_std_bios_param,
> -	.ordered_flush		= 1,
>  };
>  
>  static struct ata_port_operations sis_ops = {
> Index: blk-fixes/drivers/scsi/sata_svw.c
> ===================================================================
> --- blk-fixes.orig/drivers/scsi/sata_svw.c	2005-06-05 14:50:11.000000000 +0900
> +++ blk-fixes/drivers/scsi/sata_svw.c	2005-06-05 14:53:35.000000000 +0900
> @@ -288,7 +288,6 @@ static Scsi_Host_Template k2_sata_sht = 
>  	.proc_info		= k2_sata_proc_info,
>  #endif
>  	.bios_param		= ata_std_bios_param,
> -	.ordered_flush		= 1,
>  };
>  
>  
> Index: blk-fixes/drivers/scsi/sata_sx4.c
> ===================================================================
> --- blk-fixes.orig/drivers/scsi/sata_sx4.c	2005-06-05 14:50:11.000000000 +0900
> +++ blk-fixes/drivers/scsi/sata_sx4.c	2005-06-05 14:53:35.000000000 +0900
> @@ -188,7 +188,6 @@ static Scsi_Host_Template pdc_sata_sht =
>  	.dma_boundary		= ATA_DMA_BOUNDARY,
>  	.slave_configure	= ata_scsi_slave_config,
>  	.bios_param		= ata_std_bios_param,
> -	.ordered_flush		= 1,
>  };
>  
>  static struct ata_port_operations pdc_20621_ops = {
> Index: blk-fixes/drivers/scsi/sata_uli.c
> ===================================================================
> --- blk-fixes.orig/drivers/scsi/sata_uli.c	2005-06-05 14:50:11.000000000 +0900
> +++ blk-fixes/drivers/scsi/sata_uli.c	2005-06-05 14:53:35.000000000 +0900
> @@ -82,7 +82,6 @@ static Scsi_Host_Template uli_sht = {
>  	.dma_boundary		= ATA_DMA_BOUNDARY,
>  	.slave_configure	= ata_scsi_slave_config,
>  	.bios_param		= ata_std_bios_param,
> -	.ordered_flush		= 1,
>  };
>  
>  static struct ata_port_operations uli_ops = {
> Index: blk-fixes/drivers/scsi/sata_via.c
> ===================================================================
> --- blk-fixes.orig/drivers/scsi/sata_via.c	2005-06-05 14:50:11.000000000 +0900
> +++ blk-fixes/drivers/scsi/sata_via.c	2005-06-05 14:53:35.000000000 +0900
> @@ -102,7 +102,6 @@ static Scsi_Host_Template svia_sht = {
>  	.dma_boundary		= ATA_DMA_BOUNDARY,
>  	.slave_configure	= ata_scsi_slave_config,
>  	.bios_param		= ata_std_bios_param,
> -	.ordered_flush		= 1,
>  };
>  
>  static struct ata_port_operations svia_sata_ops = {
> Index: blk-fixes/drivers/scsi/sata_vsc.c
> ===================================================================
> --- blk-fixes.orig/drivers/scsi/sata_vsc.c	2005-06-05 14:50:11.000000000 +0900
> +++ blk-fixes/drivers/scsi/sata_vsc.c	2005-06-05 14:53:35.000000000 +0900
> @@ -206,7 +206,6 @@ static Scsi_Host_Template vsc_sata_sht =
>  	.dma_boundary		= ATA_DMA_BOUNDARY,
>  	.slave_configure	= ata_scsi_slave_config,
>  	.bios_param		= ata_std_bios_param,
> -	.ordered_flush		= 1,
>  };
>  
>  
> Index: blk-fixes/drivers/scsi/libata-core.c
> ===================================================================
> --- blk-fixes.orig/drivers/scsi/libata-core.c	2005-06-05 14:50:11.000000000 +0900
> +++ blk-fixes/drivers/scsi/libata-core.c	2005-06-05 14:53:35.000000000 +0900
> @@ -510,19 +510,21 @@ void ata_tf_from_fis(u8 *fis, struct ata
>  }
>  
>  /**
> - *	ata_prot_to_cmd - determine which read/write opcodes to use
> + *	ata_prot_to_cmd - determine which read/write/fua-write opcodes to use
>   *	@protocol: ATA_PROT_xxx taskfile protocol
>   *	@lba48: true is lba48 is present
>   *
> - *	Given necessary input, determine which read/write commands
> - *	to use to transfer data.
> + *	Given necessary input, determine which read/write/fua-write
> + *	commands to use to transfer data.  Note that we only support
> + *	fua-writes on DMA LBA48 protocol.  In other cases, we simply
> + *	return 0 which is NOP.
>   *
>   *	LOCKING:
>   *	None.
>   */
>  static int ata_prot_to_cmd(int protocol, int lba48)
>  {
> -	int rcmd = 0, wcmd = 0;
> +	int rcmd = 0, wcmd = 0, wfua = 0;
>  
>  	switch (protocol) {
>  	case ATA_PROT_PIO:
> @@ -539,6 +541,7 @@ static int ata_prot_to_cmd(int protocol,
>  		if (lba48) {
>  			rcmd = ATA_CMD_READ_EXT;
>  			wcmd = ATA_CMD_WRITE_EXT;
> +			wfua = ATA_CMD_WRITE_FUA_EXT;
>  		} else {
>  			rcmd = ATA_CMD_READ;
>  			wcmd = ATA_CMD_WRITE;
> @@ -549,7 +552,7 @@ static int ata_prot_to_cmd(int protocol,
>  		return -1;
>  	}
>  
> -	return rcmd | (wcmd << 8);
> +	return rcmd | (wcmd << 8) | (wfua << 16);
>  }
>  
>  /**
> @@ -582,6 +585,7 @@ static void ata_dev_set_protocol(struct 
>  
>  	dev->read_cmd = cmd & 0xff;
>  	dev->write_cmd = (cmd >> 8) & 0xff;
> +	dev->write_fua_cmd = (cmd >> 16) & 0xff;
>  }
>  
>  static const char * xfer_mode_str[] = {
> Index: blk-fixes/drivers/scsi/libata-scsi.c
> ===================================================================
> --- blk-fixes.orig/drivers/scsi/libata-scsi.c	2005-06-05 14:50:11.000000000 +0900
> +++ blk-fixes/drivers/scsi/libata-scsi.c	2005-06-05 14:53:35.000000000 +0900
> @@ -569,6 +569,7 @@ static unsigned int ata_scsi_rw_xlat(str
>  	struct ata_device *dev = qc->dev;
>  	unsigned int lba   = tf->flags & ATA_TFLAG_LBA;
>  	unsigned int lba48 = tf->flags & ATA_TFLAG_LBA48;
> +	int fua = scsicmd[1] & 0x8;
>  	u64 block = 0;
>  	u32 n_block = 0;
>  
> @@ -577,9 +578,26 @@ static unsigned int ata_scsi_rw_xlat(str
>  
>  	if (scsicmd[0] == READ_10 || scsicmd[0] == READ_6 ||
>  	    scsicmd[0] == READ_16) {
> +		if (fua) {
> +			printk(KERN_WARNING
> +			       "ata%u(%u): WARNING: FUA READ unsupported\n",
> +			       qc->ap->id, qc->dev->devno);
> +			return 1;
> +		}
>  		tf->command = qc->dev->read_cmd;
>  	} else {
> -		tf->command = qc->dev->write_cmd;
> +		if (fua) {
> +			if (qc->dev->write_fua_cmd == 0 || !lba48) {
> +				printk(KERN_WARNING
> +				       "ata%u(%u): WARNING: FUA WRITE "
> +				       "unsupported with the current "
> +				       "protocol/addressing\n",
> +				       qc->ap->id, qc->dev->devno);
> +				return 1;
> +			}
> +			tf->command = qc->dev->write_fua_cmd;
> +		} else
> +			tf->command = qc->dev->write_cmd;
>  		tf->flags |= ATA_TFLAG_WRITE;
>  	}
>  

this all seems fine.


> @@ -1205,10 +1223,12 @@ unsigned int ata_scsiop_mode_sense(struc
>  	if (six_byte) {
>  		output_len--;
>  		rbuf[0] = output_len;
> +		rbuf[2] |= ata_id_has_fua(args->id) ? 0x10 : 0;
>  	} else {
>  		output_len -= 2;
>  		rbuf[0] = output_len >> 8;
>  		rbuf[1] = output_len;
> +		rbuf[3] |= ata_id_has_fua(args->id) ? 0x10 : 0;
>  	}

I wonder what a SCSI person thinks about this.  Its defined as 'DPO and 
FUA' not just 'FUA'.

Also, a bit of style:  please use "1 << n" for bit constants in libata.

	Jeff


