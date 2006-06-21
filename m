Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932262AbWFUQv3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932262AbWFUQv3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 12:51:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932263AbWFUQv3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 12:51:29 -0400
Received: from mivlgu.ru ([81.18.140.87]:57503 "EHLO master.mivlgu.local")
	by vger.kernel.org with ESMTP id S932262AbWFUQv2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 12:51:28 -0400
Date: Wed, 21 Jun 2006 20:51:26 +0400
From: Sergey Vlasov <vsu@altlinux.ru>
To: Andi Kleen <ak@suse.de>
Cc: Arjan van de Ven <arjan@infradead.org>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86_64: Do not use -ffunction-sections for modules
Message-ID: <20060621165126.GB4126@master.mivlgu.local>
References: <11509074684035-git-send-email-vsu@altlinux.ru> <200606211841.33220.ak@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eJnRUKwClWJh1Khz"
Content-Disposition: inline
In-Reply-To: <200606211841.33220.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--eJnRUKwClWJh1Khz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 21, 2006 at 06:41:33PM +0200, Andi Kleen wrote:
> The correct mailing list is still discuss@x86-64.org

Noted.

> On Thursday 01 January 1970 01:00, Sergey Vlasov wrote:
> > Currently CONFIG_REORDER uses -ffunction-sections for all code;
> > however, creating a separate section for each function is not useful
> > for modules and just adds bloat.=20
>=20
> You mean the ELF files are larger?

Yes, and all these sections are then reported in sysfs (BTW, what programs
really use /sys/module/*/sections/* files?).

> .text/.data size shouldn't > change in theory.

Actually, it does change by a small amount for some reason - even
increases by about 100 bytes in some cases; however, I suppose that the
size reported by /proc/modules and lsmod is more important, and it
decreases:

before:
ext3                  138896  4=20
jbd                    58152  1 ext3
mbcache                10248  1 ext3
sata_nv                11140  13=20
libata                 75928  1 sata_nv
sd_mod                 21912  6=20
scsi_mod              155824  3 usb_storage,libata,sd_mod
ide_disk               17536  0=20
ide_generic             1664  0 [permanent]
amd74xx                15280  0 [permanent]
generic                 5892  0 [permanent]
ide_core              150624  6 ide_cd,usb_storage,ide_disk,ide_generic,amd=
74xx,generic

after:
ext3                  129040  4=20
jbd                    53672  1 ext3
mbcache                 9608  1 ext3
sata_nv                10756  13=20
libata                 69784  1 sata_nv
sd_mod                 20760  6=20
scsi_mod              145200  3 usb_storage,libata,sd_mod
ide_disk               16384  0=20
ide_generic             1664  0 [permanent]
amd74xx                14896  0 [permanent]
generic                 5764  0 [permanent]
ide_core              140768  6 ide_cd,usb_storage,ide_disk,ide_generic,amd=
74xx,generic

--eJnRUKwClWJh1Khz
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFEmXkOW82GfkQfsqIRAqRLAJ4rxkZ+5+H6HAN1UeIRke2JzHMlLACfT4qE
p6WE33TGg+wYC+SZCm5sdnE=
=7hRF
-----END PGP SIGNATURE-----

--eJnRUKwClWJh1Khz--
