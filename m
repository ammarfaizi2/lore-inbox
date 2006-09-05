Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965132AbWIEVpf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965132AbWIEVpf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 17:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751504AbWIEVpf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 17:45:35 -0400
Received: from orca.ele.uri.edu ([131.128.51.63]:36588 "EHLO orca.ele.uri.edu")
	by vger.kernel.org with ESMTP id S1751506AbWIEVpe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 17:45:34 -0400
Date: Tue, 5 Sep 2006 17:47:04 -0400
From: Will Simoneau <simoneau@ele.uri.edu>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, ext4 <linux-ext4@vger.kernel.org>
Subject: Re: BUG: warning at fs/ext3/inode.c:1016/ext3_getblk()
Message-ID: <20060905214703.GA16449@ele.uri.edu>
References: <20060905171049.GB27433@ele.uri.edu> <44FDE6E5.3090009@us.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
Content-Disposition: inline
In-Reply-To: <44FDE6E5.3090009@us.ibm.com>
User-Agent: Mutt/1.5.13 [Linux 2.6.17.11-grsec-b0rg i686]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 14:06 Tue 05 Sep     , Badari Pulavarty wrote:
> Will Simoneau wrote:
> >Has anyone seen this before? These three traces occured at different tim=
es
> >today when three new user accounts (and associated quotas) were created.=
=20
> >This
> >machine is an NFS server which uses quotas on an ext3 fs (dir_index is o=
n).
> >Kernel is 2.6.17.11 on an x86 smp w/64G highmem; 4G ram is installed. The
> >affected filesystem is on a software raid1 of two hardware raid0 volumes=
=20
> >from a
> >megaraid card.
> >
> >BUG: warning at fs/ext3/inode.c:1016/ext3_getblk()
> > <c01c5140> ext3_getblk+0x98/0x2a6  <c03b2806> md_wakeup_thread+0x26/0x2a
> > <c01c536d> ext3_bread+0x1f/0x88  <c01cedf9> ext3_quota_read+0x136/0x1ae
> > <c018b683> v1_read_dqblk+0x61/0xac  <c0188f32> dquot_acquire+0xf6/0x107
> > <c01ceaba> ext3_acquire_dquot+0x46/0x68  <c01897d4> dqget+0x155/0x1e7
> > <c018a97b> dquot_transfer+0x3e0/0x3e9  <c016fe52> dput+0x23/0x13e
> >=20
> Made me curious and looking around on what the warning is coming ? Few=20
> basic questions ..
> Do you have CONFIG_LBD ?
>=20
> I see the ext3_getblk() used "long" for "block" &=20
> ext3_get_blocks_handle() expects "sector_t"
> for "block". Wondering if you are running into 64-bit -to- 32-bit=20
> conversion issues .. ?
>=20
> Thanks,
> Badari
>=20

CONFIG_LBD is on. GCC is 'Gentoo 3.3.5.20050130-r1', if it matters.
FWIW, the machine is running 32-bit, although the cpus appear to support
EM64T. The filesystem's size is 138410144 1k-blocks; ext3 is using 4k
blocks/inodes.

This was not a problem on the previous kernel which was 2.6.13-rc3 with
the assert on net/ipv4/tcp_output.c:918 disabled (from memory, even the
line number ;-) ).

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFE/fBXLYBaX8VDLLURAiyvAJ47xXVBg6FJlLK/u7Bn0gHOaSzmnQCgrC5t
DIyXsVcAEbKqvQNpamDaV/g=
=GdHi
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--
