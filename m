Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269595AbTGJSGf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 14:06:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269596AbTGJSGf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 14:06:35 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:10887 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S269595AbTGJSGc (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 14:06:32 -0400
Message-Id: <200307101821.h6AIL87u013299@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.74-mm3 
In-Reply-To: Your message of "Tue, 08 Jul 2003 22:35:48 PDT."
             <20030708223548.791247f5.akpm@osdl.org> 
From: Valdis.Kletnieks@vt.edu
References: <20030708223548.791247f5.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-327683311P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 10 Jul 2003 14:21:08 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-327683311P
Content-Type: text/plain; charset=us-ascii

On Tue, 08 Jul 2003 22:35:48 PDT, Andrew Morton <akpm@osdl.org>  said:

> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.74/2.5.74-mm3/

OK, I'm finally getting around to actually commenting, this has been a niggling issue for
a while...

> All 113 patches:

> 64-bit-dev_t-kdev_t.patch
>   64-bit dev_t and kdev_t

Yes, this patch says "not ready for prime time, it breaks things".

In particular, this gives the device-mapper userspace indigestion, because the
ioctl passes something other than a 64-bit kdev_t in from libdevmapper. Upshot
is that the LVM2 'vgchange -ay' fails gloriously.

Workaround:  Compile the devmapper/LVM stuff with a private copy of include/
linux/kdev_t.h that matches the one the kernel uses.  No, I didn't actually get
that to work, so I backed out the 64-bit patch...

(And no, the recent devmapper/LVM2 stuff posted doesn't fix this).

--==_Exmh_-327683311P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/Da6TcC3lWbTT17ARApIQAJ9JMegsEJN357NYSvTStxnMzXgYpQCguhRW
HlaLZRp46OZz+L7gRVIDV/A=
=ZBv1
-----END PGP SIGNATURE-----

--==_Exmh_-327683311P--
