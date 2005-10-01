Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750754AbVJAP0i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbVJAP0i (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 11:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbVJAP0i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 11:26:38 -0400
Received: from joel.tallye.com ([216.99.199.78]:18131 "EHLO hosea.tallye.com")
	by vger.kernel.org with ESMTP id S1750754AbVJAP0i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 11:26:38 -0400
Date: Sat, 1 Oct 2005 08:26:22 -0700
From: "Loren M. Lang" <lorenl@alzatex.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Loren M. Lang" <lorenl@alzatex.com>, linux-kernel@vger.kernel.org
Subject: Re: RocketPoint 1520 [hpt366] fails clock stabilization
Message-ID: <20051001152622.GC22233@alzatex.com>
References: <20050929103309.GA12361@alzatex.com> <1128036611.9290.3.camel@localhost.localdomain> <20050930093355.GB22233@alzatex.com> <1128080044.17099.2.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YToU2i3Vx8H2dn7O"
Content-Disposition: inline
In-Reply-To: <1128080044.17099.2.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
X-GPG-Key: ftp://ftp.tallye.com/pub/lorenl_pubkey.asc
X-GPG-Fingerprint: B3B9 D669 69C9 09EC 1BCD  835A FAF3 7A46 E4A3 280C
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--YToU2i3Vx8H2dn7O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 30, 2005 at 12:34:04PM +0100, Alan Cox wrote:
> On Gwe, 2005-09-30 at 02:33 -0700, Loren M. Lang wrote:
> > I booted FreeBSD 6.0 and it seemed to reconize the card and attached
> > hard drive ok.  In the dmesg for freebsd, it mentioned 372N, if that
> > means anything.  There is a patch, I discovered, which disables the
>=20
> Yes - it means its the older card with a 372N on it.

Actually, while FreeBSD claims it's a 372N, both NetBSD and OpenBSD
agree it's a 372A.  Also, FreeBSD reports UDMA133, instead of SATA150
like my onboard sata ports.  Is this chip a modified PATA driver?  There
seem to be lots of references to IDE drives used with this chip.

>=20
> > seg faulting when it failed to detect my chip, and I disabled a check
> > for the 372N chipset.
>=20
> Which means you are misclocking the IDE drive. I need to work out why
> the PLL failed.
>=20
> What does it report for FREQ and PLL if you boot 2.6.13.something on
> it ?

On a vanilla 2.6.13.2 kernel, the FREQ is 144 and the PLL is 66.  The
driver still seg faults when it fails to find a stable clock.  I can
probably post an updated patch that will at least prevent it from
crashing and fail properly instead.  The full dmesg of the driver
insertion is below.

HPT372A: IDE controller at PCI slot 0000:02:0c.0
PCI: Enabling device 0000:02:0c.0 (0105 -> 0107)
ACPI: PCI Interrupt 0000:02:0c.0[A] -> GSI 20 (level, low) -> IRQ 23
HPT372A: chipset revision 2
HPT372A: 100% native mode on irq 23
hpt: HPT372N detected, using 372N timing.
FREQ: 124 PLL: 45
No Clock Stabilization!!!
hpt: no known IDE timings, disabling DMA.
hpt: HPT372N detected, using 372N timing.
FREQ: 144 PLL: 66
No Clock Stabilization!!!
hpt: no known IDE timings, disabling DMA.
Probing IDE interface ide2...
hde: WDC WD2500KS-00MJB0, ATA DISK drive
Unable to handle kernel NULL pointer dereference at virtual address
00000000
 printing eip:
fe0a7349
*pde =3D 00000000
Oops: 0000 [#1]
PREEMPT SMP=20
Modules linked in: hpt366 nfsd exportfs lockd sunrpc nls_cp437
nls_iso8859_1 smbfs nls_base twofish serpent aes_i586 blowfish des
sha256 sha1 crypto_null af_key w8362
7hf i2c_sensor i2c_isa ipv6 rfcomm hidp l2cap snd_pcm_oss snd_mixer_oss
snd_seq_midi_event snd_seq snd_seq_device ohci_hcd parport_pc parport
floppy 8250_pnp 8250 ser
ial_core pcspkr ohci1394 ieee1394 snd_bt87x tuner tvaudio msp3400 bttv
video_buf firmware_class v4l2_common btcx_risc tveeprom videodev sk98lin
nvidiafb i2c_algo_bit=20
snd_intel8x0 snd_ac97_codec snd_pcm snd_timer snd snd_page_alloc
i2c_i801 usb_storage ehci_hcd evdev hci_usb bluetooth usbhid uhci_hcd
intel_agp agpgart usbcore ufs s
d_mod ata_piix libata sg scsi_mod ide_cd cdrom dm_mod emu10k1 sound
soundcore ac97_codec
CPU:    0
EIP:    0060:[<fe0a7349>]    Not tainted VLI
EFLAGS: 00010282   (2.6.13.2)=20
EIP is at pci_bus_clock_list+0x9/0x30 [hpt366]
eax: 0000000c   ebx: 00000051   ecx: 0000000c   edx: 00000000
esi: 30070000   edi: c1a7a660   ebp: c19ee000   esp: f6d0fe1c
ds: 007b   es: 007b   ss: 0068
Process insmod (pid: 15167, threadinfo=3Df6d0e000 task=3Df7d30a80)
Stack: fe0a7728 0000000c 00000000 00000051 00000000 0000000c 0c409900
00000000=20
       00479990 c0479990 c0344cc1 000000ff c0479900 c029a929 c0479990
0000000c=20
       fe0abaf8 00000017 00000017 00000017 00000246 00000000 c19ee000
00000000=20
Call Trace:
 [<fe0a7728>] hpt372_tune_chipset+0xd8/0x160 [hpt366]
 [<c029a929>] probe_hwif+0x259/0x4a0
 [<c029ab85>] probe_hwif_init_with_fixup+0x15/0xa0
 [<c029e1a1>] ide_setup_pci_device+0x61/0xa0
 [<fe0a93d8>] hpt366_init_one+0x28/0x30 [hpt366]
 [<c022648f>] __pci_device_probe+0x5f/0x70
 [<c02264cf>] pci_device_probe+0x2f/0x50
 [<c027dd8b>] driver_probe_device+0x3b/0xb0
 [<c027de80>] __driver_attach+0x0/0x60
 [<c027ded0>] __driver_attach+0x50/0x60
 [<c027d359>] bus_for_each_dev+0x69/0x80
 [<c027df05>] driver_attach+0x25/0x30
 [<c027de80>] __driver_attach+0x0/0x60
 [<c027d8ad>] bus_add_driver+0x8d/0xe0
 [<c02267a3>] pci_register_driver+0x83/0xa0
 [<fe0a93ef>] hpt366_ide_init+0xf/0x14 [hpt366]
 [<c013dfea>] sys_init_module+0x16a/0x220
 [<c01030bb>] sysenter_past_esp+0x54/0x75
Code: c2 85 c0 ba 01 00 00 00 75 cf 8b 75 00 85 f6 75 e1 eb c4 eb 0d 90
90 90 90 90 90 90 90 90 90 90 90 90 0f b6 4c 24 04 8b 54 24 08 <0f> b6
02 84 c0 74 0e 38 c8 74
 0e 83 c2 08 0f b6 02 84 c0 75 f2=20

--=20
I sense much NT in you.
NT leads to Bluescreen.
Bluescreen leads to downtime.
Downtime leads to suffering.
NT is the path to the darkside.
Powerful Unix is.

Public Key: ftp://ftp.tallye.com/pub/lorenl_pubkey.asc
Fingerprint: CEE1 AAE2 F66C 59B5 34CA  C415 6D35 E847 0118 A3D2
=20

--YToU2i3Vx8H2dn7O
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFDPqqebTXoRwEYo9IRApx2AJ4nhKMC1g/PQ/09JdZYR7TDVu9S9ACfS+HL
a1qz+UXMkgN1aO9WqUGNwxc=
=1CsD
-----END PGP SIGNATURE-----

--YToU2i3Vx8H2dn7O--
