Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265966AbUFDUCV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265966AbUFDUCV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 16:02:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265964AbUFDUCV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 16:02:21 -0400
Received: from spock.bluecherry.net ([66.138.159.248]:42212 "EHLO
	spock.bluecherry.net") by vger.kernel.org with ESMTP
	id S265962AbUFDUCR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 16:02:17 -0400
Date: Fri, 4 Jun 2004 16:02:11 -0400
From: "Zephaniah E. Hull" <warp@babylon.d2dc.net>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org,
       "David A. Desrosiers" <desrod@gnu-designs.com>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: USBDEVFS_RESET deadlocks USB bus.
Message-ID: <20040604200211.GB3261@babylon.d2dc.net>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org,
	"David A. Desrosiers" <desrod@gnu-designs.com>,
	linux-usb-devel@lists.sourceforge.net
References: <20040604193911.GA3261@babylon.d2dc.net> <20040604195247.GA12688@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zx4FCpZtqtKETZ7O"
Content-Disposition: inline
In-Reply-To: <20040604195247.GA12688@kroah.com>
X-Notice-1: Unsolicited Commercial Email (Aka SPAM) to ANY systems under
X-Notice-2: our control constitutes a $US500 Administrative Fee, payable
X-Notice-3: immediately.  By sending us mail, you hereby acknowledge that
X-Notice-4: policy and agree to the fee.
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--zx4FCpZtqtKETZ7O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 04, 2004 at 12:52:47PM -0700, Greg KH wrote:
> On Fri, Jun 04, 2004 at 03:39:11PM -0400, Zephaniah E. Hull wrote:
> > Starting at 2.6.7-rc1 or so (that is when we first noticed it) the new
> > pilot-link libusb back end started deadlocking the entire USB bus that
> > the palm device was on.
> >=20
> > I have finally tracked it down to happening when we make the
> > USBDEVFS_RESET ioctl, we never return from it and from that point on the
> > bus in question is completely dead, no processing is done, no
> > notifications of devices being plugged in or unplugged.
> >=20
> > This is still happening in 2.6.7-rc2-mm1.
> >=20
> > It seems to happen with both the UHCI and OHCI back ends, so it is
> > probably above that.
> >=20
> > Given that there were heavy locking changes, I suspect that the case in
> > question got screwed up somehow.
>=20
> This needs to go to the linux-usb-devel list, now CC:

Whoops.
>=20
> Anyway, can you look at the output of SysRq-T and see where the
> processes are hung?

lt-pilot-xfer D 00000000     0 11415   2709                     (NOTLB)
d2ad3eb0 00000086 c022391a 00000000 3231203a 000a2e35 00000001 d2ad3ea7
       d4edd000 d7fc8a00 c8449790 00000000 abb31900 000f447a c4bae4b8 c977d=
824
       00000246 d2ad2000 d2ad3eec c0336735 c977d82c c4bae310 00000001 c4bae=
310
Call Trace:
 [<c0336735>] __down+0x85/0x120
 [<c033692f>] __down_failed+0xb/0x14
 [<c026af27>] .text.lock.hub+0x69/0x82
 [<c0272b7f>] usbdev_ioctl+0x19f/0x710
 [<c015a45d>] file_ioctl+0x5d/0x170
 [<c015a686>] sys_ioctl+0x116/0x250
 [<c0103f8f>] syscall_call+0x7/0xb

This is on 2.6.7-rc2-mm1.

Please keep me in the reply list if we are pulled off of linux-kernel,
as I am not currently on linux-usb-devel.

--=20
	1024D/E65A7801 Zephaniah E. Hull <warp@babylon.d2dc.net>
	   92ED 94E4 B1E6 3624 226D  5727 4453 008B E65A 7801
	    CCs of replies from mailing lists are requested.

<cas> well there ya go.  say something stupid in irc and have it
      immortalised forever in someone's .sig file

--zx4FCpZtqtKETZ7O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAwNVDRFMAi+ZaeAERAtdtAKDUSvqihJqQIWUoUdGUSTKZbVPOxQCfbU2Y
RcEEQ6Fd+CgOlXJudqWYaxw=
=vwlQ
-----END PGP SIGNATURE-----

--zx4FCpZtqtKETZ7O--
