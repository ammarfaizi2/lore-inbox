Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262730AbUA3THw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 14:07:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263539AbUA3THp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 14:07:45 -0500
Received: from smtp04.web.de ([217.72.192.208]:24849 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S262730AbUA3THj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 14:07:39 -0500
From: Thomas Schlichter <thomas.schlichter@web.de>
To: Torrey Hoffman <thoffman@arnor.net>, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.2-rc2-mm2
Date: Fri, 30 Jan 2004 20:07:21 +0100
User-Agent: KMail/1.5.4
Cc: Linux-Kernel List <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
References: <20040130014108.09c964fd.akpm@osdl.org> <1075489136.5995.30.camel@moria.arnor.net>
In-Reply-To: <1075489136.5995.30.camel@moria.arnor.net>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-03=_utqGAeg7h+v56q4";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200401302007.26333.thomas.schlichter@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-03=_utqGAeg7h+v56q4
Content-Type: multipart/mixed;
  boundary="Boundary-01=_ptqGAfHQe3j35Yq"
Content-Transfer-Encoding: 7bit
Content-Description: signed data
Content-Disposition: inline

--Boundary-01=_ptqGAfHQe3j35Yq
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Description: body text
Content-Disposition: inline

Am Freitag, 30. Januar 2004 19:58 schrieb Torrey Hoffman:
> On Fri, 2004-01-30 at 01:41, Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.2-rc2/2
> >.6.2-rc2-mm2/
>
> I used the rc2-mm1-1 patch and got this on make modules_install:
>
> WARNING: /lib/modules/2.6.2-rc2-mm2/kernel/net/sunrpc/sunrpc.ko needs
> unknown symbol groups_free
> WARNING: /lib/modules/2.6.2-rc2-mm2/kernel/fs/nfsd/nfsd.ko needs unknown
> symbol sys_setgroups
>
> Same .config had no problems in 2.6.2-rc2-mm1.

The attached patches make it work for me...

Best regards
  Thomas Schlichter

--Boundary-01=_ptqGAfHQe3j35Yq
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="export-groups_free.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="export-groups_free.diff"

Export the symbol 'groups_free' to fix following problem:
WARNING: /lib/modules/2.6.2-rc2-mm2/kernel/net/sunrpc/sunrpc.ko needs unkno=
wn symbol groups_free
=2D-- linux-2.6.2-rc2-mm2/kernel/sys.c~	2004-01-30 12:44:00.000000000 +0100
+++ linux-2.6.2-rc2-mm2/kernel/sys.c	2004-01-30 14:12:43.611175872 +0100
@@ -1140,6 +1140,8 @@ void groups_free(struct group_info *grou
 	kfree(group_info);
 }
=20
+EXPORT_SYMBOL(groups_free);
+
 /* export the group_info to a user-space array */
 static int groups_to_user(gid_t __user *grouplist,
     struct group_info *group_info)

--Boundary-01=_ptqGAfHQe3j35Yq
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="export-sys_setgroups.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="export-sys_setgroups.diff"

Export the symbol 'sys_setgroups' to fix the following problem:
WARNING: /lib/modules/2.6.2-rc2-mm2/kernel/fs/nfsd/nfsd.ko needs unknown sy=
mbol sys_setgroups
=2D-- linux-2.6.2-rc2-mm2/kernel/sys.c~	2004-01-30 14:16:19.517353144 +0100
+++ linux-2.6.2-rc2-mm2/kernel/sys.c	2004-01-30 14:58:55.171834608 +0100
@@ -1312,6 +1312,8 @@ asmlinkage long sys_setgroups(int gidset
 	return retval;
 }
=20
+EXPORT_SYMBOL(sys_setgroups);
+
 /*
  * Check whether we're fsgid/egid or in the supplemental group..
  */

--Boundary-01=_ptqGAfHQe3j35Yq--

--Boundary-03=_utqGAeg7h+v56q4
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQBAGqtuYAiN+WRIZzQRAm9HAKCvJhbzXBnsKKbEu7x8X4en7d0tKQCgrmn2
C3lb48e6/AiDZ1LnXZUqdiI=
=1B4/
-----END PGP SIGNATURE-----

--Boundary-03=_utqGAeg7h+v56q4--

