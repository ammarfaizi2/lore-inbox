Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278647AbRJSUQL>; Fri, 19 Oct 2001 16:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278648AbRJSUQC>; Fri, 19 Oct 2001 16:16:02 -0400
Received: from relay1.ne.smtp.psi.net ([38.9.153.2]:64394 "EHLO
	relay1.ne.smtp.psi.net") by vger.kernel.org with ESMTP
	id <S278647AbRJSUPs>; Fri, 19 Oct 2001 16:15:48 -0400
Date: Fri, 19 Oct 2001 16:16:21 -0400
Message-Id: <200110192016.f9JKGLx25633@mojo.ma.radiance>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: John Ruttenberg <rutt@chezrutt.com>
Reply-to: rutt@chezrutt.com
To: linux-kernel@vger.kernel.o
cc: wdl@ma.ultranet.com
Subject: Dell Inspiron 8100 & ide dma
X-Mailer: VM 6.96 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This computer doesn't seem to work with the 2.4.2 redhat default kernel and
ide dma enabled.  In fact it cannot even get very far into the install before
it craches.  I found (but cannot find again) a redhat bug report about this
and was able to get through the install by using ide=nodma on the installer's
lilo command line.

Once the default kernel booted up, it basically trashed the file system,
perhaps because it was also running the ide dma.  We redid this and also
supplied ide=nodma via lilo the installed kernel.

Now we have built linux-2.4.12-ac3.  Is there any chance this bug has been
fixed in this new kernel and that it might be safe to reenable dma?

Once interesting tidbit is that the dmesg files say pretty different things
about ide in the new vs the old kernel:

2.4.2 (redhat 7.1):

    Uniform Multi-Platform E-IDE driver Revision: 6.31
    ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
    PCI_IDE: unknown IDE controller on PCI bus 00 device f9, VID=8086, DID=244a
    PCI_IDE: chipset revision 3
    PCI_IDE: not 100% native mode: will probe irqs later
        ide0: BM-DMA at 0xbfa0-0xbfa7, BIOS settings: hda:DMA, hdb:DMA
        ide1: BM-DMA at 0xbfa8-0xbfaf, BIOS settings: hdc:pio, hdd:pio
    hda: HITACHI_DK23CA-30, ATA DISK drive
    hdb: TEAC CD-ROM CD-224E, ATAPI CD/DVD-ROM drive
    ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
    hda: 58605120 sectors (30006 MB) w/2048KiB Cache, CHS=3648/255/63

2.4.12-ac3:

    Uniform Multi-Platform E-IDE driver Revision: 6.31
    ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
    PIIX4: IDE controller on PCI bus 00 dev f9
    PIIX4: chipset revision 3
    PIIX4: not 100% native mode: will probe irqs later
        ide0: BM-DMA at 0xbfa0-0xbfa7, BIOS settings: hda:DMA, hdb:DMA
    hda: HITACHI_DK23CA-30, ATA DISK drive
    hdb: TEAC CD-ROM CD-224E, ATAPI CD/DVD-ROM drive
    ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
    hda: 58605120 sectors (30006 MB) w/2048KiB Cache, CHS=3648/255/63
    hdb: ATAPI 24X CD-ROM drive, 128kB Cache
    Uniform CD-ROM driver Revision: 3.12

Does anyone know anything about this?
