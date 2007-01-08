Return-Path: <linux-kernel-owner+w=401wt.eu-S932067AbXAHWni@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067AbXAHWni (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 17:43:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932160AbXAHWni
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 17:43:38 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:47201 "EHLO
	turing-police.cc.vt.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932067AbXAHWnh (ORCPT
	<RFC822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 17:43:37 -0500
Message-Id: <200701082243.l08Mh8UR007559@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Amit Choudhary <amit2030@yahoo.com>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, Hua Zhong <hzhong@gmail.com>,
       Christoph Hellwig <hch@infradead.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] include/linux/slab.h: new KFREE() macro.
In-Reply-To: Your message of "Mon, 08 Jan 2007 01:06:12 PST."
             <552712.75479.qm@web55603.mail.re4.yahoo.com>
From: Valdis.Kletnieks@vt.edu
References: <552712.75479.qm@web55603.mail.re4.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1168296188_3596P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 08 Jan 2007 17:43:08 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1168296188_3596P
Content-Type: text/plain; charset=us-ascii

On Mon, 08 Jan 2007 01:06:12 PST, Amit Choudhary said:
> I do not see how a double free can result in _logical_wrong_behaviour_ of the program and the
> program keeps on running (like an incoming packet being dropped because of double free). Double
> free will _only_and_only_ result in system crash that can be solved by setting 'x' to NULL.

The problem is that very rarely is there a second free() with no intervening
use - what actually *happens* usually is:

1) You alloc the memory
2) You use the memory
3) You take a reference on the memory, so you know where it is.
4) You free the memory
5) You use the memory via the reference you took in (3)
6) You free it again - at which point you finally know for sure that
everything in step 5 was doing a fandango on core....

--==_Exmh_1168296188_3596P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFosj8cC3lWbTT17ARAlBTAKCelSAqIAou2lUckNZ3/zXQ9cmU2wCgx2O2
GURlwSzlQ87in8vPMFzIpY0=
=xaqx
-----END PGP SIGNATURE-----

--==_Exmh_1168296188_3596P--
