Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311322AbSCVGcn>; Fri, 22 Mar 2002 01:32:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312694AbSCVGcd>; Fri, 22 Mar 2002 01:32:33 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:60166
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S311322AbSCVGcV>; Fri, 22 Mar 2002 01:32:21 -0500
Date: Thu, 21 Mar 2002 22:31:49 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: David Schwartz <davids@webmaster.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.7, IDE, 'handler not null', 'kernel timer added twice'
In-Reply-To: <20020322055523.AAA14461@shell.webmaster.com@whenever>
Message-ID: <Pine.LNX.4.10.10203212229250.9319-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It is not harmless, it can be fatal.  Leaving a dangling interrupt handler
set for the next device is a bad thing.  I know what it is and where but
how and why is an issue to be resolved.

Regards,

Andre Hedrick
LAD Storage Consulting Group


On Thu, 21 Mar 2002, David Schwartz wrote:

> 
> 	I got the following from a 2.5.7 machine.
> 
> hdc: ide_set_handler: handler not null; old=c01e5af0, new=c01e5af0
> bug: kernel timer added twice at c01e6925.
> hdc: ide_set_handler: handler not null; old=c01e5af0, new=c01e5af0
> bug: kernel timer added twice at c01e6925.
> 
> 	The first two occured at about the same time. The second two occured the 
> next day. HDC is a WDC WD307AA ATA drive. The controller is a PIIX4 (82371AB) 
> using DMA (UDMA33).
> 
> 	The relevant section of the system map is :
> 
> c01e52c0 T do_rw_taskfile
> c01e5450 T do_taskfile
> c01e55b0 T set_multmode_intr
> c01e5610 T set_geometry_intr
> c01e5670 T recal_intr
> c01e56b0 T task_no_data_intr
> c01e5720 t task_in_intr
> c01e5840 t pre_task_out_intr
> c01e5940 t task_out_intr
> c01e5a90 t pre_bio_out_intr
> c01e5af0 t bio_mulout_intr
> c01e5ce0 t task_mulin_intr
> c01e5e70 T ide_cmd_type_parser
> c01e5ff0 t ide_init_drive_taskfile
> c01e6010 T ide_wait_taskfile
> c01e6120 T ide_raw_taskfile
> c01e6180 t ide_wait_cmd
> c01e6210 T ide_cmd_ioctl
> c01e6420 T ide_task_ioctl
> c01e64e0 t init_hwif_data
> c01e66a0 T drive_is_flashcard
> c01e67d0 T __ide_end_request
> c01e68c0 T ide_set_handler
> c01e6940 t ata_pre_reset
> c01e6a00 T ata_capacity
> c01e6a40 t ata_special
> 
> 	This looks harmless, like something was set twice.
> 
> -- 
> David Schwartz
> <davids@webmaster.com>
> Looking for news feed peering arrangements in Northern California
> Email for info
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

