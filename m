Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292327AbSBPJNu>; Sat, 16 Feb 2002 04:13:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292328AbSBPJNk>; Sat, 16 Feb 2002 04:13:40 -0500
Received: from [193.154.7.22] ([193.154.7.22]:39488 "EHLO
	freedom.icomedias.com") by vger.kernel.org with ESMTP
	id <S292327AbSBPJN3> convert rfc822-to-8bit; Sat, 16 Feb 2002 04:13:29 -0500
Subject: AW: Need to force IDE geometry
Date: Sat, 16 Feb 2002 10:13:20 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <D143FBF049570C4BB99D962DC25FC2D203B821@freedom.icomedias.com>
X-MS-Has-Attach: 
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
X-MS-TNEF-Correlator: 
Thread-Topic: Need to force IDE geometry
Thread-Index: AcG2yi0vJFzBy0/fTj6sO91tYdMYTg==
From: "Martin Bene" <martin.bene@icomedias.com>
To: <Andries.Brouwer@cwi.nl>, <john@mwk.co.nz>, <linux-kernel@vger.kernel.org>
Cc: <andre@linux-ide.org>, <hugo@firstlinux.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andries,

> Your question is based on your assumptions about geometry
> and LBA. But your assumptions are incorrect, and therefore
> your questions do not make sense. Please tell what you do
> and what error messages you get.

For some reasons the c/h/s settings reported for LBA disks depend on ide device number: /hda uses 255 heads, 63 sectors while /dev/hdc and above use 16 head, 63 sectors.

hda: 150136560 sectors (76870 MB) w/1916KiB Cache, CHS=9345/255/63, UDMA(33)
hdb: 150136560 sectors (76870 MB) w/1916KiB Cache, CHS=148945/16/63, UDMA(33)
hdc: 150136560 sectors (76870 MB) w/1916KiB Cache, CHS=148945/16/63, UDMA(33)

As you can see, this means you end up with different reported drive geometries for identical disks. Esp. if you want to use software raid this is a major nuisance. The usual workaround is to change head/cylinder settings when first partitioning the drive and let linux change the geometry during partition table check.

Partition check:
 hda: hda1 hda2 < hda5 hda6 > hda3
 hdb: [PTBL] [9345/255/63] hdb1 hdb2 < hdb5 hdb6 > hdb3
 hdc: [PTBL] [9345/255/63] hdc1 hdc2 < hdc5 hdc6 > hdc3

While this works, it's quite unintuitive and confusing; correct behaviour would be to treat all disks identicaly regardless of device number.

Bye, Martin
