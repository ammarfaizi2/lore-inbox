Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262426AbVGLVs4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262426AbVGLVs4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 17:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262475AbVGLVst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 17:48:49 -0400
Received: from postfix3-1.free.fr ([213.228.0.44]:25249 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S262426AbVGLVsb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 17:48:31 -0400
Message-ID: <42D43AA3.9040000@free.fr>
Date: Tue, 12 Jul 2005 23:48:19 +0200
From: Laurent Riffard <laurent.riffard@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.8) Gecko/20050511
X-Accept-Language: fr-fr, fr, en
MIME-Version: 1.0
To: Alasdair G Kergon <agk@redhat.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Felipe Alfaro Solana <felipe.alfaro@gmail.com>
Subject: Re: [PATCH] device-mapper: Fix target suspension oops.
References: <20050712021724.13b2297a.akpm@osdl.org> <42D41177.9020300@free.fr> <20050712204751.GB12341@agk.surrey.redhat.com> <20050712140248.3cdcb9b8.akpm@osdl.org> <20050712212449.GK12337@agk.surrey.redhat.com>
In-Reply-To: <20050712212449.GK12337@agk.surrey.redhat.com>
X-Enigmail-Version: 0.91.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE2C8265E9E72EE75CD15EBF6"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE2C8265E9E72EE75CD15EBF6
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


Le 12.07.2005 23:24, Alasdair G Kergon wrote:
> This section got lost while refactoring the 'Fix deadlocks in core' set
> of patches I sent yesterday.  Without it, you'll have problems
> activating any device-mapper devices.
>
> The NULL detection is moved inside the functions instead of every
> caller having to do it.
>
> --- drivers/md/dm-table.c	2005-07-12 22:10:20.000000000 +0100
> +++ /data/kernels/pm-2612udm1/source/drivers/md/dm-table.c	2005-07-06 18:52:18.000000000 +0100
> @@ -869,11 +869,17 @@
>
>  void dm_table_presuspend_targets(struct dm_table *t)
>  {
> +	if (!t)
> +		return;
> +
>  	return suspend_targets(t, 0);
>  }
>
>  void dm_table_postsuspend_targets(struct dm_table *t)
>  {
> +	if (!t)
> +		return;
> +
>  	return suspend_targets(t, 1);
>  }
>

Ok, it seems that it works well now.

[root@antares ~]# cat /proc/version
Linux version 2.6.13-rc2-mm2 (laurent@antares.localdomain) (gcc version 3.4.3 (Mandrakelinux 10.2 3.4.3-7mdk)) #104 Tue Jul 12 19:16:28 CEST 2005
[root@antares ~]# dmsetup table
vglinux1-lvhome: 0 7340032 linear 3:4 4604288
vglinux1-lvhome: 7340032 1048576 linear 3:4 14655872
vglinux1-lvtmp: 0 106496 linear 3:4 13238656
vglinux1-lvusr: 0 4194304 linear 3:4 409984
vglinux1-lvusr: 4194304 212992 linear 3:4 11944320
vglinux1-lvusr: 4407296 835584 linear 3:4 12403072
vglinux1-lvvar: 0 409600 linear 3:4 384
vglinux1-lvvar: 409600 245760 linear 3:4 12157312
crypt-swap2: 0 1590434 crypt aes-cbc-plain ad79bd09a98d3bf601bf15bb7cedd656ecd42fc1eb5c48822148de23ab724aad 0 3:71 0
crypt-swap1: 0 128457 crypt aes-cbc-plain 800d0c169e6e1b9dece5bfc645dfe08d61fd2d8a18f578c14501988cbf31590d 0 3:5 0
vglinux1-test: 0 1310720 linear 3:4 13345152
crypt-tmp: 0 106496 crypt aes-cbc-plain d3de9d10862e89107374542c0cedb569c16d637262f5537f2c96bfc20eb2c1c1 0 254:3 0


Thank you for your quickness, Alasdair.
--
laurent

--------------enigE2C8265E9E72EE75CD15EBF6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFC1DqrUqUFrirTu6IRAuDuAJ98ba/LwaFcbMQxFfTDD2JS+4e9+ACaA+G+
+5zqlQkgCeScZX8VDlfLWrk=
=BXv3
-----END PGP SIGNATURE-----

--------------enigE2C8265E9E72EE75CD15EBF6--
