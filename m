Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261935AbTIPPF0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 11:05:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261937AbTIPPF0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 11:05:26 -0400
Received: from h80ad2599.async.vt.edu ([128.173.37.153]:20365 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261935AbTIPPFO (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 11:05:14 -0400
Message-Id: <200309161504.h8GF4MYe015141@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Timothy Miller <miller@techsource.com>
Cc: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       David Yu Chen <dychen@stanford.edu>, linux-kernel@vger.kernel.org,
       mc@cs.stanford.edu, David Woodhouse <dwmw2@infradead.org>,
       linux-mtd@lists.infradead.org
Subject: Re: [CHECKER] 32 Memory Leaks on Error Paths 
In-Reply-To: Your message of "Tue, 16 Sep 2003 10:52:06 EDT."
             <3F672396.10906@techsource.com> 
From: Valdis.Kletnieks@vt.edu
References: <200309160435.h8G4ZkQM009953@elaine4.Stanford.EDU> <20030916065553.GA12329@wohnheim.fh-wedel.de>
            <3F672396.10906@techsource.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-837387179P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 16 Sep 2003 11:04:21 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-837387179P
Content-Type: text/plain; charset=us-ascii

On Tue, 16 Sep 2003 10:52:06 EDT, Timothy Miller said:
> 
> >> 276:	/* OK, it's not open. Create cache info for it */
> >>START -->
> >> 277:	mtdblk = kmalloc(sizeof(struct mtdblk_dev), GFP_KERNEL);
> >> 278:	if (!mtdblks)
> >>END -->
> >> 279:		return -ENOMEM;
> 
> > 
> > Invalid.  This is quite an obvious false positive, at least if your
> > algorithm checks for possible value ranges.
> 
> Wait... one is "mtdblk", and the other is "mtdblks".  One has an extra 
> 's' on it.  Unless there is some kind of aliasing going on, they would 
> appear to be different variables.  Naturally, I didn't check the 
> original code, so I could be full of it.  :)

On the other hand, even if the report was invalid (which another posting says isn't
the case), this code is just *begging* for somebody to "fix the typo", due to how
much the kernel uses
	foo = function(..)
	if (!foo)
Yeah, they're different variables - but we alloc mktblk and then return -ENOMEM
if the OTHER variable is null?? ;)

--==_Exmh_-837387179P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/ZyZ1cC3lWbTT17ARAi3pAKD2q/kclzGldljMKcUsbmWwaW3qHwCfV3Ej
G5i+GBBseF/X2OEnA3gE/9A=
=HDWl
-----END PGP SIGNATURE-----

--==_Exmh_-837387179P--
