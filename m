Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964853AbWGSPAN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964853AbWGSPAN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 11:00:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964859AbWGSPAN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 11:00:13 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:61910 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S964853AbWGSPAM (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 11:00:12 -0400
Message-Id: <200607191500.k6JF09EQ005021@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Ian Stirling <ian.stirling@mauve.plus.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Per-user swap devices.
In-Reply-To: Your message of "Wed, 19 Jul 2006 10:54:38 BST."
             <44BE015E.5080107@mauve.plus.com>
From: Valdis.Kletnieks@vt.edu
References: <44BE015E.5080107@mauve.plus.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1153321209_2943P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 19 Jul 2006 11:00:09 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1153321209_2943P
Content-Type: text/plain; charset=us-ascii

On Wed, 19 Jul 2006 10:54:38 BST, Ian Stirling said:

> It would be really nice to be able to simply: chown crashalot.users 
> /dev/swap0 ;swapon /dev/swap0
> Then anything run by crashalot would swap to /dev/swap0 - and not locally.
> If it crashes, then firefox/whatever else bloated that they were running 
> simply dies.
> 
> I assume this is not currently possible.
> How much work would it be to get it to be so?

This doesn't look like it will do as much good as you think.  The problem
is what to do when something run by some *other* UID needs a page - you need
to fix the code to preferentially steal a page from a 'crashalot' process.

And at that point, what you probably want instead is a global per-UID RSS
limit.  This looks like a job for a CKRM resource class controller rather than
a hack to the swap code.

--==_Exmh_1153321209_2943P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEvkj5cC3lWbTT17ARAuyOAKC4qroKFRGEhU4RRqYsVeDeqU6xRgCg9guB
Ovkah5r4izCi9VYOmIvTEqI=
=sTHq
-----END PGP SIGNATURE-----

--==_Exmh_1153321209_2943P--
