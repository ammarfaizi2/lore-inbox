Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264980AbUGIPJJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264980AbUGIPJJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 11:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265000AbUGIPJJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 11:09:09 -0400
Received: from pri-dns1.mtco.com ([207.179.200.251]:3235 "HELO
	pri-dns1.mtco.com") by vger.kernel.org with SMTP id S264980AbUGIPIm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 11:08:42 -0400
From: Tom Felker <tcfelker@mtco.com>
To: tfavre@mandrakesoft.com
Subject: Re: 2.6.7 : kernel panic while ripping CD
Date: Fri, 9 Jul 2004 10:08:44 -0500
User-Agent: KMail/1.6.2
Cc: <linux-kernel@vger.kernel.org>
References: <200407091157.20508.tfavre@mandrakesoft.com>
In-Reply-To: <200407091157.20508.tfavre@mandrakesoft.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407091008.44875.tcfelker@mtco.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 09 July 2004 4:57 am, Thibauld Favre wrote:
> Hi,
>
> When I rip a CD (I use kaudiocreator), I cannot rip all tracks in one go.
> When I do so, after a while (as far as I can say there's no logic) I can
> hear the CDrom drive stop and the ripping stalls. If I kill the process
> that stalled (the only thing I can do), then I get a bad kernel panic. So
> basically, when the ripping stalls I'm done ! I can continue working
> without problems but as soon as I want to close kaudiocreator : badaboom.
>
> I first thought it could come from kaudiocreator but then I realized that
> my CDrom drive was generating errors. Here's a summary of the interesting
> parts (the full dmesg and lsmod output can be found as attachments).
>
> ----------------------------------------------------------------
> hdc: UJDA745 DVD/CDRW, ATAPI CD/DVD-ROM drive
> [...]
> scsi0 : SCSI host adapter emulation for IDE ATAPI devices
>   Vendor: MATSHITA  Model: UJDA745 DVD/CDRW  Rev: 1.02
>   Type:   CD-ROM                             ANSI SCSI revision: 02
> [...]
> sr0: CDROM not ready.  Make sure there is a disc in the drive.
> sr0: CDROM not ready.  Make sure there is a disc in the drive.
> spurious 8259A interrupt: IRQ7.
> sr0: CDROM not ready.  Make sure there is a disc in the drive.
> sr0: CDROM not ready.  Make sure there is a disc in the drive.
> sr0: CDROM not ready.  Make sure there is a disc in the drive.
> sr0: CDROM not ready.  Make sure there is a disc in the drive.
> hdc: irq timeout: status=0xd0 { Busy }
> hdc: irq timeout: error=0xd0LastFailedSense 0x0d
> hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> hdc: status error: error=0x00
> hdc: drive not ready for command
> hdc: lost interrupt
> hdc: lost interrupt
> hdc: DMA disabled
> hdc: ATAPI reset complete
> scsi: Device offlined - not ready after error recovery: host 0 channel 0 id
> 8 lun 0
> scsi: Device offlined - not ready after error recovery: host 0 channel 0 id
> 8 lun 0
> sr0: CDROM (ioctl) error, command: 0x42 02 40 01 00 00 00 00 10 00
> sr: sense =  0  0
> Non-extended sense class 0 code 0x0
> Raw sense data:0x00 0x00 0x00 0x00
> sr0: CDROM (ioctl) error, command: 0x42 02 40 01 00 00 00 00 10 00
> sr: sense =  0  0
> Non-extended sense class 0 code 0x0
> Raw sense data:0x00 0x00 0x00 0x00
> ------------------------------------------------------------------------
>
> I use a Debian unstable on a T40p laptop with a self compiled 2.6.7 kernel.
> I access my CD-rom drive through /dev/sr0 I'd like to be able to help
> further but I don't know what might interest you. Just ask me if you need
> more info...
>
> Thanks a lot,
>
> Thibauld Favre

On 2.6 you're not really supposed to do IDE-SCSI emulation anymore.  Most 
software can now use the plain IDE interface, just by telling it to 
use /dev/hdc.  So try compiling ide-scsi as a module or not at all and not 
loading it.  This may not solve the problem, but it might make error recovery 
cleaner.

-- 
Tom Felker, <tcfelker@mtco.com>
<http://vlevel.sourceforge.net> - Stop fiddling with the volume knob.

The ability to monopolize a market is insignificant next to the power of the 
source.
