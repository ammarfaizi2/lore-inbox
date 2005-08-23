Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932163AbVHWNA1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932163AbVHWNA1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 09:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932167AbVHWNA1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 09:00:27 -0400
Received: from port551.ds1-vbr.adsl.cybercity.dk ([217.157.134.120]:32079 "EHLO
	gateway.adsl.dk") by vger.kernel.org with ESMTP id S932163AbVHWNA0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 09:00:26 -0400
Date: Tue, 23 Aug 2005 15:00:23 +0200
From: Asser =?iso-8859-1?Q?Fem=F8?= <asser@diku.dk>
To: linux-cifs-client@lists.samba.org, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: dnotify/inotify and vfs questions
Message-ID: <20050823130023.GB8305@diku.dk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OwLcNYc0lM97+oe1"
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--OwLcNYc0lM97+oe1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I'm currently implementing change notification support for the linux
cifs client as part of Google's Summer of Code program.

In cifs, change notification works pretty much the same as dnotify does
in the kernel, and you cancel the notification by sending a NT_CANCEL
request.=20

According to the fcntl manual you can cancel a notification by doing
fcntl(fd, F_NOTIFY, 0) (ie. sending 0 as the notification mask), but
looking in the kernel code fcntl_dirnotify() immediately calls
dnotify_flush() with neither telling the vfs module about it. Is there a
reason for this?  Otherwise I'd propose calling
filp->f_op->dir_notify(filp, 0) at some point in this scenario.

Regarding inotify, inotify_add_watch doesn't seem to pass on the request
either, which works fine for local filesystem operations as they call
fsnotify_* functions every time, but that isn't really feasible for
filesystems like cifs because we'd have to request change notification
on everything. Is there plans for implementing a mechanism to let vfs
modules get watch requests too?

cheers,
Asser


--OwLcNYc0lM97+oe1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDCx3ncbr5RuS4SGcRAlQaAJ9egZeZGVNB+eRGfH66AjYHMAbB+gCfYaDu
qDFTyqi/ZYl1XXPN1woYaR4=
=XJtS
-----END PGP SIGNATURE-----

--OwLcNYc0lM97+oe1--
