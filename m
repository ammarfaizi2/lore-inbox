Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270378AbTG1RxF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 13:53:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270379AbTG1RxF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 13:53:05 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:38529 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S270378AbTG1RxC (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 13:53:02 -0400
Message-Id: <200307281808.h6SI8C5k004439@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] O10int for interactivity 
In-Reply-To: Your message of "Mon, 28 Jul 2003 01:12:16 +1000."
             <200307280112.16043.kernel@kolivas.org> 
From: Valdis.Kletnieks@vt.edu
References: <200307280112.16043.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1115248624P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 28 Jul 2003 14:08:12 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1115248624P
Content-Type: text/plain; charset=us-ascii

On Mon, 28 Jul 2003 01:12:16 +1000, Con Kolivas said:
> Here is a fairly rapid evolution of the O*int patches for interactivity thanks
> to Ingo's involvement.

I'm running the -O10 variant that's in Andrew's -test2-mm1 patch, and I'm
totally unable to force the CPU scheduler to misbehave.

I am, however, able to get 'xmms' to skip.  The reason is that the CPU is being
scheduled quite adequately, but I/O is *NOT*.

The reason is that xmms's .ogg decoder is reading a 128K chunk every 10 seconds
or so, and doesn't do the next read till it's *really* close to running out of
data.  Unfortunately, under high I/O load (which isn't all THAT high, it's a
HITACHI_DK23DA-40 in a Dell Laptop) it's possible for that 128K read to get
stuck behind other stuff that's doing heavy I/O (for instance, starting Mozilla
or OpenOffice, or sometime a 'find' command).

I'm guessing that the anticipatory scheduler is the culprit here.  Soon as I figure
out the incantations to use the deadline scheduler, I'll report back....


--==_Exmh_1115248624P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/JWaMcC3lWbTT17ARAtRSAJ46IAygMdwW1Gun47RGGy+Ww5jtqwCeO50Q
VsiOLCAl3igCMFeoGRcmItU=
=xOhH
-----END PGP SIGNATURE-----

--==_Exmh_1115248624P--
