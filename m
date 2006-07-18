Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932254AbWGROu3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932254AbWGROu3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 10:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932257AbWGROu3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 10:50:29 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:9678 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S932254AbWGROu2 (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 10:50:28 -0400
Message-Id: <200607181450.k6IEo4Rs022388@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Michael Buesch <mb@bu3sch.de>
Cc: linux-kernel@vger.kernel.org, keir@xensource.com,
       Tony Lindgren <tony@atomide.com>, zach@vmware.com,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Subject: Re: kernel/timer.c: next_timer_interrupt() strange/buggy(?) code (2.6.18-rc1-mm2)
In-Reply-To: Your message of "Tue, 18 Jul 2006 16:29:27 +0200."
             <200607181629.27933.mb@bu3sch.de>
From: Valdis.Kletnieks@vt.edu
References: <20060717185330.GA32264@rhlx01.fht-esslingen.de> <200607171957.k6HJvPHT022236@turing-police.cc.vt.edu>
            <200607181629.27933.mb@bu3sch.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1153234204_3104P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 18 Jul 2006 10:50:04 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1153234204_3104P
Content-Type: text/plain; charset=us-ascii

On Tue, 18 Jul 2006 16:29:27 +0200, Michael Buesch said:

> Continue is equal to:
> 
> LOOP {
> 	/* foo */
> 	goto continue; /* == continue */
	/* What the code actually had: */
        goto found; /* Note placement of the label *AFTER* end of loop */
> 	/* foo */
> continue:
> } LOOP

found: /* out of the loop entirely */

A 'continue' drops you *at* the end of the loop. The 'goto found:' in the
original code drops you *after* the end of the loop.  One will potentially go
around for another pass, the other you're *done*.


--==_Exmh_1153234204_3104P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEvPUccC3lWbTT17ARAnupAKCwRDCvY7M1515aR10qligOV5MY9ACeMe4t
1qD+CAmzW/thGofZjNOdtSM=
=eVtg
-----END PGP SIGNATURE-----

--==_Exmh_1153234204_3104P--
