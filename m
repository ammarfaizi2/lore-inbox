Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261633AbSI0Fqp>; Fri, 27 Sep 2002 01:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261634AbSI0Fqp>; Fri, 27 Sep 2002 01:46:45 -0400
Received: from smtp2.san.rr.com ([24.25.195.39]:8946 "EHLO smtp2.san.rr.com")
	by vger.kernel.org with ESMTP id <S261633AbSI0Fqn>;
	Fri, 27 Sep 2002 01:46:43 -0400
Date: Thu, 26 Sep 2002 22:41:53 -0700
From: Andrew Vasquez <praka@san.rr.com>
To: Mike Anderson <andmike@us.ibm.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Michael Clark <michael@metaparadigm.com>,
       "David S. Miller" <davem@redhat.com>, wli@holomorphy.com, axboe@suse.de,
       akpm@digeo.com, linux-kernel@vger.kernel.org, patmans@us.ibm.com,
       andrew.vasquez@qlogic.com
Subject: Re: [PATCH] deadline io scheduler
Message-ID: <20020927054153.GA27698@praka.local.home>
Mail-Followup-To: Andrew Vasquez <praka@san.rr.com>,
	Mike Anderson <andmike@us.ibm.com>, Jeff Garzik <jgarzik@pobox.com>,
	Michael Clark <michael@metaparadigm.com>,
	"David S. Miller" <davem@redhat.com>, wli@holomorphy.com,
	axboe@suse.de, akpm@digeo.com, linux-kernel@vger.kernel.org,
	patmans@us.ibm.com, andrew.vasquez@qlogic.com
References: <3D92B450.2090805@pobox.com> <20020926.001343.57159108.davem@redhat.com> <3D92B83E.3080405@pobox.com> <20020926.003503.35357667.davem@redhat.com> <3D92C206.2050905@metaparadigm.com> <20020926174148.GB1843@beaverton.ibm.com> <3D934BE7.8010907@pobox.com> <20020926192106.GD1843@beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
In-Reply-To: <20020926192106.GD1843@beaverton.ibm.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.4.18-4GB
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 26 Sep 2002, Mike Anderson wrote:

> Jeff Garzik [jgarzik@pobox.com] wrote:
> > Has anybody put work into cleaning this driver up?
> >=20
> > The word from kernel hackers that work on it is, they would rather writ=
e=20
> > a new driver than spend weeks cleaning it up :/
> >=20
>=20
> Andrew Vasquez from Qlogic can provide more detailed comments on deltas
> between the versions of the driver.
>=20
> The v6.x driver is cleaner and supporting newer kernel interfaces than
> past versions.
>=20
All,

I believe we had made some significant progress over the past few
months at delivering a reasonably stable and maintainable device
driver for ISP2100/ISP22xx/ISP23xx chips.  Our original goals for the
6.x series driver included:

	o Stability
		- Failover
		- Fabric topologies
		- Kernel interface integrations

	o Maintainability
		- Code sanitization!
		- Strip dead-code and support for kernels < 2.4.

	o Feature integrations
		- Fast-path streamlining
		- RIO/ZIO
		- IP via FC
		- ISP2100 support=20
		- ...

Note:
Most if not all of Arjan van de Ven's (Redhat) changes that are in
later RH kernel errata releases (addon/qla2200) have made it into the
6.x series code.  Much thanks goes out to Arjan for his work, not just
at the technical level, but also, the impact his work had on reshaping
the landscape of attitudes and direction within the Linux Driver Group
at QLogic.

The formal release of 6.01.00 has been completed and should be available
for download 'real soon now' (as it appears 6.01b5 is still the latest
6.x series driver available) -- package has been forwarded to the
website maintainer.  Notable changes from the 6.00 release include:

	o ISP2100 support

	o IP via FC support (RFC 2625)

	o General code-sanitizing
		- locking structures
		- queue structures
		- extraneous NOP*LOCK/UNLOCK macros
		- remove old EH routines
		- remove serial console routines

	o Bug-fixes.

Our current mode of operation for 6.x series work is, choose a driver
subsystem (i.e. command posting, fabric support, failover, or
post-command processing), rehash assuptions and requirements, review
design and role in driver, retool or reimplement, and test.  For
example, changes made to the source-tip since 6.01 include:

	o A complete rewrite of qla2x00_64bit_start_scsi()
		- fix 4gb page boundary limitation
		- correct endian-ness during IOCB preperation
		- simplification

	o Additional 64bit DMA fixes

	o Additional 2.5 support fixes

	o More bug-fixes

There is still alot of challenging work to be done, and perhaps now
would be a good time to ask the community, what they need and would
like to see happen with the QLogic driver?  I'll start of with a brief
list of 'important' TODOs we've compiled:

	o Interrupt handler cleanup

	o ZIO/RIO patches for 23xx

	o Continue support for kernel 2.5 and above

	o Adding support for PCI-HOT plug
		- complete pci_driver interface

	o Fabric management
		- Use login-IOCBs instead of mailbox command
		- GNFT support

	o SNIA API support (version 2.0)

	o Complete command posting module.

	o Alternative persistent binding method (non modules.conf based)

	o Failover processing simplification

	o VI support

I hope this helps to clearup some of the haze and ambiguity
surrounding QLogic's work with the 6.x series driver, and perhaps
at the same time, prepares a medium for discussion regarding the 6.x
series driver.

--=20
Andrew Vasquez | praka@san.rr.com |
        I prefer an accomidating vice to an obstinate virtue
DSS: 0x508316BB, FP: 79BD 4FAC 7E82 FF70 6C2B  7E8B 168F 5529 5083 16BB

--huq684BweRXVnRxX
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: I prefer an accomidating vice to an obstinate virtue...

iD8DBQE9k++hFo9VKVCDFrsRAp9pAJsGj3xBK49L9NoYnKcCuXRLbFiyLQCg0Qku
JRSxQGRYejsxdc1lUPi2lw4=
=XS6q
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--
