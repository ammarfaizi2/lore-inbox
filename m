Return-Path: <linux-kernel-owner+w=401wt.eu-S1751732AbXANX6T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751732AbXANX6T (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 18:58:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751735AbXANX6T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 18:58:19 -0500
Received: from iucha.net ([209.98.146.184]:39713 "EHLO mail.iucha.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751732AbXANX6S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 18:58:18 -0500
Date: Sun, 14 Jan 2007 17:58:17 -0600
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Jiri Kosina <jikos@jikos.cz>, linux-usb-devel@lists.sourceforge.net,
       Adrian Bunk <bunk@stusta.de>, Alan Stern <stern@rowland.harvard.edu>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: heavy nfs[4]] causes fs badness Was: 2.6.20-rc4: known unfixed regressions (v2)
Message-ID: <20070114235816.GB6053@iucha.net>
References: <20070109214431.GH24369@iucha.net> <Pine.LNX.4.44L0.0701101052310.3289-100000@iolanthe.rowland.org> <20070114225701.GA6053@iucha.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O5XBE6gyVG5Rl6Rj"
Content-Disposition: inline
In-Reply-To: <20070114225701.GA6053@iucha.net>
X-GPG-Key: http://iucha.net/florin_iucha.gpg
X-GPG-Fingerprint: 5E59 C2E7 941E B592 3BA4  7DCF 343D 2B14 2376 6F5B
User-Agent: Mutt/1.5.13 (2006-08-11)
From: florin@iucha.net (Florin Iucha)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--O5XBE6gyVG5Rl6Rj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 14, 2007 at 04:57:01PM -0600,  wrote:
> On Wed, Jan 10, 2007 at 10:54:34AM -0500, Alan Stern wrote:
> > It's still possible that this is hardware related; perhaps some compone=
nt
> > just began to wear out.  If you return to an earlier kernel, does the=
=20
> > problem go away?
>=20
> As reported in my original e-mail and verified just minutes ago, the
> copy succeeds with 2.6.19 (kernel.org vanilla, compiled with the same
> config as 2.6.20-rcX).  I will begin bisecting between .19 and .20-rc1
> after re-reading Jiri's messages.

All the testing was done via a ssh into the workstation.  The console
was left as booted into, with the gdm running.  The remote nfs4
directory was mounted on "/mnt".

After copying the 60+ GB and testing that the keyboard was still
functioning, I did not reboot but stayed in the same kernel and pulled
the latest git then started bisecting.  After recompiling, I moved
over to the workstation to reboot it, but the keyboard was not
functioning ;(

I ran "lsusb" and it displayed all the devices. "dmesg" did not show
any oops, anything for that matter.  I have unplugged the keyboard and
run "lsusb" again, but it hang.  I ran "ls /mnt" and it hang as well.
Stracing "lsusb" showed it hang (entered the kernel) at opening the device
that used to be the keyboard.  Stracing "ls /mnt" showed that it
hang at "stat(/mnt)".  Both processes were in "D" state.  "ls /root"
worked without problem, so it appears that crossing mountpoints causes
some hang in the kernel.

Based on this info, I think we can rule out any USB.  I will try
testing with NFS3 to see if the problem persists.  Unfortunately there
is no oops or anything in "dmesg".

florin

--=20
Bruce Schneier expects the Spanish Inquisition.
      http://geekz.co.uk/schneierfacts/fact/163

--O5XBE6gyVG5Rl6Rj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFFqsOYND0rFCN2b1sRAnI7AJ4ykBSkPaoxRoLDuXoJoHxY1drk/gCgqdOJ
WbfXOT6vh+/8Uh83CRi/Ubk=
=fUzK
-----END PGP SIGNATURE-----

--O5XBE6gyVG5Rl6Rj--
