Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274875AbRKMP5n>; Tue, 13 Nov 2001 10:57:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273902AbRKMP5c>; Tue, 13 Nov 2001 10:57:32 -0500
Received: from 208-58-239-45.s45.tnt1.atnnj.pa.dialup.rcn.com ([208.58.239.45]:48879
	"EHLO trianna.2y.net") by vger.kernel.org with ESMTP
	id <S275012AbRKMP5R>; Tue, 13 Nov 2001 10:57:17 -0500
Date: Tue, 13 Nov 2001 10:55:43 -0500
From: Malcolm Mallardi <magamo@ranka.2y.net>
To: linux-kernel@vger.kernel.org
Subject: Long-standing problem with the PDC20262 driver
Message-ID: <20011113105543.A392@trianna.upcommand.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Heyla folks.  I've been plagued by a problem with the Promise IDE=20
Controller driver since before 2.4.x, and I'm still being plagued by it=20

(It's been a problem with every 2.4.x release I've tried, which is all of=
=20
them since 2.4.1)

Basically, on my machine, the kernel will freeze on bootup if I have the=20
PDC 202xx driver enabled at all, but will run normally if I just use the=20
generic IDE drivers with DMA support.

Here's my bootup messages when I get the problem, starting with where it=20
first detects my motherboard's IDE controller.

PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide1: BM-DMA at 0x1488-0x148f, BIOS settings: hdc: DMA, hdd: DMA
PDC20262: IDE controller on PCI bus 00 dev 78
PCI: Found IRQ 5 for device 00:0f.0
PDC20262: chipset revision 1
PDC20262: not 100% native mode: will probe irqs later
PDC20262: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode
    ide2: BM-DMA at 0x1400-0x1407, BIOS settings: hde: pio, hdf: pio
    ide3: BM-DMA at 0x1408-0x140f, BIOS settings: hdg: DMA, hdh: pio
hdc: HITACHI DVD-ROM GD-5000, ATAPI CD/DVD-ROM drive
hdd: _NEC NR-7700A, ATAPI CD/DVD-ROM drive
hde: QUANTUM FIREBALLP KX27.3, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0x14a8-0x14af,0x149e on irq 5

At this point it stops and hangs.

without the PDC202xx driver enabled in the kernel, things look a little=20
more like this; almost identical, but missing the (U)DMA Burst Bit line.

PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide1: BM-DMA at 0x1488-0x148f, BIOS settings: hdc:DMA, hdd:DMA
PDC20262: IDE controller on PCI bus 00 dev 78
PCI: Found IRQ 5 for device 00:0f.0
PDC20262: chipset revision 1
PDC20262: not 100% native mode: will probe irqs later
    ide2: BM-DMA at 0x1400-0x1407, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0x1408-0x140f, BIOS settings: hdg:DMA, hdh:pio
hdc: HITACHI DVD-ROM GD-5000, ATAPI CD/DVD-ROM drive
hdd: _NEC NR-7700A, ATAPI CD/DVD-ROM drive
hde: QUANTUM FIREBALLP KX27.3, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0x14a8-0x14af,0x149e on irq 5
hde: 53550304 sectors (27418 MB) w/418KiB Cache, CHS=3D53125/16/63
Partition check:
 hde: [PTBL] [3333/255/63] hde1 hde2 hde3

=2E.. And continues with normal startup.

I seem to recall when I once looked at the promise driver that there was=20
what appeared to be some form of exclusion list which included several=20
models of Quantum FireballP harddrives, but mine was not on the list.

I suspected then (I think that was sometime around 2.4.9) that if I added=
=20
the drive to that list that it would work, but I never tried it, due to=20
the fact that I don't know C, and was afraid of breaking it more. :)

I looked in the pdc202xx.c driver today and noticed that the list has=20
disappeared, but noticed that there were still references to it in the=20
code, I'm assuming that it was moved to a header somewhere.

I may be barking up to completely wrong tree... Any ideas?

--
Malcolm D. Mallardi - Dark Freak At Large
"Captain, we are receiving two-hundred eighty-five THOUSAND hails."
AOL: Nuark  UIN: 11084092 Y!: Magamo Jabber: Nuark@jabber.com
http://ranka.2y.net/~magamo/index.htm

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.5 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE78UJ/jukMeGBzbDARAj6OAJ9ocMHpK6Nj1xChw83oHokVRewH1QCeL85s
WsOfcJsxfP7HE9MCjTrjz6g=
=3BtQ
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
