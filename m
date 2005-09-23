Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750916AbVIWMTn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750916AbVIWMTn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 08:19:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750919AbVIWMTn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 08:19:43 -0400
Received: from pih-relay04.plus.net ([212.159.14.131]:58798 "EHLO
	pih-relay04.plus.net") by vger.kernel.org with ESMTP
	id S1750912AbVIWMTn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 08:19:43 -0400
Date: Fri, 23 Sep 2005 13:19:32 +0100
From: Chris Sykes <chris@sigsegv.plus.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, ext2-devel@lists.sourceforge.net
Subject: Re: Hang during rm on ext2 mounted sync (2.6.14-rc2+)
Message-ID: <20050923121932.GA5395@sigsegv.plus.com>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>, ext2-devel@lists.sourceforge.net
References: <20050922163708.GF5898@sigsegv.plus.com> <20050923015719.5eb765a4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Content-Disposition: inline
In-Reply-To: <20050923015719.5eb765a4.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 23, 2005 at 01:57:19AM -0700, Andrew Morton wrote:
> Odd.  Seems OK here.  How hard is it to make it occur?

The following always works first time on an affected kernel (I'm just
mimmicing that update-grub did at the point it hung on me):

cd /to_ext2_fs_mounted_with_sync
cp /boot/grub/menu.lst menu.lst.new
cat menu.lst.new >menu.lst
rm menu.lst.new

> I'd be suspecting a lost I/O completion from the device driver.  Are you
> really sure that ext3 cannot be made to do the same thing?

I just ran the above 1000 times on 2.6.13-git10 (also affected), on
ext3, no hung rm process.
Running on ext2, rm hangs first time.

> Suggest you generate the `dmesg -s 1000000' output for both good and bad
> kernels, do a `diff -u' on them and look for IDE complaints (or SCSI, if
> you're on SCSI).

OK will do.

Initial testing suggests that 2.6.13-git9 is good while 2.6.13-git10
that I'm running now fails.  I'll verify this and have a look at dmesg
output as well.

--=20

(o-  Chris Sykes
//\       "Don't worry. Everything is getting nicely out of control ..."
V_/_                          Douglas Adams - The Salmon of Doubt
GPG Fingerprint: 5E8E D17F F96C CC08 911D  CAF2 9049 70D8 5143 8090

--DocE+STaALJfprDB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFDM/LUkElw2FFDgJARAjg1AJ98ITLu0pSQDmlG1UfGPFewDcZ60QCeLnW3
7QNeuvvWhjOsPWaZh5IRgNg=
=SngE
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--
