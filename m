Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131341AbQLMXoW>; Wed, 13 Dec 2000 18:44:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131520AbQLMXoM>; Wed, 13 Dec 2000 18:44:12 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:12417 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S131341AbQLMXn7>; Wed, 13 Dec 2000 18:43:59 -0500
Date: Wed, 13 Dec 2000 23:13:32 +0000
From: Tim Waugh <twaugh@redhat.com>
To: Peter Bornemann <eduard.epi@t-online.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: parport1 gone in 2.2.18
Message-ID: <20001213231332.P5918@redhat.com>
In-Reply-To: <Pine.LNX.4.21.0012132059530.1616-100000@eduard.t-online.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="iK/wEI4vkfDmI6Zw"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0012132059530.1616-100000@eduard.t-online.de>; from eduard.epi@t-online.de on Wed, Dec 13, 2000 at 09:01:56PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--iK/wEI4vkfDmI6Zw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 13, 2000 at 09:01:56PM +0100, Peter Bornemann wrote:

> I have a second parport installed as a PCI-card. In earlier Linux-versions
> this would lock the machine completely if parport & Co where compiled as
> modules (2.2.16 and 2.2.17). Compiled into the kernel however, everything
> worked fine. I wrote about that to LK, but no solution was found. Now in
> 2.2.18 it is the other way round, modules work with the proper
> initialization in modules.conf, but if compiled into the kernel, the
> second parport vanishes completely.

The problem was that there are many more Timedia cards than I
realised, and they are only distinguishable from each other by their
subdevice ID (vendor and device isn't enough).  So we were probably
using the wrong BARs, which probably caused the freezes you saw.

The 2.4.x parport_pc card table can deal with this; the 2.2.x
parport_pc card table can't.  So rather than leave a potential freeze
in I pulled those cards from the table altogether.  Sorry if I didn't
tell you this.

For 2.2.19 I'm hoping to backport the 2.4.x parport_pc card table
structure if Alan doesn't think that's too big a change.

The reason it works for you with modules is probably because you have
an options line in /etc/modules.conf that tells parport_pc which
addresses your PCI card is using at the moment.

Tim.
*/

--iK/wEI4vkfDmI6Zw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6OAKcONXnILZ4yVIRAgRgAJ94XEEY/F/LsjfNw10B7mydLh2KsACfd+Jl
gIniSdFrLs5dGYI6tSt6Ztc=
=4Og/
-----END PGP SIGNATURE-----

--iK/wEI4vkfDmI6Zw--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
