Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261241AbVFGCL5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261241AbVFGCL5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 22:11:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261318AbVFGCL5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 22:11:57 -0400
Received: from zproxy.gmail.com ([64.233.162.207]:61011 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261241AbVFGCLj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 22:11:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=N7oGlGNYuoVCPqXWs5iSMnLkrV3VTJAzqWgPDVkG2TP4NSJwuxX/r4RwBJd9Jh/kvFPp6wamW4DItZqjZNBuz1ZAuYGNUjQNMZlVjXQ1RnsgIl5DiWqmaZikQvpYbnBaJgA70OIr9O98ywFH/brbsWE/i1DvwQ0lG3TvBvjBaBA=
Message-ID: <42A50253.9080307@gmail.com>
Date: Tue, 07 Jun 2005 11:11:31 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050402)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: axboe@suse.de, James.Bottomley@steeleye.com, bzolnier@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH Linux 2.6.12-rc5-mm2 07/09] blk: update libata to use
 the new blk_ordered.
References: <20050605055337.6301E65A@htj.dyndns.org> <20050605055337.13444DD8@htj.dyndns.org> <42A2A39B.5020103@pobox.com>
In-Reply-To: <42A2A39B.5020103@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
> 
>> 07_blk_update_libata_to_use_new_ordered.patch
>>
>>     Reflect changes in SCSI midlayer and updated to use the new
>>     ordered request implementation.
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> 
> I would prefer separate patches for:
> 
> * implement support for FUA bit in libata SCSI simulator
> 
> * update libata for your ordered flush changes
> 

  Sure.

