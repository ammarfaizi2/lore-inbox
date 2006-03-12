Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751157AbWCLWbq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbWCLWbq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 17:31:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbWCLWbq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 17:31:46 -0500
Received: from ns2.suse.de ([195.135.220.15]:39861 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751157AbWCLWbp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 17:31:45 -0500
Date: Sun, 12 Mar 2006 23:32:56 +0100
From: Kurt Garloff <garloff@suse.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] KERN_SETUID_DUMPABLE in /proc/sys/fs/
Message-ID: <20060312223256.GE3028@tpkurt.garloff.de>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Arjan van de Ven <arjan@infradead.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	torvalds@osdl.org
References: <20060310155738.GL5766@tpkurt.garloff.de> <20060310145605.08bf2a67.akpm@osdl.org> <1142061816.3055.6.camel@laptopd505.fenrus.org> <20060310234155.685456cd.akpm@osdl.org> <1142063254.3055.9.camel@laptopd505.fenrus.org> <20060310235103.4e9c9457.akpm@osdl.org> <1142064294.3055.13.camel@laptopd505.fenrus.org> <m1r757xqoc.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cHMo6Wbp1wrKhbfi"
Content-Disposition: inline
In-Reply-To: <m1r757xqoc.fsf@ebiederm.dsl.xmission.com>
X-Operating-System: Linux 2.6.16-rc5-git2-3-xen i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E
Organization: SUSE/Novell
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cHMo6Wbp1wrKhbfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Arjan, Eric,

On Sun, Mar 12, 2006 at 03:07:47PM -0700, Eric W. Biederman wrote:
> Arjan van de Ven <arjan@infradead.org> writes:
>=20
> > diff -purN linux-2.6.16-rc5/include/linux/sysctl.h
> > linux-2.6.16-rc5-setuid/include/linux/sysctl.h
> > --- linux-2.6.16-rc5/include/linux/sysctl.h 2006-02-27 09:13:31.0000000=
00 +0100
> > +++ linux-2.6.16-rc5-setuid/include/linux/sysctl.h 2006-03-11 09:02:13.=
000000000
> > +0100
> > @@ -144,7 +144,6 @@ enum
> >  	KERN_UNKNOWN_NMI_PANIC=3D66, /* int: unknown nmi panic flag */
> >  	KERN_BOOTLOADER_TYPE=3D67, /* int: boot loader type */
> >  	KERN_RANDOMIZE=3D68, /* int: randomize virtual address space */
> > -	KERN_SETUID_DUMPABLE=3D69, /* int: behaviour of dumps for setuid core=
 */
> >  	KERN_SPIN_RETRY=3D70,	/* int: number of spinlock retries */
> >  	KERN_ACPI_VIDEO_FLAGS=3D71, /* int: flags for setting up video after =
ACPI
> > sleep */
> >  };
> > @@ -759,6 +758,9 @@ enum
> >  	FS_AIO_NR=3D18,	/* current system-wide number of aio requests */
> >  	FS_AIO_MAX_NR=3D19, /* system-wide maximum number of aio requests */
> >  	FS_INOTIFY=3D20,	/* inotify submenu */
> > + /* Note: the following got misplaced but this mistake is
> > +			   now part of the ABI */
> > +	FS_SETUID_DUMPABLE=3D21, /* int: behaviour of dumps for setuid core */

OK, this is the other possibility. It'll leave a hole in the KERN_
sysctl numbering, but that's not a problem AFAICT.
I would however at least annotate with FIXME and make a note that it's
gonna change in 2.7.

It's hard to tell how many people depend on suid_dumpable being at the
wrong location. The fact nobody noticed it being placed wrongly would
make me suspect it's not widely used yet (it only got introduced
2005-06-23 by Alan Cox). So I would prefer to move it to the correct
location now rather than in 2.7. By the time 2.7 comes, we may have so
many users, we may not want to correct this any more at all.

> This must be number 69 here.  Or else we break the sys_sysctl ABI.

I don't think we break anything we want to maintain.=20
Kernel-internal defines?=20
OK to change when going from 2.6.15 to 2.6.16 IMVHO. No module
compiled for 2.6.15 will work with 2.6.16 anyway.

Best,
--=20
Kurt Garloff, Head Architect Linux, Novell Inc.

--cHMo6Wbp1wrKhbfi
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFEFKGXxmLh6hyYd04RAs4nAJ9bgK95WZ6TJWMx2RGHcLGYloXEAgCfbdA9
a7MMup5jj2guvzTsW0quXMs=
=mXj+
-----END PGP SIGNATURE-----

--cHMo6Wbp1wrKhbfi--
