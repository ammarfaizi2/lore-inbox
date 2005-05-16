Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261614AbVEPNVE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261614AbVEPNVE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 09:21:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261619AbVEPNVD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 09:21:03 -0400
Received: from mail.timesys.com ([65.117.135.102]:64241 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S261614AbVEPNUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 09:20:05 -0400
In-Reply-To: <20050514072826.GB20021@kroah.com>
Content-Type: multipart/signed;
	micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-cg8+jxunGCTiXu7nvkFA"
References: <1116011879.9050.92.camel@jmcmullan.timesys> <20050514072826.GB20021@kroah.com>
Date: Mon, 16 May 2005 09:20:01 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
X-Mailer: Evolution 2.0.4-3mdk 
Message-ID: <1116249602.9050.105.camel@jmcmullan.timesys>
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Subject: Re: [PATCH 2.6.11.7] ATA Over Ethernet Root, Mark 2
X-Mailer: Evolution 2.0.4-3mdk 
Date: Mon, 16 May 2005 09:14:02 -0400
Message-ID: <1116249602.9050.105.camel@jmcmullan.timesys>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2.6.11.7] ATA Over Ethernet Root, Mark 2
thread-index: AcVaGSD9hVpHLfkuTAC2SVoyRfFLPQ==
From: "McMullan, Jason" <jason.mcmullan@timesys.com>
To: "Greg KH" <greg@kroah.com>, <akpm@zip.com.au>
Cc: <ecashin@coraid.com>, "Linux Kernel" <linux-kernel@vger.kernel.org>,
       "PPC_LINUX" <linuxppc-embedded@ozlabs.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-cg8+jxunGCTiXu7nvkFA
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

[First off: Andrew, I'm sorry I didn't make it more clear that the AOE
 root patch was just for review, not for submission. Please remove it
 from -mm]


On Sat, 2005-05-14 at 00:28 -0700, Greg KH wrote:
> I'm guessing you are only testing this out on devfs?

  Yes. udev takes 5 minutes to complete on my 8mb, 100Mhz board.

> Why not fix this up properly, and allow root devices on _any_ type of
> block device that is not immediately present at "try to mount time"?  The
> USB and firewire users of the world will love you...

  Sure. No problem. Where is this patch you speak of?

> Also, please CC the aoe maintainer, that's documented in
> Documentation/SubmittingPatches :)

  I did to support@coraid.com, in a separate message.

> > +config ATA_OVER_ETH_ROOT_SHELF
> > +	int "Shelf ID"
> > +	depends on ATA_OVER_ETH_ROOT
>=20
> Ick.  Why not use a boot parameter if you really want to use something
> so icky (hint, we should rely on the name or major/minor, not something
> else like this.)

  Because kernel major/minor change dynamically based upon the number of
AOE blades on your LAN. As setting them in __setup() - sure, no problem,
this patch was just a 15 minute hack job.


> You do know devfs is going away in 2 months, right?

  Yes, much to my disappointment. udevd is so frick'n bloaty.

> Looks like you are mixing up shelf and slot values with major and minor
> numbers.  I'm confused.

  As was I. The original driver uses the words 'major' and 'minor' to
mean *both* kernel major/minor numbers and AOE blade slot/shelf IDs,
depending on context. Took me a bit to wrap my brain around it too.

> Should be in a separate patch, to fix up devfs issues in the driver,
> right?  This goes for the other devfs calls in this patch.  That is if
> you don't mind me removing them in 2 months :)

  Yeah, I know, I was just being lazy and using the uber-fast devfs.

> So, my main question is, why is this patch needed?  Is it because aoe
> devices aren't quite present and found quick enough during the boot
> process?

  Yep.

> If so, I suggest one of the two solutions:
> 	- do like the rest of the world does for usb and firewire and
> 	  other types of slow boot devices and use an initrd/initramfs
> 	  that mounts the root partition after it is properly found.
> 	  Distros do this all the time, so there are lots of examples to
> 	  pull from if you want to do this for yours.

   I only have 8Mb of RAM. No room for initrd.

> 	- fix up the patch that is floating around that allows the
> 	  kernel to pause and wait and not oops out if the root
> 	  partition is not found.  That way all users of all kinds of
> 	  slow devices can benefit, and driver specific hacks like this
> 	  are not needed.

   Again, this happy patch you speak of... Where can I find this wonder?

--=20
Jason McMullan <jason.mcmullan@timesys.com>
TimeSys Corporation


--=-cg8+jxunGCTiXu7nvkFA
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCiJ4B8/0vJ5szK6kRAg4OAJ9XJXTyrcC5Hje/Ph3XuNwAjOUP0gCcDqP6
J33zlnLk8kiLS54nWxoLnwY=
=6U2Z
-----END PGP SIGNATURE-----

--=-cg8+jxunGCTiXu7nvkFA--
