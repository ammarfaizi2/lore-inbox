Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132862AbREEQaV>; Sat, 5 May 2001 12:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132850AbREEQaM>; Sat, 5 May 2001 12:30:12 -0400
Received: from thick.mail.pipex.net ([158.43.192.95]:16331 "HELO
	thick.mail.pipex.net") by vger.kernel.org with SMTP
	id <S132862AbREEQaC>; Sat, 5 May 2001 12:30:02 -0400
Message-ID: <3AF42A82.C05A2F51@ukgateway.net>
Date: Sat, 05 May 2001 17:29:54 +0100
From: Andy Piper <squiggle@ukgateway.net>
Reply-To: andy.piper@freeuk.com
Organization: excalibur
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.16 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Guest section DW <dwguest@win.tue.nl>
CC: linux-kernel@vger.kernel.org
Subject: Re: Dane-Elec PhotoMate Combo
In-Reply-To: <3AF18F40.BD741542@ukgateway.net> <20010503205929.A4187@win.tue.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guest section DW wrote:
> 
> On Thu, May 03, 2001 at 06:02:56PM +0100, Andy Piper wrote:
> 
> > I'd quite like to get the device working and stable,
> > and so would Andries
> 
> I can speak for myself, thank you.
> For me the Dane-Elec is working and stable.

I'm sorry to have caused offense, Andries - I realise I'm a newcomer,
and I should not have been so presumptuous.

You are using the Compact Flash reader part of the device, right? I
don't think it is working with SmartMedia. I've tried the latest
kernel 2.4.5-pre1, which incorporates your patch to allow the device
to be recognised. The Dane-Elec / SCM eUSB adapter can be seen in
/proc/bus/usb/devices, but I cannot mount a SmartMedia card (which I'm
assuming I should be able to mount on /dev/sda; mind you,
/proc/scsi/scsi shows it only as a Compact Flash device, and doesn't
mention SmartMedia...)

This part looks good:

castor kernel: Initializing USB Mass Storage driver...
castor kernel: usb.c: registered new driver usb-storage
castor kernel: scsi1 : SCSI emulation for USB Mass Storage devices
castor kernel:   Vendor: eUSB      Model: Compact Flash     Rev:     
castor kernel:   Type:   Direct-Access                      ANSI SCSI
revision: 02
castor kernel: usb-uhci.c: interrupt, status 3, frame# 1982
castor kernel: usb-uhci.c: interrupt, status 3, frame# 1987
castor kernel: usb-uhci.c: interrupt, status 3, frame# 1992
castor kernel: USB Mass Storage support registered.

... this bit doesn't look good ...

castor kernel: Detected scsi removable disk sda at scsi1, channel 0,
id 0, lun 0
castor kernel: usb-uhci.c: interrupt, status 3, frame# 1960
castor kernel: usb-uhci.c: interrupt, status 3, frame# 1973
castor kernel: usb-uhci.c: interrupt, status 3, frame# 1985
castor kernel: usb-uhci.c: interrupt, status 3, frame# 1997
castor kernel: sda : READ CAPACITY failed.
castor kernel: sda : status = 1, message = 00, host = 0, driver = 08 
castor kernel: sda : extended sense code = 2 
castor kernel: sda : block size assumed to be 512 bytes, disk size
1GB.  
castor kernel:  sda: I/O error: dev 08:00, sector 0
castor kernel:  unable to read partition table

... and this stuff looks plain wrong!

castor kernel: Device not ready.  Make sure there is a disc in the
drive.
castor kernel: usb-uhci.c: interrupt, status 3, frame# 1737
castor kernel: usb-uhci.c: interrupt, status 3, frame# 1749
castor kernel: usb-uhci.c: interrupt, status 3, frame# 1760
castor kernel: usb-uhci.c: interrupt, status 3, frame# 1771
castor kernel: sda : READ CAPACITY failed.
castor kernel: sda : status = 1, message = 00, host = 0, driver = 08 
castor kernel: sda : extended sense code = 2 
castor kernel: sda : block size assumed to be 512 bytes, disk size
1GB.  
castor kernel: usb-uhci.c: interrupt, status 3, frame# 1785
castor kernel: sda: test WP failed, assume Write Enabled
castor kernel:  sda: I/O error: dev 08:00, sector 0
castor kernel:  unable to read partition table
castor kernel: usb-uhci.c: interrupt, status 3, frame# 1803
castor kernel: Device not ready.  Make sure there is a disc in the
drive.
castor kernel: Device busy for revalidation (usage=1)
castor kernel: usb-uhci.c: interrupt, status 2, frame# 1821
castor kernel: Device 08:00 not ready.
castor kernel:  I/O error: dev 08:00, sector 0
castor kernel: FAT bread failed

I've also tried another hack I found in a news posting, advising that
CONFIG_USB_STORAGE_SDDR09 support should be added to the Config.in for
/usr/src/linux/drivers/usb and enabled; it hasn't helped.

The card will not mount as either vfat or msdos format (I note from
your earlier posting you mounted as msdos)

Aside from the card reader, my Fuji FinePix 4700 is recognised
perfectly by the USB / SCSI subsystems (although I can only ever mount
it write-protected, for some reason...); I can read the same
SmartMedia card in Linux via the camera, but not with the card reader,
so I know the partition table is sound.

Is this a discussion I should take to the usb-devel mailing list?

-- 
Andy Piper - Fareham, Hampshire (UK)
andy.piper@freeuk.com - ICQ #86489434
http://www.andyp.uklinux.net
