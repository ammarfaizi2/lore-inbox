Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283446AbRK3A4B>; Thu, 29 Nov 2001 19:56:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283450AbRK3Azv>; Thu, 29 Nov 2001 19:55:51 -0500
Received: from sproxy.gmx.de ([213.165.64.20]:37295 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S283446AbRK3Azo>;
	Thu, 29 Nov 2001 19:55:44 -0500
Date: Fri, 30 Nov 2001 01:55:38 +0100
From: Rene Rebe <rene.rebe@gmx.net>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: linux-kernel@vger.kernel.org, ziegler@informatik.hu-berlin.de
Subject: Re: IDE controller detection 2.4 +devfs
Message-Id: <20011130015538.68b09e03.rene.rebe@gmx.net>
In-Reply-To: <200111300034.fAU0YB904723@vindaloo.ras.ucalgary.ca>
In-Reply-To: <20011130001138.78ab1242.rene.rebe@gmx.net>
	<200111300017.fAU0Hx704241@vindaloo.ras.ucalgary.ca>
	<20011130012752.0fd5380a.rene.rebe@gmx.net>
	<200111300034.fAU0YB904723@vindaloo.ras.ucalgary.ca>
Organization: FreeSourceCommunity ;-)
X-Mailer: Sylpheed version 0.6.5 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Nov 2001 17:34:11 -0700
Richard Gooch <rgooch@ras.ucalgary.ca> wrote:

> No, the "bus" I referred to was the SCSI or IDE bus. And IDE bus
> supports two devices (called master and slave) while a SCSI bus
> supports many more devices. It has nothing to do with PCI ID's.

Ok. Hey lets leave away such detail-teaching because I'm shure we both
know enough about all this details and technology (For me I have both
types gambling arround here - and also maintain a whole distro, too ...)

> > And disabling one channel in the bios shouldn't move the controller
> > from host0 to host1 ... - I do not see the system-behind that ...
> 
> Um, from your previous message, it seems that host numbering doesn't
> change depending on BIOS settings.

It was the first storry - my older Athlon.

> So what exactly is happening? And what is the problem? I realise you
> may find the naming a little confusing, but is there an actual
> problem?

ok - again.

I have a K6 on an ALI Aladin-5 board and an additional IDE controller
(Promisse). The onboard can be found as /dev/host0 and the additional
Promisse one appears as /dev/host2:

server1:~ # l /dev/ide/
total 0
drwxr-xr-x   1 root     root            0 Jan  1  1970 .
drwxr-xr-x   1 root     root            0 Jan  1  1970 ..
drwxr-xr-x   1 root     root            0 Jan  1  1970 host0
drwxr-xr-x   1 root     root            0 Jan  1  1970 host2

The boot messages:

<6>Uniform Multi-Platform E-IDE driver Revision: 6.31
<4>ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
<4>PDC20268: IDE controller on PCI bus 00 dev 58
<6>PCI: Found IRQ 11 for device 00:0b.0
<4>PDC20268: chipset revision 2
<4>PDC20268: not 100%% native mode: will probe irqs later
<4>PDC20268: (U)DMA Burst Bit ENABLED Primary MASTER Mode Secondary MASTER Mode.
<4>    ide2: BM-DMA at 0xa800-0xa807, BIOS settings: hde:pio, hdf:pio
<4>    ide3: BM-DMA at 0xa808-0xa80f, BIOS settings: hdg:pio, hdh:pio
<4>ALI15X3: IDE controller on PCI bus 00 dev 78
<4>PCI: No IRQ known for interrupt pin A of device 00:0f.0. Please try using pci
=biosirq.
<4>ALI15X3: chipset revision 193
<4>ALI15X3: not 100%% native mode: will probe irqs later
<4>    ide0: BM-DMA at 0xa400-0xa407, BIOS settings: hda:DMA, hdb:pio
<4>    ide1: BM-DMA at 0xa408-0xa40f, BIOS settings: hdc:pio, hdd:pio
<4>hda: TOSHIBA MK6015MAP, ATA DISK drive
<4>ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
<4>hdc: IBM-DTLA-305040, ATA DISK drive
<4>hde: IBM-DTLA-305040, ATA DISK drive
<4>hdg: IBM-DTLA-305040, ATA DISK drive
<4>ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
<4>ide1 at 0x170-0x177,0x376 on irq 15

I works - but sucks, because I'm not able to predict the ide-controller
entries in /dev/ide/* because they seem (for me) randomly on each workstaion
I am ...

(All info from my very first mail ...)

The other bug is: On a Athlon-600 workstation based on an Irongate
board (Asus-K7M) I have to disable the first (primarry) channel of
the onbaord IDE controller, because it has problem with the UDMA-66
mode. But when I disable this channel, Linux generates a /dev/ide/host1
entry - No host0 entry is there. Sure it works - but sucks, too!
(Generates a very unstable feeling in me ...)

Thanks for keep reading ;)

> 				Regards,
> 
> 					Richard....
> Permanent: rgooch@atnf.csiro.au
> Current:   rgooch@ras.ucalgary.ca


k33p h4ck1n6
  René

-- 
René Rebe (Registered Linux user: #127875 <http://counter.li.org>)

eMail:    rene.rebe@gmx.net
          rene@rocklinux.org

Homepage: http://www.tfh-berlin.de/~s712059/index.html

Anyone sending unwanted advertising e-mail to this address will be
charged $25 for network traffic and computing time. By extracting my
address from this message or its header, you agree to these terms.
