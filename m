Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284385AbRLENgi>; Wed, 5 Dec 2001 08:36:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284390AbRLENg2>; Wed, 5 Dec 2001 08:36:28 -0500
Received: from grobbebol.xs4all.nl ([194.109.248.218]:26734 "EHLO
	grobbebol.xs4all.nl") by vger.kernel.org with ESMTP
	id <S284385AbRLENgJ>; Wed, 5 Dec 2001 08:36:09 -0500
Date: Wed, 5 Dec 2001 13:35:51 +0000
From: "Roeland Th. Jansen" <roel@grobbebol.xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: 2.2.14 USB problem
Message-ID: <20011205133551.A4770@grobbebol.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-OS: Linux grobbebol 2.4.14 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently bought a fujifilm finepix 1300. Cool stuff and works with
minimal effort with USB.

However, after a few days, I was not able tomount the usb mass storage
of the cam anymore. It reposted at mount :

mount: /dev/sdb1 is not a valid block device

checked the process table and saw several usb processes in Z state. I
killed their paret and that went away. still usb-storage was loaded.
Tried to remove it -- oops process in D state. Note that khubd also was
in a Z state. All was not recoverable so a restart was needed.


USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
root         8  0.0  0.0     0    0 ?        Z    Nov16   0:00 [khubd <defunct>]
root     18297  0.0  0.0  1568  496 ?        D    11:13   0:00 rmmod usb-storage

when going singel user I saw :

pci_pool_destroy 00:07.2/uhci_desc e851ec000 busy
                                   d5d4c0000 busy


also in the logs stuff :

kernel: usbdevfs: USBDEVFS_CONTROL failed dev 29 rqt 128 rq 6 len 4 ret -6 
kernel: usb-uhci.c: ENXIO 80001d80, flags 0, urb c94880c0, burb c9488dc0 
kernel: scsi3 : SCSI emulation for USB Mass Storage devices
kernel:   Vendor: Fujifilm  Model: FinePix 1400Zoom  Rev: 1000
kernel:   Type:   Direct-Access ANSI SCSI revision: 02
kernel: Attached scsi removable disk sdc at scsi3, channel 0, id 0, lun 0
kernel: usb-uhci.c: ENXIO 80001d80, flags 0, urb c9488dc0, burb c94880c0
last message repeated 2 times
kernel: SCSI device sdc: 16000 512-byte hdwr sectors (8 MB)
kernel: sdc: Write Protect is off
kernel:  sdc: sdc1


note that the initial sdb1 now all over sudden was changed into sdc1.

hoe somebody has some use for this info.

-- 
Grobbebol's Home                        |  Don't give in to spammers.   -o)
http://www.xs4all.nl/~bengel            | Use your real e-mail address   /\
Linux 2.4.14 (noapic) SMP 466MHz/768 MB |        on Usenet.             _\_v  
