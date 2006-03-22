Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932747AbWCVVWf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932747AbWCVVWf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 16:22:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932748AbWCVVWf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 16:22:35 -0500
Received: from sccrmhc11.comcast.net ([63.240.77.81]:62609 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S932747AbWCVVWe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 16:22:34 -0500
Message-ID: <4421C018.80005@comcast.net>
Date: Wed, 22 Mar 2006 16:22:32 -0500
From: Ed Sweetman <safemode@comcast.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: libata ignores non-dma disks?
References: <4420B7D6.4020706@comcast.net> <4420CAD4.60700@garzik.org>
In-Reply-To: <4420CAD4.60700@garzik.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

> Ed Sweetman wrote:
>
>> I'm using 2.6.16-rc6-ide1 (alan's patchset) and using the sata_nv and
>> pata_amd drivers.  I have all UDMA drives except a CF disk -> IDE
>> interface, which should be running in PIO mode4.   Libata detects the
>> device, but spits out a message about "no dma" and then says it's not
>> supported and is ignoring it.   Is this device not supported because
>> it's not using dma or for some other reason?
>> It's the only device on it's channel (secondary pata)
>>
>> ata6: PATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xF008 irq 15
>> ata6: dev 0 cfg 49:0e00 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000
>> 88:0000
>> ata6: no dma
>> ata6: dev 0 not supported, ignoring
>> scsi5 : pata_amd
>
>
> Delete the "no dma" check, and debug from there...  PIO support is in 
> there, just needs a few final fixes.
>
>     Jeff


Works perfectly now.   Thanks.   What isn't finished about it? 

anyways, here's an hdparm readout, for those that care.

CompactFlash ATA device, with removable media
        Model Number:       TOSHIBA THNCF512MPG
        Serial Number:      TSBC512M05928B66857C
        Firmware Revision:  1.00
Standards:
        Likely used: 4
Configuration:
        Logical         max     current
        cylinders       993     993
        heads           16      16
        sectors/track   63      63
        --
        bytes/track: 33264      bytes/sector: 528
        CHS current addressable sectors:    1000944
        LBA    user addressable sectors:    1000944
        device size with M = 1024*1024:         488 MBytes
        device size with M = 1000*1000:         512 MBytes
Capabilities:
        LBA, IORDY(can be disabled)
        Buffer size: 2.0kB      bytes avail on r/w long: 4      Queue 
depth: 1
        Standby timer values: spec'd by Vendor
        R/W multiple sector transfer: Max = 1   Current = 1
        DMA: not supported
        PIO: pio0 pio1 pio2 pio3 pio4
             Cycle time: no flow control=120ns  IORDY flow control=120ns

