Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751326AbWDTGu6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326AbWDTGu6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 02:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbWDTGu5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 02:50:57 -0400
Received: from cpe-66-66-109-154.rochester.res.rr.com ([66.66.109.154]:42685
	"EHLO death.krwtech.com") by vger.kernel.org with ESMTP
	id S1751314AbWDTGu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 02:50:56 -0400
Date: Thu, 20 Apr 2006 02:50:53 -0400 (EDT)
From: Ken Witherow <phantoml@rochester.rr.com>
X-X-Sender: ken@death
Reply-To: Ken Witherow <ken@krwtech.com>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Advansys SCSI driver and 2.6.16
In-Reply-To: <20060419224202.3e2f99f5.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0604200242410.3134@death>
References: <Pine.LNX.4.64.0604191444200.1841@death> <20060419163247.6986a87c.akpm@osdl.org>
 <20060419224202.3e2f99f5.akpm@osdl.org>
Organization: KRW Technologies
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Apr 2006, Andrew Morton wrote:

> Andrew Morton <akpm@osdl.org> wrote:
>>
>> There have been no changes in the advansys driver since November 2005, and
>>  nothing substantial in over a year.
>
> The advansys driver has been disabled for two years - since 2.6.8:
>
>> ChangeSet@1.497.4282.43, 2004-06-26 10:50:12-05:00, jejb@mulgrave.(none)
>>   advansys: add warning and convert #includes
>>
>>   The DMA conversion of the advansys driver is still
>>   broken.  Add a #warning to the driver and a comment
>>   above it explaining what needs to be done.
>>
>>   Mark the driver as BROKEN because of the warning
>>
>>   Also remove the #include "scsi.h"
>>
>>   Signed-off-by: James Bottomley <James.Bottomley@SteelEye.com>
>>
>
> So I don't know how you managed to get it to build in 2.6.15.
>
> You can reenable it with:
>
> --- devel/drivers/scsi/Kconfig~a	2006-04-19 22:39:51.000000000 -0700
> +++ devel-akpm/drivers/scsi/Kconfig	2006-04-19 22:40:00.000000000 -0700
> @@ -453,7 +453,7 @@ config SCSI_DPT_I2O
>
> config SCSI_ADVANSYS
> 	tristate "AdvanSys SCSI support"
> -	depends on (ISA || EISA || PCI) && SCSI && BROKEN
> +	depends on (ISA || EISA || PCI) && SCSI
> 	help
> 	  This is a driver for all SCSI host adapters manufactured by
> 	  AdvanSys. It is documented in the kernel source in
> _
>
> and it does compile.   Does it actually work?


[root@death ~]# cat /proc/version
Linux version 2.6.16 (ken@death.krwtech.com) (gcc version 4.1.0) #20 SMP PREEMPT Thu Apr 20 02:30:28 EDT 2006

[root@death ~]# cat /proc/scsi/advansys/0
AdvanSys SCSI 3.3K: PCI Ultra: IO 0x1800-0x180F, IRQ 0x10

Device Information for AdvanSys SCSI Host 0:
Target IDs Detected: 5, 7, (7=Host Adapter)

EEPROM Settings for AdvanSys SCSI Host 0:
  Serial Number: AE54C713B960
  Host SCSI ID: 7, Host Queue Size: 16, Device Queue Size: 8
  cntl 0x7ff7, no_scam 0x0
  Target ID:            0 1 2 3 4 5 6 7
  Disconnects:          Y Y Y N Y Y Y Y
  Command Queuing:      N N N N N N N N
  Start Motor:          Y Y Y Y Y Y Y Y
  Synchronous Transfer: Y Y Y Y Y Y Y Y

Linux Driver Configuration and Information for AdvanSys SCSI Host 0:
  host_busy 0, last_reset 0, max_id 8, max_lun 8, max_channel 0
  unique_id 0, can_queue 16, this_id 7, sg_tablesize 50, cmd_per_lun 1
  unchecked_isa_dma 0, use_clustering 1
  flags 0x8, last_reset 0x0, jiffies 0x5c14, asc_n_io_port 0x10
  io_port 0x1800, n_io_port 0x10

Linux Driver Statistics for AdvanSys SCSI Host 0:
  queuecommand 101, reset 0, biosparam 0, interrupt 102
  callback 101, done 101, build_error 0, build_noreq 0, build_nosg 0
  exe_noerror 101, exe_busy 0, exe_error 0, exe_unknown 0
  cont_cnt 3, cont_xfer 0.0 kb avg_xfer 0.0 kb
  sg_cnt 98, sg_elem 208, sg_xfer 1569.0 kb
  avg_num_elem 2.1, avg_elem_size 7.5 kb, avg_xfer_size 16.0 kb
  Active and Waiting Request Queues (Time Unit: 250 HZ):
  target 5
    active: cnt [cur 0, max 4, tot 95], time [min 0, max 16, avg 3.7]
    waiting: cnt [cur 0, max 0, tot 0], time [min 0, max 0, avg 0.0]

Asc Library Configuration and Statistics for AdvanSys SCSI Host 0:
  chip_version 10, lib_version 0x118, lib_serial_no 123, mcode_date 0x12c3
  mcode_version 0x50d, err_code 0
  Total Command Pending: 0
  Command Queuing: 5:N
  Command Queue Pending: 5:0
  Command Queue Limit: 5:4
  Command Queue Full: 5:N
  Synchronous Transfer: 5:N

[root@death ~]# cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 05 Lun: 00
   Vendor: SEAGATE  Model: SX410800N        Rev: 7117
   Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 00 Lun: 00
   Vendor: IBM      Model: DNES-309170      Rev: SAH0
   Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi1 Channel: 00 Id: 01 Lun: 00
   Vendor: WDIGTL   Model: WD183 ULTRA2     Rev: 1.00
   Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 02 Lun: 00
   Vendor: TEAC     Model: CD-W512SB        Rev: 1.0C
   Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 06 Lun: 00
   Vendor: CyberDrv Model:  CD-ROM TW240S   Rev: 1.20
   Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 14 Lun: 00
   Vendor: SEAGATE  Model: SX118273LC       Rev: 6367
   Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi2 Channel: 00 Id: 00 Lun: 00
   Vendor: SanDisk  Model: ImageMate II     Rev: 1.30
   Type:   Direct-Access                    ANSI SCSI revision: 02


The SX410800N is the drive off the Advansys controller and is working just 
fine. I also have a scanner that I've been using all along as well but it 
isn't turned on atm so it isn't in the list.

I haven't had a problem with the controller in linux for as long as I 
can remember until 2.6.16. I've been using the patches rather than 
tarballs as they've come out for years. I believe I freshened the tree 
from tarball around 2.6.11.

I would say driver is working as intended, though I do get a slew of:

drivers/scsi/advansys.c:18223: warning: passing argument 2 of 'writew' 
makes pointer from integer without a cast
drivers/scsi/advansys.c:18223: warning: passing argument 2 of 'writeb' 
makes pointer from integer without a cast

warnings when compiling
