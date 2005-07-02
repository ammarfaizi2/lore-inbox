Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261265AbVGBTEu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261265AbVGBTEu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Jul 2005 15:04:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261264AbVGBTEt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Jul 2005 15:04:49 -0400
Received: from smtp2.irishbroadband.ie ([62.231.32.13]:18393 "EHLO
	smtp2.irishbroadband.ie") by vger.kernel.org with ESMTP
	id S261259AbVGBTEj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Jul 2005 15:04:39 -0400
Subject: Re: aic7xxx regression occuring after 2.6.12 final
From: Tony Vroon <chainsaw@gentoo.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Andy Whitcroft <apw@shadowen.org>
In-Reply-To: <1120329389.5073.21.camel@mulgrave>
References: <1120085446.9743.11.camel@localhost>
	 <1120318925.21935.9.camel@localhost>  <1120321322.5073.4.camel@mulgrave>
	 <1120322788.22046.2.camel@localhost>  <1120323691.5073.12.camel@mulgrave>
	 <1120324426.21967.1.camel@localhost>  <1120325613.5073.16.camel@mulgrave>
	 <1120326423.22057.3.camel@localhost>  <1120329389.5073.21.camel@mulgrave>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-QP8h+ashCezb8Fh45Y+O"
Organization: Gentoo Linux
Date: Sat, 02 Jul 2005 20:03:46 +0100
Message-Id: <1120331026.22021.2.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-QP8h+ashCezb8Fh45Y+O
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2005-07-02 at 14:36 -0400, James Bottomley wrote:
> Well, I think this is it.  The drive is actually offering IU and QAS.
> That's fun; I've never seen a u160 drive that could do those before.

The Fujitsu is a U320 unit, just like my Seagate. It's just the
controller that's the limiting factor.

> Although the aic7xxx driver is apparently coded to allow this, it looks
> like the code paths have never been exercised.
> So, although I think this patch will fix up the first error, there's
> probably a long line behind it ...

As you predicted, it tried but gave up.

Output follows:
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec 29160 Ultra160 SCSI adapter>
        aic7892: Ultra160 Wide Channel A, SCSI Id=3D7, 32/253 SCBs

scsi0: Slave Alloc 0
(scsi0:A:0:0): Sending WDTR 0
(scsi0:A:0:0): Received WDTR 0 filtered to 0
 target0:0:0: FAST-5 SCSI 1.0 MB/s ST (1020 ns, offset 255)
scsi0: target 0 using 8bit transfers
(scsi0:A:0:0): Sending SDTR period 45, offset 0
(scsi0:A:0:0): Received SDTR period 45, offset 0
Filtered to period 0, offset 0
 target0:0:0: asynchronous.
scsi0: target 0 using asynchronous transfers
 Vendor: FUJITSU   Model: MAP3367NP         Rev: 0106
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0: Slave Configure 0
 target0:0:0: asynchronous.
scsi0:A:0:0:0: Tagged Queuing enabled.  Depth 32
 target0:0:0: Beginning Domain Validation
(scsi0:A:0:0): Sending WDTR 1
(scsi0:A:0:0): Received WDTR 1 filtered to 1
 target0:0:0: FAST-5 WIDE SCSI 2.0 MB/s ST (1020 ns, offset 255)
scsi0: target 0 using 16bit transfers
(scsi0:A:0:0): Sending SDTR period 45, offset 0
(scsi0:A:0:0): Received SDTR period 45, offset 0
Filtered to period 0, offset 0
 target0:0:0: wide asynchronous
scsi0: target 0 using asynchronous transfers
(scsi0:A:0:0): Sending PPR bus_width 1, period 9, offset 7f, ppr_options
7
(scsi0:A:0:0): Received PPR bus_width 1, period 9, offset 7f,
ppr_options 7
Filtered to width 1, period 9, offset 7f, options 7
 target0:0:0: FAST-80 WIDE SCSI 160.0 Mscsi0: target 0 synchronous at
80.0MHz DT, offset =3D 0x7
(scsi0:A:0:0): Unexpected busfree in Message-in phease
SEQADDR =3D=3D 0x16b
 target0:0:0: Write Buffer failure 70000
 target0:0:0: Domain Validation Disabling Information Units
(scsi0:A:0:0): Sending PPR bus_width 1, period 9, offset 7f, ppr_options
6
(scsi0:A:0:0): refuses tagged comands.  Performing non-tagged I/O
 target0:0:0: FAST-80 WIDE SCSI 160.0 MB/s ST IU (12.5 ns, offset 127)
*PC hangs here*


--=-QP8h+ashCezb8Fh45Y+O
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1-ecc0.1.6 (GNU/Linux)

iD8DBQBCxuUSp5vW4rUFj5oRArdHAKCStHOVfLADpCg2AoPIjTQfncnY3QCeJHM2
rYxzHxlKSQDVV3l0jdF+IA0=
=p94Q
-----END PGP SIGNATURE-----

--=-QP8h+ashCezb8Fh45Y+O--

