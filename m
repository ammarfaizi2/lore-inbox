Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261902AbVDOT1i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261902AbVDOT1i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 15:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261939AbVDOT1i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 15:27:38 -0400
Received: from zlynx.org ([199.45.143.209]:39691 "EHLO 199.45.143.209")
	by vger.kernel.org with ESMTP id S261902AbVDOT1R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 15:27:17 -0400
Subject: Re: intercepting syscalls
From: Zan Lynx <zlynx@acm.org>
To: Igor Shmukler <igor.shmukler@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <6533c1c905041511041b846967@mail.gmail.com>
References: <6533c1c905041511041b846967@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-9ZFTb7JhcM4fySVgj7dn"
Date: Fri, 15 Apr 2005 13:27:06 -0600
Message-Id: <1113593226.15637.20.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-9ZFTb7JhcM4fySVgj7dn
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-04-15 at 14:04 -0400, Igor Shmukler wrote:
> Hello,
> We are working on a LKM for the 2.6 kernel.
> We HAVE to intercept system calls. I understand this could be
> something developers are no encouraged to do these days, but we need
> this.
> Patching kernel to export sys_call_table is not an option. The fast
> and dirty way to do this would be by using System.map, but I would
> rather we find a cleaner approach.

These ideas are hardly a clean approach but might work although I
haven't tried:

Hook into an existing kernel function that is exported to modules that
can be called by a system call, like a /proc or /sys file.  On a
sys_read or sys_write to your /proc file, perform a stack trace back to
the system call, then search and adjust to find the system call table
pointer.

You might also be able to look at the int $80 vector and grub through
the machine code to find it.

Of course, anything like this will probably only work on x86 and need to
be rewritten for each architecture.  Very messy.
--=20
Zan Lynx <zlynx@acm.org>

--=-9ZFTb7JhcM4fySVgj7dn
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCYBWKG8fHaOLTWwgRAgLIAJ9kbv/36IRFo2hnl4jsydVHNMDp/gCfVE5Q
vm5W9D1TuQ95RBXoybyjz7U=
=Xvm1
-----END PGP SIGNATURE-----

--=-9ZFTb7JhcM4fySVgj7dn--

