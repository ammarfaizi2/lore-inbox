Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750783AbWEZSzW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbWEZSzW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 14:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbWEZSzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 14:55:21 -0400
Received: from lame.durables.org ([64.81.244.120]:678 "EHLO lame.durables.org")
	by vger.kernel.org with ESMTP id S1750783AbWEZSzV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 14:55:21 -0400
Subject: Question about dma_alloc_coherent and iommu
From: Robert Walsh <rjwalsh@durables.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-cQ2G+7ML3GvEX4QHIEs8"
Date: Fri, 26 May 2006 11:55:18 -0700
Message-Id: <1148669718.3665.11.camel@phosphene.durables.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-cQ2G+7ML3GvEX4QHIEs8
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi there,

Our driver (the ipath driver in drivers/infiniband) uses
dma_alloc_coherent to allocate buffers that our device will DMA into.
We use a 64-bit DMA mask.  Although we don't set a consistent DMA mask,
it doesn't seem to matter whether we do or not for the following
problem.

Everything works fine on 2.6.16: when the device tells us it's DMA'd
into a buffer, the data is there and everyone is happy.  It also works
fine on kernels from 2.6.9 through 2.6.15, but only as long as there is
4GB or less of memory on the machine.  On our machines with > 4GB
memory, the buffers do not appear to have had anything DMA'd into them.

If we use "iommu=3Doff" on the kernel boot line, the problem goes away and
the data starts appearing.

Has anyone seen this behaviour on other devices?  Are we missing
something in the device setup, maybe?  As I mentioned, setting a
consistent DMA mask doesn't help, no matter whether we set it to 64-bits
or 32-bits.  Setting the regular DMA mask to 32-bits doesn't help
either: the problem still crops up.

Regards,
 Robert.

--=20
Robert Walsh
Amalgamated Durables, Inc.  -  "We don't make the things you buy."
Email: rjwalsh@durables.org

--=-cQ2G+7ML3GvEX4QHIEs8
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBEd08WbZtqSALM5CYRAshNAJ9BTUO12N/vBI2/ss/6BkuGOS1oEwCg43rt
CZCYY5dmZFhuf6GIEdShHlg=
=NSBX
-----END PGP SIGNATURE-----

--=-cQ2G+7ML3GvEX4QHIEs8--

