Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932412AbWFUBTF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932412AbWFUBTF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 21:19:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751922AbWFUBTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 21:19:04 -0400
Received: from s233-64-196-242.try.wideopenwest.com ([64.233.242.196]:40387
	"EHLO echohome.org") by vger.kernel.org with ESMTP id S1750867AbWFUBTB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 21:19:01 -0400
Reply-To: <Erik@echohome.org>
From: "Erik Ohrnberger" <Erik@echohome.org>
To: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Wish for 2006 to Alan Cox and Jeff Garzik: A functional Driver      for PDC202XX
Date: Tue, 20 Jun 2006 21:19:00 -0400
Organization: EchoHome.org
Message-ID: <!&!AAAAAAAAAAAYAAAAAAAAAIiq6P81RFNNl8OW5VuEScvCgAAAEAAAAMbmKIDqIQhHt6BBy4E2zd0BAAAAAA==@EchoHome.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <22582.216.68.248.2.1150807936.squirrel@www.echohome.org>
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
Thread-Index: AcaUaFuLT6iRZY56Q0i16jfaAMad2QAYi1eQ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hate to be a bother, but I think I must have botched something.

Here is what I did:
Downloaded kernel code.  
Applied the IDE patches (http://zeniv.linux.org.uk/~alan/IDE)
	(had to apply the change from ata_data_xfer calls to ops->data_xfer
	(no big deal, I speak C )

CONFIG_IDE is set to N
Device Drives\SCSI device support\Probe all LUNs on each SCSI device: Y
Device Drives\SCSI device support\Serial ATA (SATA) support: Y
Device Drives\SCSI device support\Serial ATA (SATA) support\NVIDIA SATA
support: Y
Device Drives\SCSI device support\Serial ATA (SATA) support\Promise SATA
TX2/TX4 Support: Y
Device Drives\SCSI device support\Serial ATA (SATA) support\Promise SATA SX4
Support: Y
Device Drives\SCSI device support\Older Promise PATA controller Support
(Raving Lunatic): Y
Device Drives\SCSI device support\Legacy ISA PATA support (Raving Lunatic):
Y
Device Drives\SCSI device support\Older Promise PATA controller support
(Raving Lunatic): Y

Build the kernel, put it in /boot etc. and boot it.  The kernel finds the
motherboard IDE controllers and recognizes the two hard drives and the DVD
ROM drive there, but it does not appear to find the two Promise 20269
controllers.  What'd I do wrong?  Should I have applied the kernel-2.6.17
patches from kernel.org before the http://zeniv.linux.org.uk/~alan/IDE
patches?

If I ATA/ATAPI/MFM/RLL support\PROMISE PDC202{68|69|70|71|75|76|77} support:
Y
Then the kernel find the controllers, but uses that failing driver rather
than the SCSI/PATA driver.  Yea, well duhh.  So I can't turn that on.

lspci:
00:00.0 Host bridge: nVidia Corporation nForce2 AGP (different version?)
(rev c1)
00:00.1 RAM memory: nVidia Corporation nForce2 Memory Controller 0 (rev c1)
00:00.2 RAM memory: nVidia Corporation nForce2 Memory Controller 4 (rev c1)
00:00.3 RAM memory: nVidia Corporation nForce2 Memory Controller 3 (rev c1)
00:00.4 RAM memory: nVidia Corporation nForce2 Memory Controller 2 (rev c1)
00:00.5 RAM memory: nVidia Corporation nForce2 Memory Controller 5 (rev c1)
00:01.0 ISA bridge: nVidia Corporation nForce2 ISA Bridge (rev a4)
00:01.1 SMBus: nVidia Corporation nForce2 SMBus (MCP) (rev a2)
00:08.0 PCI bridge: nVidia Corporation nForce2 External PCI Bridge (rev a3)
00:09.0 IDE interface: nVidia Corporation nForce2 IDE (rev a2)
00:1e.0 PCI bridge: nVidia Corporation nForce2 AGP (rev c1)
01:06.0 Mass storage controller: Promise Technology, Inc. 20269 (rev 02)
01:07.0 Mass storage controller: Promise Technology, Inc. 20269 (rev 02)
01:0a.0 Ethernet controller: Accton Technology Corporation SMC2-1211TX (rev
10)
02:00.0 VGA compatible controller: ATI Technologies Inc Radeon R200 QM
[Radeon 9100]

> -----Original Message-----
> From: Erik Ohrnberger [mailto:Erik@EchoHome.org] 
> Sent: Tuesday, June 20, 2006 8:52 AM
> To: Alan Cox
> Cc: linux-kernel@vger.kernel.org
> Subject: RE: Wish for 2006 to Alan Cox and Jeff Garzik: A 
> functional Driver for PDC202XX
> 
> Alan,
>     I thank you persaonlly for these pointers.
> 
>     Erik.
> 
> On Tue, June 20, 2006 04:20, Alan Cox wrote:
> > Ar Llu, 2006-06-19 am 18:18 -0400, ysgrifennodd Erik Ohrnberger:
> >> Regardless, count me as another one of the interested 
> parties for a 
> >> cure.
> >> I've read the thread, and will prepare two current 
> kernels, one using 
> >> the PDC202XX_NEW and one using the PDC202XX_OLD configuration 
> >> options.  I'm hoping that the PDC202XX_OLD will also resolve this 
> >> issue.
> >
> > Bartlomiej is the old IDE layer maintainer. I would direct any 
> > enquiries to him about those drivers.
> >
> >> Any further advice on how to work around this would be greatly 
> >> appreciated.
> >
> > 2.6.17 with the libata pata patch from 
> > http://zeniv.linux.org.uk/~alan/IDE has a Promise driver for the PDC
> > 20268 and higher that was written by Albert Lee. There is 
> also a test 
> > driver for the older chips (20265 etc).
> >
> > To try that build 2.6.17 with the patch and then say "N" to 
> > CONFIG_IDE, "Y" to the SATA options under SCSI and the right 
> > controller. It will move your disks to /dev/sda /dev/sdb 
> etc as it uses the SCSI layer.
> >
> > Alan
> >
> 

