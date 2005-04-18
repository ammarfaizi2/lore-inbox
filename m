Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261183AbVDRVP6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261183AbVDRVP6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 17:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261184AbVDRVP6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 17:15:58 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:55046 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261183AbVDRVPw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 17:15:52 -0400
Message-Id: <200504182115.j3ILFFKh024783@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?=
	 =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
Cc: Christoph Hellwig <hch@infradead.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RLIMIT_NPROC enforcement during execve() calls 
In-Reply-To: Your message of "Mon, 18 Apr 2005 20:07:04 +0200."
             <1113847624.17341.36.camel@localhost.localdomain> 
From: Valdis.Kletnieks@vt.edu
References: <1113845937.17341.29.camel@localhost.localdomain> <20050418174346.GA28790@infradead.org>
            <1113847624.17341.36.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1113858914_10881P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 18 Apr 2005 17:15:15 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1113858914_10881P
Content-Type: text/plain; charset=us-ascii

On Mon, 18 Apr 2005 20:07:04 +0200, Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?= =?ISO-8859-1?Q?Garc=EDa-Hierro?= said:

> The limit is only checked when process is created on a fork() call, but
> during execution it's uid can change, thus, the limit for the new uid
> could be exceed.

The only two ways I can see this happening are (1) if the process is running
as uid 0 (or capability-equivalent) at fork() time and have called set*uid()
before execve(), or (2) we just exec'ed a set-UID binary.

In both cases the "obvious" thing to do is to re-check the target UID's rlimit,
but there may be some squirrelly corner case where this isn't true...

--==_Exmh_1113858914_10881P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCZCNicC3lWbTT17ARAiiPAJ0cHoSUOTEf8prW6yk0nnDINH3pNQCgvA6j
oSmDLBN/CCWA8C3Mjru26xU=
=H/Pt
-----END PGP SIGNATURE-----

--==_Exmh_1113858914_10881P--
