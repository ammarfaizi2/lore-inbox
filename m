Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130705AbQJ1Dvl>; Fri, 27 Oct 2000 23:51:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130821AbQJ1Dvb>; Fri, 27 Oct 2000 23:51:31 -0400
Received: from [216.161.55.93] ([216.161.55.93]:2553 "EHLO blue.int.wirex.com")
	by vger.kernel.org with ESMTP id <S130705AbQJ1DvU>;
	Fri, 27 Oct 2000 23:51:20 -0400
Date: Fri, 27 Oct 2000 20:57:03 -0700
From: Greg KH <greg@wirex.com>
To: Keith Owens <kaos@ocs.com.au>, "Dunlap, Randy" <randy.dunlap@intel.com>
Cc: "'Hunt Kent'" <kenthunt@yahoo.com>,
        "'lmcclef@lmc.ericsson.se'" <lmcclef@lmc.ericsson.se>,
        "'f5ibh@db0bm.ampr.org'" <f5ibh@db0bm.ampr.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: test[9-10] USB depmod unresolved symbols
Message-ID: <20001027205703.A17904@wirex.com>
Mail-Followup-To: Greg KH <greg@wirex.com>, Keith Owens <kaos@ocs.com.au>,
	"Dunlap, Randy" <randy.dunlap@intel.com>,
	'Hunt Kent' <kenthunt@yahoo.com>,
	"'lmcclef@lmc.ericsson.se'" <lmcclef@lmc.ericsson.se>,
	"'f5ibh@db0bm.ampr.org'" <f5ibh@db0bm.ampr.org>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
In-Reply-To: <D5E932F578EBD111AC3F00A0C96B1E6F07DBDB99@orsmsx31.jf.intel.com> <4565.972696579@ocs3.ocs-net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <4565.972696579@ocs3.ocs-net>; from kaos@ocs.com.au on Sat, Oct 28, 2000 at 12:29:39PM +1100
X-Operating-System: Linux 2.2.17-immunix (i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Thanks Keith for that detailed description of what is going wrong, I
would have never figured that out.

On Sat, Oct 28, 2000 at 12:29:39PM +1100, Keith Owens wrote:
>=20
> I will add LINK_FIRST and LINK_LAST to kbuild this weekend and
> reinstate the missing lines in drivers/usb/Makefile.  What I need from
> the USB group is a documented (i.e. *why* is this order required)
> definition of what needs to be linked first into usbdrv.o, and somebody
> we can query if there are problems in the future.  It will probably be
> as simple as

Yeah, a valid reason for LINK_FIRST and LINK_LAST!

I'll try my hand at the wording. Randy, does this look acceptable:

# usb.o contains __init usb_init which must be executed before all
# other usb __init routines, the remaining usb __init routines can be
# executed in any order.  Execution order of __init routines depends
# on link order so usb.o must be linked first.  Otherwise, the
# individual drivers will be initialized before the hub driver is,
# causing the hub driver initialization sequence to needlessly probe
# every USB driver with the root hub device.  This causes a lot of
# unnecessary system log messages, a lot of user confusion, and has
# been known to cause a incorrectly programmed USB device driver to
# grab the root hub device improperly.
#     Greg Kroah-Hartman, 27 Oct 2000

LINK_FIRST :=3D usb.o

> but you know better than I what the required order will be and why.
> Are there any other link order problems in USB?

That's the only known link problem for the USB drivers.

Thanks,

greg k-h

--=20
greg@(kroah|wirex).com
http://immunix.org/~greg

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.3 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE5+k6PAl5ylTeuKpURAqhnAKCIMUgqe3tpnSDF06sbQyExNQ8dkQCeOCp1
TcitL/p6855crcbmPLDvwP8=
=KM1u
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
