Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751139AbWBLQ2b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbWBLQ2b (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 11:28:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbWBLQ2b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 11:28:31 -0500
Received: from locomotive.csh.rit.edu ([129.21.60.149]:19543 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S1751139AbWBLQ2b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 11:28:31 -0500
Date: Sun, 12 Feb 2006 11:28:29 -0500
From: Jeff Mahoney <jeffm@suse.com>
To: art <art@usfltd.com>
Cc: linux-kernel@vger.kernel.org, Chris Mason <mason@suse.com>,
       Hans Reiser <reiser@namesys.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: kernel-2.6.16-rc2-git8 - reiserfs - write problem !!!
Message-ID: <20060212162829.GA5190@locomotive.unixthugs.org>
References: <200602120156.AA112460246@usfltd.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Content-Disposition: inline
In-Reply-To: <200602120156.AA112460246@usfltd.com>
X-Operating-System: Linux 2.6.5-7.201-smp (i686)
X-GPG-Fingerprint: A16F A946 6C24 81CC 99BB  85AF 2CF5 B197 2B93 0FB2
X-GPG-Key: http://www.csh.rit.edu/~jeffm/jeffm.gpg
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 12, 2006 at 01:56:52AM -0600, art wrote:
> kernel-2.6.16-rc2-git9     BAD
>=20
> looks like system automaticly sets attribs mounting reiserfs
>=20
> "A file with the `i' attribute cannot be modified: it cannot be deleted o=
r renamed, no link can be created to this file and no data can be written t=
o the file. Only the superuser or a process possessing the CAP_LINUX_IMMUTA=
BLE capability can set or clear this attribute."
>=20
> "A file with the `a' attribute set can only be open in append mode for wr=
iting. Only the superuser or a process possessing the CAP_LINUX_IMMUTABLE c=
apability can set or clear this attribute."

Ok. That's what I was afraid of. If this isn't your root file system, you
can clear the attributes with reiserfsck --clean-attributes <device>, and
it will fix the problem.

Unfortunately, this is hardly a solution, since this is a change that causes
unexpected and unpredictable results on file systems in use.

Andrew -

Since the attr-bits-cleared bit can't be trusted, I don't think we'll ever =
be
able to enable reiserfs inode attrs by default. I'll send a patch separately
to back out this behavior.

-Jeff

--=20
Jeff Mahoney
SuSE Labs

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFD72IrLPWxlyuTD7IRAik0AJ9vQgfRtoM4x/u35iK9TTR0OrUw8wCdFTKp
HGffCqISbDWQ6021C9dw7X8=
=xD6S
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--