> 
> 
>> Index: blk-fixes/drivers/scsi/ahci.c
>> ===================================================================
>> --- blk-fixes.orig/drivers/scsi/ahci.c    2005-06-05 
>> 14:50:11.000000000 +0900
>> +++ blk-fixes/drivers/scsi/ahci.c    2005-06-05 14:53:35.000000000 +0900
>> @@ -203,7 +203,6 @@ static Scsi_Host_Template ahci_sht = {
>>      .dma_boundary        = AHCI_DMA_BOUNDARY,
>>      .slave_configure    = ata_scsi_slave_config,
>>      .bios_param        = ata_std_bios_param,
>> -    .ordered_flush        = 1,
>>  };
>>  
>>  static struct ata_port_operations ahci_ops = {
>> Index: blk-fixes/drivers/scsi/ata_piix.c
>> ===================================================================
>> --- blk-fixes.orig/drivers/scsi/ata_piix.c    2005-06-05 
>> 14:50:11.000000000 +0900
>> +++ blk-fixes/drivers/scsi/ata_piix.c    2005-06-05 14:53:35.000000000 
>> +0900
>> @@ -123,7 +123,6 @@ static Scsi_Host_Template piix_sht = {
>>      .dma_boundary        = ATA_DMA_BOUNDARY,
>>      .slave_configure    = ata_scsi_slave_config,
>>      .bios_param        = ata_std_bios_param,
>> -    .ordered_flush        = 1,
>>  };
>>  
>>  static struct ata_port_operations piix_pata_ops = {
>> Index: blk-fixes/drivers/scsi/sata_nv.c
>> ===================================================================
>> --- blk-fixes.orig/drivers/scsi/sata_nv.c    2005-06-05 
>> 14:50:11.000000000 +0900
>> +++ blk-fixes/drivers/scsi/sata_nv.c    2005-06-05 14:53:35.000000000 
>> +0900
>> @@ -206,7 +206,6 @@ static Scsi_Host_Template nv_sht = {
>>      .dma_boundary        = ATA_DMA_BOUNDARY,
>>      .slave_configure    = ata_scsi_slave_config,
>>      .bios_param        = ata_std_bios_param,
>> -    .ordered_flush        = 1,
>>  };
>>  
>>  static struct ata_port_operations nv_ops = {
>> Index: blk-fixes/drivers/scsi/sata_promise.c
>> ===================================================================
>> --- blk-fixes.orig/drivers/scsi/sata_promise.c    2005-06-05 
>> 14:50:11.000000000 +0900
>> +++ blk-fixes/drivers/scsi/sata_promise.c    2005-06-05 
>> 14:53:35.000000000 +0900
>> @@ -104,7 +104,6 @@ static Scsi_Host_Template pdc_ata_sht =      
>> .dma_boundary        = ATA_DMA_BOUNDARY,
>>      .slave_configure    = ata_scsi_slave_config,
>>      .bios_param        = ata_std_bios_param,
>> -    .ordered_flush        = 1,
>>  };
>>  
>>  static struct ata_port_operations pdc_ata_ops = {
>> Index: blk-fixes/drivers/scsi/sata_sil.c
>> ===================================================================
>> --- blk-fixes.orig/drivers/scsi/sata_sil.c    2005-06-05 
>> 14:50:11.000000000 +0900
>> +++ blk-fixes/drivers/scsi/sata_sil.c    2005-06-05 14:53:35.000000000 
>> +0900
>> @@ -135,7 +135,6 @@ static Scsi_Host_Template sil_sht = {
>>      .dma_boundary        = ATA_DMA_BOUNDARY,
>>      .slave_configure    = ata_scsi_slave_config,
>>      .bios_param        = ata_std_bios_param,
>> -    .ordered_flush        = 1,
>>  };
>>  
>>  static struct ata_port_operations sil_ops = {
>> Index: blk-fixes/drivers/scsi/sata_sis.c
>> ===================================================================
>> --- blk-fixes.orig/drivers/scsi/sata_sis.c    2005-06-05 
>> 14:50:11.000000000 +0900
>> +++ blk-fixes/drivers/scsi/sata_sis.c    2005-06-05 14:53:35.000000000 
>> +0900
>> @@ -90,7 +90,6 @@ static Scsi_Host_Template sis_sht = {
>>      .dma_boundary        = ATA_DMA_BOUNDARY,
>>      .slave_configure    = ata_scsi_slave_config,
>>      .bios_param        = ata_std_bios_param,
>> -    .ordered_flush        = 1,
>>  };
>>  
>>  static struct ata_port_operations sis_ops = {
>> Index: blk-fixes/drivers/scsi/sata_svw.c
>> ===================================================================
>> --- blk-fixes.orig/drivers/scsi/sata_svw.c    2005-06-05 
>> 14:50:11.000000000 +0900
>> +++ blk-fixes/drivers/scsi/sata_svw.c    2005-06-05 14:53:35.000000000 
>> +0900
>> @@ -288,7 +288,6 @@ static Scsi_Host_Template k2_sata_sht =      
>> .proc_info        = k2_sata_proc_info,
>>  #endif
>>      .bios_param        = ata_std_bios_param,
>> -    .ordered_flush        = 1,
>>  };
>>  
>>  
>> Index: blk-fixes/drivers/scsi/sata_sx4.c
>> ===================================================================
>> --- blk-fixes.orig/drivers/scsi/sata_sx4.c    2005-06-05 
>> 14:50:11.000000000 +0900
>> +++ blk-fixes/drivers/scsi/sata_sx4.c    2005-06-05 14:53:35.000000000 
>> +0900
>> @@ -188,7 +188,6 @@ static Scsi_Host_Template pdc_sata_sht =
>>      .dma_boundary        = ATA_DMA_BOUNDARY,
>>      .slave_configure    = ata_scsi_slave_config,
>>      .bios_param        = ata_std_bios_param,
>> -    .ordered_flush        = 1,
>>  };
>>  
>>  static struct ata_port_operations pdc_20621_ops = {
>> Index: blk-fixes/drivers/scsi/sata_uli.c
>> ===================================================================
>> --- blk-fixes.orig/drivers/scsi/sata_uli.c    2005-06-05 
>> 14:50:11.000000000 +0900
>> +++ blk-fixes/drivers/scsi/sata_uli.c    2005-06-05 14:53:35.000000000 
>> +0900
>> @@ -82,7 +82,6 @@ static Scsi_Host_Template uli_sht = {
>>      .dma_boundary        = ATA_DMA_BOUNDARY,
>>      .slave_configure    = ata_scsi_slave_config,
>>      .bios_param        = ata_std_bios_param,
>> -    .ordered_flush        = 1,
>>  };
>>  
>>  static struct ata_port_operations uli_ops = {
>> Index: blk-fixes/drivers/scsi/sata_via.c
>> ===================================================================
>> --- blk-fixes.orig/drivers/scsi/sata_via.c    2005-06-05 
>> 14:50:11.000000000 +0900
>> +++ blk-fixes/drivers/scsi/sata_via.c    2005-06-05 14:53:35.000000000 
>> +0900
>> @@ -102,7 +102,6 @@ static Scsi_Host_Template svia_sht = {
>>      .dma_boundary        = ATA_DMA_BOUNDARY,
>>      .slave_configure    = ata_scsi_slave_config,
>>      .bios_param        = ata_std_bios_param,
>> -    .ordered_flush        = 1,
>>  };
>>  
>>  static struct ata_port_operations svia_sata_ops = {
>> Index: blk-fixes/drivers/scsi/sata_vsc.c
>> ===================================================================
>> --- blk-fixes.orig/drivers/scsi/sata_vsc.c    2005-06-05 
>> 14:50:11.000000000 +0900
>> +++ blk-fixes/drivers/scsi/sata_vsc.c    2005-06-05 14:53:35.000000000 
>> +0900
>> @@ -206,7 +206,6 @@ static Scsi_Host_Template vsc_sata_sht =
>>      .dma_boundary        = ATA_DMA_BOUNDARY,
>>      .slave_configure    = ata_scsi_slave_config,
>>      .bios_param        = ata_std_bios_param,
>> -    .ordered_flush        = 1,
>>  };
>>  
>>  
>> Index: blk-fixes/drivers/scsi/libata-core.c
>> ===================================================================
>> --- blk-fixes.orig/drivers/scsi/libata-core.c    2005-06-05 
>> 14:50:11.000000000 +0900
>> +++ blk-fixes/drivers/scsi/libata-core.c    2005-06-05 
>> 14:53:35.000000000 +0900
>> @@ -510,19 +510,21 @@ void ata_tf_from_fis(u8 *fis, struct ata
>>  }
>>  
>>  /**
>> - *    ata_prot_to_cmd - determine which read/write opcodes to use
>> + *    ata_prot_to_cmd - determine which read/write/fua-write opcodes 
>> to use
>>   *    @protocol: ATA_PROT_xxx taskfile protocol
>>   *    @lba48: true is lba48 is present
>>   *
>> - *    Given necessary input, determine which read/write commands
>> - *    to use to transfer data.
>> + *    Given necessary input, determine which read/write/fua-write
>> + *    commands to use to transfer data.  Note that we only support
>> + *    fua-writes on DMA LBA48 protocol.  In other cases, we simply
>> + *    return 0 which is NOP.
>>   *
>>   *    LOCKING:
>>   *    None.
>>   */
>>  static int ata_prot_to_cmd(int protocol, int lba48)
>>  {
>> -    int rcmd = 0, wcmd = 0;
>> +    int rcmd = 0, wcmd = 0, wfua = 0;
>>  
>>      switch (protocol) {
>>      case ATA_PROT_PIO:
>> @@ -539,6 +541,7 @@ static int ata_prot_to_cmd(int protocol,
>>          if (lba48) {
>>              rcmd = ATA_CMD_READ_EXT;
>>              wcmd = ATA_CMD_WRITE_EXT;
>> +            wfua = ATA_CMD_WRITE_FUA_EXT;
>>          } else {
>>              rcmd = ATA_CMD_READ;
>>              wcmd = ATA_CMD_WRITE;
>> @@ -549,7 +552,7 @@ static int ata_prot_to_cmd(int protocol,
>>          return -1;
>>      }
>>  
>> -    return rcmd | (wcmd << 8);
>> +    return rcmd | (wcmd << 8) | (wfua << 16);
>>  }
>>  
>>  /**
>> @@ -582,6 +585,7 @@ static void ata_dev_set_protocol(struct  
>>      dev->read_cmd = cmd & 0xff;
>>      dev->write_cmd = (cmd >> 8) & 0xff;
>> +    dev->write_fua_cmd = (cmd >> 16) & 0xff;
>>  }
>>  
>>  static const char * xfer_mode_str[] = {
>> Index: blk-fixes/drivers/scsi/libata-scsi.c
>> ===================================================================
>> --- blk-fixes.orig/drivers/scsi/libata-scsi.c    2005-06-05 
>> 14:50:11.000000000 +0900
>> +++ blk-fixes/drivers/scsi/libata-scsi.c    2005-06-05 
>> 14:53:35.000000000 +0900
>> @@ -569,6 +569,7 @@ static unsigned int ata_scsi_rw_xlat(str
>>      struct ata_device *dev = qc->dev;
>>      unsigned int lba   = tf->flags & ATA_TFLAG_LBA;
>>      unsigned int lba48 = tf->flags & ATA_TFLAG_LBA48;
>> +    int fua = scsicmd[1] & 0x8;
>>      u64 block = 0;
>>      u32 n_block = 0;
>>  
>> @@ -577,9 +578,26 @@ static unsigned int ata_scsi_rw_xlat(str
>>  
>>      if (scsicmd[0] == READ_10 || scsicmd[0] == READ_6 ||
>>          scsicmd[0] == READ_16) {
>> +        if (fua) {
>> +            printk(KERN_WARNING
>> +                   "ata%u(%u): WARNING: FUA READ unsupported\n",
>> +                   qc->ap->id, qc->dev->devno);
>> +            return 1;
>> +        }
>>          tf->command = qc->dev->read_cmd;
>>      } else {
>> -        tf->command = qc->dev->write_cmd;
>> +        if (fua) {
>> +            if (qc->dev->write_fua_cmd == 0 || !lba48) {
>> +                printk(KERN_WARNING
>> +                       "ata%u(%u): WARNING: FUA WRITE "
>> +                       "unsupported with the current "
>> +                       "protocol/addressing\n",
>> +                       qc->ap->id, qc->dev->devno);
>> +                return 1;
>> +            }
>> +            tf->command = qc->dev->write_fua_cmd;
>> +        } else
>> +            tf->command = qc->dev->write_cmd;
>>          tf->flags |= ATA_TFLAG_WRITE;
>>      }
>>  
> 
> 
> this all seems fine.
> 
> 
>> @@ -1205,10 +1223,12 @@ unsigned int ata_scsiop_mode_sense(struc
>>      if (six_byte) {
>>          output_len--;
>>          rbuf[0] = output_len;
>> +        rbuf[2] |= ata_id_has_fua(args->id) ? 0x10 : 0;
>>      } else {
>>          output_len -= 2;
>>          rbuf[0] = output_len >> 8;
>>          rbuf[1] = output_len;
>> +        rbuf[3] |= ata_id_has_fua(args->id) ? 0x10 : 0;
>>      }
> 
> 
> I wonder what a SCSI person thinks about this.  Its defined as 'DPO and 
> FUA' not just 'FUA'.
> 

  As DPO is sort of optimization flag, it doesn't make user-visible 
differences other than in performance.  I think we can add DPO check 
when translating commands and abort it w/ ILLEGAL_REQUEST (thus we'll be 
lying about DPO part of the flag but not be lying that DPO operation 
succeeds.)  But it doesn't make any user-visible difference and we're 
not using DPO in anywhere right now, so I think it's an overkill.

  Any better ideas?  Maybe adding another flag to scsi_device structure 
like ->fua_supported which can be adjusted by slave_config?

> Also, a bit of style:  please use "1 << n" for bit constants in libata.
> 
>     Jeff
> 

  Sure.

  Thank you.

-- 
tejun
