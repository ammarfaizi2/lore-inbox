Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319503AbSIGS3Y>; Sat, 7 Sep 2002 14:29:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319504AbSIGS3Y>; Sat, 7 Sep 2002 14:29:24 -0400
Received: from draal.physics.wisc.edu ([128.104.137.82]:42127 "EHLO
	draal.physics.wisc.edu") by vger.kernel.org with ESMTP
	id <S319503AbSIGS3T>; Sat, 7 Sep 2002 14:29:19 -0400
Date: Sat, 7 Sep 2002 13:33:29 -0500
From: Bob McElrath <mcelrath+kernel@draal.physics.wisc.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ide-scsi oops
Message-ID: <20020907183328.GB5985@draal.physics.wisc.edu>
References: <20020907163749.GA5985@draal.physics.wisc.edu> <1031421665.14390.2.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CdrF4e02JqNVZeln"
Content-Disposition: inline
In-Reply-To: <1031421665.14390.2.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--CdrF4e02JqNVZeln
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Alan Cox [alan@lxorguk.ukuu.org.uk] wrote:
> On Sat, 2002-09-07 at 17:37, Bob McElrath wrote:
> > Kernel 2.4.20-pre5-ac4 with the latest ACPI patches gives me an oops any
> > time I try to access the CD-ROM:
> >=20
> > Note this also happened with pre4-ac1 so I don't think it's due to the
> > latest IDE merge in pre5-ac4.
>=20
> Yes. What were you doing to trigger it. Also do you have highio/highmem
> stuff enabled and is taskfile on or off ?

Highmem is not used (this machine has 'only' 512M).  Not sure what
highio is but I did NOT pass the option "idex=3Dnohighio" to the kernel
(mentioned in Documentation/ide.txt).  I'm not sure what taskfile is
either.

    (2)<mcelrath@navi:/usr/src/linux/Documentation> grep -i high
    ../.config
    CONFIG_NOHIGHMEM=3Dy
    # CONFIG_HIGHMEM4G is not set
    # CONFIG_HIGHMEM64G is not set
    # CONFIG_HIGHMEM is not set

    (1)<mcelrath@navi:/usr/src/linux/Documentation> grep -i task ../.config
    # CONFIG_IDE_TASK_IOCTL is not set
    # CONFIG_IDE_TASKFILE_IO is not set

My boot command line is:
    (0)<mcelrath@navi:/usr/src/linux/Documentation> cat /proc/cmdline=20
    auto BOOT_IMAGE=3D2.4.20pre5ac4 ro root=3D302 BOOT_FILE=3D/boot/vmlinuz=
-2.4.20-pre5-ac3 hdc=3Dide-scsi resume=3D/dev/hda4
                                                                           =
           ^^^^^^^^^^^^

ac3/ac4 confusion is because you must have forgotten to increment that
number in the Makefile (but you probably know that already).  This is
pre5-ac4.  resume=3D is not used as I did not compile swsusp into this
kernel.

> I'm having real trouble reproducing this problem although enough people
> see it thats its clearly quite real

I can mount the drive successfully, the oops is triggered by the first
attempt at a read on the drive.  i.e.  less /mnt/cdrom/<first file>

There are probably other ways to trigger it.  But reading the first file
oopses 100%.

Here is the contents of /proc/ide that might be relevant:  My DVD/CD-RW is
drive0 on the second channel.

(0)<mcelrath@navi:/home/mcelrath> cat /proc/ide/piix=20

Controller: 0

                                Intel PIIX4 Ultra 100 Chipset.
--------------- Primary Channel ---------------- Secondary Channel --------=
-----
                 enabled                          enabled
--------------- drive0 --------- drive1 -------- drive0 ---------- drive1 -=
-----
DMA enabled:    yes              no              yes               no=20
UDMA enabled:   yes              no              no                no=20
UDMA enabled:   5                X               X                 X
UDMA
DMA
PIO

(0)<mcelrath@navi:/home/mcelrath> cat /proc/ide/drivers=20
ide-scsi version 0.93
ide-cdrom version 4.59
ide-disk version 1.16

(0)<mcelrath@navi:/home/mcelrath> sudo cat /proc/ide/ide1/hdc/capacity=20
2147483647

(0)<mcelrath@navi:/home/mcelrath> sudo cat /proc/ide/ide1/hdc/identify=20
85c0 0000 0000 0000 0000 0000 0000 0000
0000 0000 3432 3434 3430 3734 3636 2020
2020 2020 2020 2020 0000 1000 0000 3130
3136 2020 2020 544f 5348 4942 4120 4456
442d 524f 4d20 5344 2d52 3231 3032 2020
2020 2020 2020 2020 2020 2020 2020 0000
0000 0f00 0000 0400 0200 0006 0000 0000
0000 0000 0000 0000 0000 0000 0000 0407
0003 0078 0078 0078 0078 0000 0000 0000
0000 0004 0009 0000 0000 0000 0000 0000
003c 0013 0000 0000 0000 0000 0000 0000
0007 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 fffe 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000

(0)<mcelrath@navi:/home/mcelrath> sudo cat /proc/ide/ide1/hdc/media=20
cdrom

(0)<mcelrath@navi:/home/mcelrath> sudo cat /proc/ide/ide1/hdc/model=20
TOSHIBA DVD-ROM SD-R2102

(0)<mcelrath@navi:/home/mcelrath> sudo cat /proc/ide/ide1/hdc/settings=20
name                    value           min             max             mode
----                    -----           ---             ---             ----
bios_cyl                0               0               1023            rw
bios_head               0               0               255             rw
bios_sect               0               0               63              rw
current_speed           34              0               70              rw
ide-scsi                0               0               1               rw
init_speed              66              0               70              rw
io_32bit                1               0               3               rw
keepsettings            1               0               1               rw
log                     0               0               1               rw
nice1                   1               0               1               rw
number                  2               0               3               rw
pio_mode                write-only      0               255             w
slow                    0               0               1               rw
transform               1               0               3               rw
unmaskirq               0               0               1               rw
using_dma               1               0               1               rw

Cheers,
-- Bob

Bob McElrath
Univ. of Wisconsin at Madison, Department of Physics

"No nation could preserve its freedom in the midst of continual warfare."
    --James Madison, April 20, 1795

--CdrF4e02JqNVZeln
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAj16RngACgkQjwioWRGe9K0V6QCgtBdcHe/+Yx526e150cI/3zY8
yzMAnRcsajLJmHFMDZtQzhpyP3JIFemS
=A2if
-----END PGP SIGNATURE-----

--CdrF4e02JqNVZeln--
