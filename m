Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269571AbUINRCt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269571AbUINRCt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 13:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269574AbUINQ5A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 12:57:00 -0400
Received: from moraine.clusterfs.com ([66.246.132.190]:64949 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S269595AbUINQds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 12:33:48 -0400
Date: Tue, 14 Sep 2004 10:33:47 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org, Trond Myklebust <trond.myklebust@fys.uio.no>,
       netdev@oss.sgi.com
Subject: Re: Kernel stack overflow on 2.6.9-rc2
Message-ID: <20040914163347.GE3197@schnapps.adilger.int>
Mail-Followup-To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
	linux-kernel@vger.kernel.org,
	Trond Myklebust <trond.myklebust@fys.uio.no>, netdev@oss.sgi.com
References: <200409141723.35009.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gDGSpKKIBgtShtf+"
Content-Disposition: inline
In-Reply-To: <200409141723.35009.vda@port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gDGSpKKIBgtShtf+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep 14, 2004  17:23 +0300, Denis Vlasenko wrote:
> I am putting to use an ancient box. Pentium 66.
> It gives me stack overflow errors on 2.6.9-rc2:
>=20
> To save you filtering out functions with less than 100
> bytes of stack:
>=20
> udp_sendmsg+0x35e/0x61a [220]
> sock_sendmsg+0x88/0xa3 [208]
> __nfs_revalidate_inode+0xc7/0x308 [152]
> nfs_lookup_revalidate+0x257/0x4ed [312]
> load_elf_binary+0xc4f/0xcc8 [268]
> load_script+0x1ea/0x220 [136]
> do_execve+0x153/0x1b9 [336]

do_execve() can be trivially fixed to allocate bprm (328 bytes) instead=20
putting it on the stack.  Given the frequency of exec and the odd size
it should probably be in its own slab (and fix the goofy prototype
indenting while you're there too ;-).

load_elf_binary() on the other hand is a big mess, 132 bytes of int/long
variables.

nfs_lookup_revalidate() has 2 large structs on the stack, fhandle and fattr.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://members.shaw.ca/adilger/             http://members.shaw.ca/golinux/


--gDGSpKKIBgtShtf+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFBRx1qpIg59Q01vtYRAlyQAKCsBAF7suX4kERQPLicYhoDRWplLACfW2ZZ
f1CYZH/pNdU19NpgsQO9aaw=
=pk5q
-----END PGP SIGNATURE-----

--gDGSpKKIBgtShtf+--
