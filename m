Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932723AbWCPUm0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932723AbWCPUm0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 15:42:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932729AbWCPUmZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 15:42:25 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:10882 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S932727AbWCPUmY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 15:42:24 -0500
Message-Id: <200603162042.k2GKgEUR019711@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: kernel@ministry.se
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel cache mem bug(?) 
In-Reply-To: Your message of "Thu, 16 Mar 2006 18:41:02 +0100."
             <Pine.GHP.4.44.0603161742560.11953-200000@celeborn.ministry.se> 
From: Valdis.Kletnieks@vt.edu
References: <Pine.GHP.4.44.0603161742560.11953-200000@celeborn.ministry.se>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1142541734_2870P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 16 Mar 2006 15:42:14 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1142541734_2870P
Content-Type: text/plain; charset=us-ascii

On Thu, 16 Mar 2006 18:41:02 +0100, kernel@ministry.se said:
> [X.] Other notes, patches, fixes, workarounds:

>     Workaround: When we disable HyperThreading in BIOS, this
>     problem goes away. We re-enabling HT, it comes back...

Have you ruled out marginal memory, or overclocking/overheating?

I'm guessing something is barely within tolerance when one CPU is
beating up on it, and it falls over when the HT adds to the mix.

For that matter, this looks racy:

while [ 0$MD5LOOPS -gt 0 ]; do
  md5sum cache.*-*-* >> md5log.$PID.lis
  MD5LOOPS=`expr 0$MD5LOOPS - 1`
done &

 AMNT=`awk '$1!="91b82dcc83230890dbcdfc6b80571ddd"' md5log.$PID.lis | wc -l`

If md5sum uses stdio to write the output, and it writes more than 4K or so,
it's possible you can get a partial line right at the buffer boundary,
which will then come up as a mismatch according to the awk.  You might want
to actually output the mismatched line in its entirety, and make sure you're
looking at a complete line, and not a partial....

--==_Exmh_1142541734_2870P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEGc2mcC3lWbTT17ARAlQ0AKDZXabOBIxD4gQ6VK7H7llnsHvq6gCgkmxd
590ArS6J3NDu1n7PoKt9waY=
=9ESZ
-----END PGP SIGNATURE-----

--==_Exmh_1142541734_2870P--
