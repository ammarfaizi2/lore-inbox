Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262135AbUCQXG3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 18:06:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262138AbUCQXG0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 18:06:26 -0500
Received: from lists.us.dell.com ([143.166.224.162]:40893 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S262135AbUCQXGT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 18:06:19 -0500
Date: Wed, 17 Mar 2004 17:05:40 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] move EDD code from i386-specific locations to generic
Message-ID: <20040317230540.GA30399@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Here are three patches following by mail to move the BIOS Enhanced
Disk Drive code from i386-specific locations into more generic
locations, which will allow it to be used on x86-64 as well.

01-edd-move-eddh.patch
EDD: move edd.h from include/asm-i386 to include/linux

Fix reference in setup.c=20

 b/arch/i386/kernel/setup.c |    2=20
 b/include/linux/edd.h      |  181 ++++++++++++++++++++++++++++++++++++++++=
+++++
 include/asm-i386/edd.h     |  180 ----------------------------------------=
----
 3 files changed, 182 insertions, 181 deletions


02-edd-move-eddc.patch
EDD: move edd.c from arch/i386/kernel to new dir drivers/firmware

Fix up makefiles and Kconfigs

 arch/i386/kernel/edd.c      |  837 ---------------------------------------=
-----
 b/arch/i386/Kconfig         |   11=20
 b/arch/i386/kernel/Makefile |    1=20
 b/drivers/Makefile          |    1=20
 b/drivers/firmware/Kconfig  |   19=20
 b/drivers/firmware/Makefile |    4=20
 b/drivers/firmware/edd.c    |  837 +++++++++++++++++++++++++++++++++++++++=
+++++
 7 files changed, 862 insertions, 848 deletions


03-edd-split-asm.patch
EDD: split EDD assembly code from setup.S into edd.S

This will enable it to be #included into x86-64 too.


 edd.S   |  127 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++
 setup.S |  125 -----------------------------------------------------------=
---
 2 files changed, 128 insertions, 124 deletions

Applies on top of 2.6.5-rc1-mm1.

Thanks,
Matt

--=20
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAWNnEIavu95Lw/AkRAs7FAJ4we15S/dwHHIw5n/k2kysZFDsy6wCcDN+9
AsrRED/4rIcb2ZPhcM1D3cc=
=aXlu
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
