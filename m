Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318526AbSHEPEb>; Mon, 5 Aug 2002 11:04:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318538AbSHEPEb>; Mon, 5 Aug 2002 11:04:31 -0400
Received: from midiowa2.midiowa.net ([64.71.65.202]:1978 "EHLO midiowa.net")
	by vger.kernel.org with ESMTP id <S318526AbSHEPE2>;
	Mon, 5 Aug 2002 11:04:28 -0400
Date: Mon, 5 Aug 2002 10:07:44 -0500
From: Tyler Longren <tyler@captainjack.com>
To: bd@bc-bd.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19 hangs on partition table check
Message-Id: <20020805100744.460f3a4e.tyler@captainjack.com>
In-Reply-To: <20020805145953.GE622@hexenkessel.bc>
References: <20020805145953.GE622@hexenkessel.bc>
Organization: Captain Jack Communicatins
X-Mailer: Sylpheed version 0.8.1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Aug 2002 16:59:54 +0200
bd@bc-bd.org wrote:

> Hi,
> 
> during boot the kernel hangs when it tries to check the partition
> table of one hd, a 120GB Maxtor. The gemometry is detected right
> though and there are no problems with the 2.4.18 kernel where i used
> the same configuration as with the new kernel.
> 
> the host is a i586 on a gigabyte HX motherboard and i am running
> debian testing with the latest packages.
> 
> this drive (hdg) is atached to a promise66 pci card on the second
> controler(ide3) and is the only drive there. i have two other maxtors
> (60GB and 80GB) atached to the other controler (ide2). the partition
> table checks for those work fine.
> 
> if you need any other information, please let me know.
> 
> by
> 	bd
> 
> $ cat /usr/src/linux/.config | grep PDC
> CONFIG_BLK_DEV_PDC202XX=y
> CONFIG_PDC202XX_BURST=y
> # CONFIG_PDC202XX_FORCE is not set
> # CONFIG_BLK_DEV_ATARAID_PDC is not set
> 
> $ cat /proc/pci
> Bus  0, device   8, function  0:
> Unknown mass storage controller: Promise Technology, Inc. 20262 (rev
> 1). IRQ 11.
> Master Capable.  Latency=32.  
> I/O at 0x6000 [0x6007].
> I/O at 0x6100 [0x6103].
> I/O at 0x6200 [0x6207].
> I/O at 0x6300 [0x6303].
> I/O at 0x6400 [0x643f].
> Non-prefetchable 32 bit memory at 0xe0000000 [0xe001ffff].
> 
> $ cat /proc/ide/pdc2002xx
>                                 PDC20262 Chipset.
> ------------------------------- General Status
> --------------------------------- Burst Mode                          
> : enabled Host Mode                            : Normal
> Bus Clocking                         : 33 PCI Internal
> IO pad select                        : 4 mA
> Status Polling Period                : 0
> Interrupt Check Status Polling Delay : 2
> --------------- Primary Channel ---------------- Secondary Channel
> -------------
>                 enabled                          enabled 
> 66 Clocking     enabled                          enabled 
>            Mode PCI                         Mode PCI   
>                 FIFO Empty                       FIFO Empty  
> --------------- drive0 --------- drive1 -------- drive0 ----------
> drive1 ------ DMA enabled:    yes              yes             yes    
>           no 
> DMA Mode:       UDMA 4           UDMA 4          UDMA 4           
> NOTSET PIO Mode:       PIO 4            PIO 4           PIO 4         
>   NOTSET
> 
> $ cat /proc/ide/ide3/hdg/geometry 
> physical     238216/16/63
> logical      238216/16/63
> 
> $ cat /proc/ide/ide3/hdg/model 
> Maxtor 4G120J6
> 
> $ /sbin/fdisk -l /dev/hdg
> Disk /dev/hdg: 16 heads, 63 sectors, 238216 cylinders
> Units = cylinders of 1008 * 512 bytes
> 
> Device Boot    Start       End    Blocks   Id  System
>  /dev/hdg1             1     41611  20971912+  83  Linux
>  /dev/hdg2         41612     83222  20971944   83  Linux
>  /dev/hdg3         83223    124833  20971944   83  Linux
>  /dev/hdg4        124834    238216  57145032    5  Extended
>  /dev/hdg5        124834    166444  20971912+  83  Linux
>  /dev/hdg6        166445    208055  20971912+  83  Linux
>  /dev/hdg7        208056    238216  15201112+  83  Linux
> 
> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


This is being addressed by Alan Cox's -ac patch.  Try applying
ac4, that might fix your problems.

Tyler Longren
