Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263178AbUJ2Bxp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263178AbUJ2Bxp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 21:53:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263193AbUJ2ASv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 20:18:51 -0400
Received: from moraine.clusterfs.com ([66.246.132.190]:59301 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S263178AbUJ2AP1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 20:15:27 -0400
Date: Thu, 28 Oct 2004 18:15:24 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: How to safely reduce stack usage in nfs code?
Message-ID: <20041029001524.GR1343@schnapps.adilger.int>
Mail-Followup-To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <200410290020.01400.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="poemUeGtc2GQvHuH"
Content-Disposition: inline
In-Reply-To: <200410290020.01400.vda@port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--poemUeGtc2GQvHuH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Oct 29, 2004  00:20 +0300, Denis Vlasenko wrote:
> I've got one stack overflow sometime ago.
> Partially due to NFS stack usage.
>=20
> structs nfs_fh and nfs_fattr take together ~300 bytes
> and are one of the most frequently used:
>=20
> # cd fs/nfs; grep 'struct nfs_fh [a-z0-9_]*;' * ; grep 'struct nfs_fattr =
[a-z0-9_]*;' *
> callback.h:     struct nfs_fh fh;
> callback.h:     struct nfs_fh fh;
> dir.c:  struct nfs_fh fhandle;
> dir.c:  struct nfs_fh fhandle;
> dir.c:  struct nfs_fh fhandle;
> dir.c:  struct nfs_fh fhandle;
> dir.c:  struct nfs_fh sym_fh;
> nfsroot.c:      struct nfs_fh fh;
> dir.c:  struct nfs_fattr fattr;
> dir.c:  struct nfs_fattr fattr;
> dir.c:  struct nfs_fattr fattr;
> dir.c:  struct nfs_fattr fattr;
> dir.c:  struct nfs_fattr fattr;
> dir.c:  struct nfs_fattr sym_attr;
> inode.c:        struct nfs_fattr fattr;
> inode.c:        struct nfs_fattr fattr;
> inode.c:        struct nfs_fattr fattr;
> nfs3proc.c:             struct nfs_fattr res;
> nfs4proc.c:                     struct nfs_fattr fattr;
>=20
> I can convert these into kmalloc'ed variants but hesitate to do so
> because of possible 'need to kmalloc in order to free memory for kmalloc'
> deadlocks.

Make the thread kmalloc unless it has PF_MEMALLOC set, in which case it
could get the structs from a small pool of reserved ones.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://members.shaw.ca/adilger/             http://members.shaw.ca/golinux/


--poemUeGtc2GQvHuH
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFBgYucpIg59Q01vtYRAnWdAJ9WMYJSg+oZ+/1tkuRS+h0KEjhs1ACgmJSp
H+1NIikvMdTV2o2OSGXZutM=
=ZkxI
-----END PGP SIGNATURE-----

--poemUeGtc2GQvHuH--
