Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261205AbVE2Qyq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261205AbVE2Qyq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 12:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261213AbVE2Qyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 12:54:46 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:44811 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261205AbVE2Qyi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 12:54:38 -0400
Date: Sun, 29 May 2005 18:49:54 +0200
From: Willy Tarreau <willy@w.ods.org>
To: "Bob R. Taylor" <brtaylor@sanfelipe.com.mx>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OFF TOPIC]? Maxtor disk problem
Message-ID: <20050529164954.GJ18600@alpha.home.local>
References: <1117302005.3865.44.camel@ann.qtpi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1117302005.3865.44.camel@ann.qtpi.local>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don't you have at least a PC in which you could test your card+disk ?
it may be possible that your card does not work in your alpha, I've already
had problems with some PCI cards in alpha (most probably because of the
drivers, or poorly designed PCI interfaces).

Just for reference, here is what hdparm sees on my maxtor 120GB on my
alpha (integrated ALI controller). Perhaps there's really a problem with
your disk, but it seems rather strange. Generally, IDE disks with bad
identification stop spinning and do not respond to any further command.

If it comes that it's your IDE controller which is wrong, perhaps you would
be interested in trying a SCSI->IDE adapter, which would allow you to turn
your IDE disk into an SCSI-like one and connect it to your motherboard ?

Regards,
Willy

/dev/hdc:

non-removable ATA device, with non-removable media
	Model Number:		Maxtor 6Y120L0                          
	Serial Number:		Y410P3CE            
	Firmware Revision:	YAR41BW0
Standards:
	Supported: 1 2 3 4 5 6 7 
	Likely used: 7
Configuration:
	Logical		max	current
	cylinders	16383	16383
	heads		16	16
	sectors/track	63	63
	bytes/track:	0		(obsolete)
	bytes/sector:	0		(obsolete)
	current sector capacity: 16514064
	LBA user addressable sectors = 240121728
Capabilities:
	LBA, IORDY(can be disabled)
	Buffer size: 2048.0kB	ECC bytes: 57	Queue depth: 1
	Standby timer values: spec'd by standard, no device specific minimum
	r/w multiple sector transfer: Max = 16	Current = 16
	DMA: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4 udma5 udma6 
	     Cycle time: min=120ns recommended=120ns
	PIO: pio0 pio1 pio2 pio3 pio4 
	     Cycle time: no flow control=120ns  IORDY flow control=120ns
Commands/features:
	Enabled	Supported:
	   *	NOP cmd
	   *	READ BUFFER cmd
	   *	WRITE BUFFER cmd
	   *	Host Protected Area feature set
	   *	look-ahead
	   *	write cache
	   *	Power Management feature set
		Security Mode feature set
	   *	SMART feature set
		SET MAX security extension
		Advanced Power Management feature set
	   *	DOWNLOAD MICROCODE cmd
Security: 
	Master password revision code = 65534
		supported
	not	enabled
	not	locked
	not	frozen
	not	expired: security count
	not	supported: enhanced erase
HW reset results:
	CBLID- below Vih
	Device num = 0 determined by the jumper
Checksum: correct


On Sat, May 28, 2005 at 10:17:33PM -0700, Bob R. Taylor wrote:
> Before I get any egg on my face by returning this disk, I am asking the
> IDE gurus opinion. I'm also sorry for bothering lkml.
> 
> I'm running FedoraCore 2 on a Alpha LX164 box with 512M RAM. The on
> board IDE chip won't handle current IDE so I purchased a HighPoint
> Rocket133 and a Maxtor 120G drive. On boot, the kernel panics after
> probing the drive reporting "INVALID HEADS" etc. I then gave the kernel
> hde=noprobe option via SRM to boot the system after adding "alias
> block-major-33 ide-probe" to /etc/modprobe.conf. While fsdisk /dev/hde
> reports "unable to read /dev/hde", hdparm -I reports the following:
> 
> /dev/hde:
>  
> ATA device, with non-removable media
>         Model Number:       Maxtor CALYPSO
>         Firmware Revision:  YAR43KJZ
> Standards:
>         Likely used: 1
> Configuration:
>         fixed drive
>         Logical         max     current
>         cylinders       0       0
>         heads           0       0
>         sectors/track   0       0
>         --
>         device size with M = 1024*1024:           0 MBytes
>         device size with M = 1000*1000:           0 MBytes
> Capabilities:
>         IORDY not likely
>         Cannot perform double-word IO
>         R/W multiple sector transfer: not supported
>         DMA: not supported
>         PIO: pio0
> 
> I'm not familiar with IDE at all. I have always used SCSI. However, my
> SCSI disk is full and I'm short of money.
> 
> My current opinion is the disk is bad. Could an expert please confirm
> this or please tell me how to fix it? Sorry, printed on the disk is: LBA
> 240121728 which, I presume, is the total sectors.
> 
> Thanks in advance.
> 
> More data:
> 
> cat /proc/devices (edited)
> 
> Block devices:
>   1 ramdisk
>   2 fd
>   8 sd
>   9 md
>  11 sr
>  33 ide2
>  65 sd
>  
> ls -l /proc/ide
> 
> -r--r--r--  1 root root 0 May 28 10:32 cmd64x
> -r--r--r--  1 root root 0 May 28 10:32 drivers
> lrwxrwxrwx  1 root root 8 May 28 10:32 hde -> ide2/hde
> -r--r--r--  1 root root 0 May 28 10:32 hpt366
> dr-xr-xr-x  3 root root 0 May 28 10:32 ide2
> 
> -- 
> Bob R. Taylor <brtaylor@sanfelipe.com.mx>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
