Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267654AbSLFWxp>; Fri, 6 Dec 2002 17:53:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267655AbSLFWxo>; Fri, 6 Dec 2002 17:53:44 -0500
Received: from [209.48.37.1] ([209.48.37.1]:43138 "EHLO xdr.com")
	by vger.kernel.org with ESMTP id <S267654AbSLFWxn>;
	Fri, 6 Dec 2002 17:53:43 -0500
Date: Fri, 6 Dec 2002 15:00:45 -0800
From: David Ashley <dash@xdr.com>
Message-Id: <200212062300.gB6N0jg10757@xdr.com>
To: alan@lxorguk.ukuu.org.uk
Subject: Re: 2.4.18 beats 2.5.50 in hard drive access????
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Fri, 2002-12-06 at 19:29, David Ashley wrote:
>>     ide0: BM-DMA at 0x1880-0x1887, BIOS settings: hda:pio, hdb:DMA
>>     ide1: BM-DMA at 0x1888-0x188f, BIOS settings: hdc:pio, hdd:DMA
>
>When we read the settings DMA was disabled on hda and hdc. We therefore
>assumed the BIOS did that for a reason and followed caution.
>
>What happens if you do
>
>        hdparm -d1 /dev/hda
>
>?

hda is an IDE cdrom drive, but here it is:

root@test:~# hdparm -d1 /dev/hda

/dev/hda:
 setting using_dma to 1 (on)
 using_dma    =  1 (on)
root@test:~# 

root@test:~# hdparm -d1 /dev/hdb

/dev/hdb:
 setting using_dma to 1 (on)
 using_dma    =  1 (on)
root@test:~# 
root@test:~# hdparm /dev/hdb    

/dev/hdb:
 multcount    = 16 (on)
 I/O support  =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    = 256 (on)
 HDIO_GETGEO_BIG failed: Inappropriate ioctl for device
root@test:~# hdparm -h

hdparm - get/set hard disk parameters - version v4.1

Usage:  hdparm  [options] [device] ..

Options:
 -a   get/set fs readahead
 -A   set drive read-lookahead flag (0/1)
 -B   get Advanced Power Management setting (1-255)
 -c   get/set IDE 32-bit IO setting
 -C   check IDE power mode status
 -d   get/set using_dma flag
 -D   enable/disable drive defect-mgmt
 -E   set cd-rom drive speed
 -f   flush buffer cache for device on exit
 -g   display drive geometry
 -h   display terse usage information
 -i   display drive identification
 -I   read drive identification directly from drive
 -k   get/set keep_settings_over_reset flag (0/1)
 -K   set drive keep_features_over_reset flag (0/1)
 -L   set drive doorlock (0/1) (removable harddisks only)
 -m   get/set multiple sector count
 -n   get/set ignore-write-errors flag (0/1)
 -p   set PIO mode on IDE interface chipset (0,1,2,3,4,...)
 -P   set drive prefetch count
 -q   change next setting quietly
 -r   get/set readonly flag (DANGEROUS to set)
 -R   register an IDE interface (DANGEROUS)
 -S   set standby (spindown) timeout
 -t   perform device read timings
 -T   perform cache read timings
 -u   get/set unmaskirq flag (0/1)
 -U   un-register an IDE interface (DANGEROUS)
 -v   default; same as -acdgkmnru (-gr for SCSI, -adgr for XT)
 -V   display program version and exit immediately
 -w   perform device reset (DANGEROUS)
 -W   set drive write-caching flag (0/1) (DANGEROUS)
 -x   perform device for hotswap flag (0/1) (DANGEROUS)
 -X   set IDE xfer mode (DANGEROUS)
 -y   put IDE drive in standby mode
 -Y   put IDE drive to sleep
 -Z   disable Seagate auto-powersaving mode
root@test:~#  

-Dave
