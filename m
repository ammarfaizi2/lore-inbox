Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932148AbVJYOHw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbVJYOHw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 10:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932152AbVJYOHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 10:07:52 -0400
Received: from h80ad2532.async.vt.edu ([128.173.37.50]:45452 "EHLO
	h80ad2532.async.vt.edu") by vger.kernel.org with ESMTP
	id S932148AbVJYOHv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 10:07:51 -0400
Message-Id: <200510251407.j9PE7LtK014903@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Laurent Riffard <laurent.riffard@free.fr>
Subject: Re: intel-agp and yenta-socket issues (was Re: 2.6.14-rc5-mm1 
In-Reply-To: Your message of "Mon, 24 Oct 2005 22:32:23 PDT."
             <20051024223223.267d46ec.akpm@osdl.org> 
From: Valdis.Kletnieks@vt.edu
References: <20051024014838.0dd491bb.akpm@osdl.org> <200510250513.j9P5DjGv004612@turing-police.cc.vt.edu>
            <20051024223223.267d46ec.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1130249235_8692P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 25 Oct 2005 10:07:15 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1130249235_8692P
Content-Type: text/plain; charset=us-ascii

On Mon, 24 Oct 2005 22:32:23 PDT, Andrew Morton said:

> > intel-agp would hang during modprobe until I backed this one out.
> 
> A sysrq trace would be nice.

Did some further testing, this time passing a loglevel= so I'd see the output,
and sysrq-T showed that both modprobe issues were due to an even earlier
modprobe that went south.  Looking like a bad merge of a local patch caused
some locking to get corrupted (always a bad sign when atomic_dec_and_test
throws an "atomic counter underflow" message on a refcount).  It's now unclear
why backing out the agp-updates patch allowed modprobe to succeed - it
*shouldn't* have made a difference.  Oddness.



--==_Exmh_1130249235_8692P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFDXjwTcC3lWbTT17ARAjBIAJ9B7NpKup4SIKjJeycSC6KFvVGMiwCfXW2R
CAm61qtts4QjsS/PYkFy1dM=
=Gxpa
-----END PGP SIGNATURE-----

--==_Exmh_1130249235_8692P--
