Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292356AbSBPLuk>; Sat, 16 Feb 2002 06:50:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292358AbSBPLua>; Sat, 16 Feb 2002 06:50:30 -0500
Received: from hera.cwi.nl ([192.16.191.8]:10964 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S292356AbSBPLu0>;
	Sat, 16 Feb 2002 06:50:26 -0500
From: Andries.Brouwer@cwi.nl
Date: Sat, 16 Feb 2002 11:50:15 GMT
Message-Id: <UTC200202161150.LAA30214.aeb@cwi.nl>
To: Andries.Brouwer@cwi.nl, john@mwk.co.nz, linux-kernel@vger.kernel.org,
        martin.bene@icomedias.com
Subject: Re: AW: Need to force IDE geometry
Cc: andre@linux-ide.org, hugo@firstlinux.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From martin.bene@icomedias.com Sat Feb 16 10:13:30 2002

    Hi Andries,

    For some reasons the c/h/s settings reported for LBA disks depend on ide =
    device number: /hda uses 255 heads, 63 sectors while /dev/hdc and above =
    use 16 head, 63 sectors.

    hda: 150136560 sectors (76870 MB) w/1916KiB Cache, CHS=3D9345/255/63, =
    UDMA(33)
    hdb: 150136560 sectors (76870 MB) w/1916KiB Cache, CHS=3D148945/16/63, =
    UDMA(33)
    hdc: 150136560 sectors (76870 MB) w/1916KiB Cache, CHS=3D148945/16/63, =
    UDMA(33)

    As you can see, this means you end up with different reported drive =
    geometries for identical disks. Esp. if you want to use software raid =
    this is a major nuisance. The usual workaround is to change =
    head/cylinder settings when first partitioning the drive and let linux =
    change the geometry during partition table check.

    Partition check:
     hda: hda1 hda2 < hda5 hda6 > hda3
     hdb: [PTBL] [9345/255/63] hdb1 hdb2 < hdb5 hdb6 > hdb3
     hdc: [PTBL] [9345/255/63] hdc1 hdc2 < hdc5 hdc6 > hdc3

    While this works, it's quite unintuitive and confusing; correct =
    behaviour would be to treat all disks identicaly regardless of device =
    number.

Yes, this is a FAQ. See
	http://www.win.tue.nl/~aeb/linux/Large-Disk-14.html#ss14.2
"Identical disks have different geometry?".

You give as workaround bootparameters to Linux. My solution would
probably be to set the disks to "Normal" in the BIOS.
There is no need to tell the BIOS to do stupid tricks in order
to avoid DOS problems since we are not running DOS.
Moreover, with "Normal" the disk is slightly larger - for me the
difference is 7 MB.

(There is an unfortunate confusion here:
LBA is used in two very different meanings:
1) LBA "linear block addressing" is an access mode of disks.
Every disk is accessed this way by Linux, unless it is really old.
2) LBA "LBA assist" is a translation of disk geometry by the BIOS
in order to bypass DOS deficiencies.
Everyone wants the first, and gets it automatically.
Nobody running Linux wants the second, but people choosing LBA
in the BIOS setup usually think they are choosing the first.)

Andries
