Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264674AbTI2Tyy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 15:54:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264676AbTI2Tyy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 15:54:54 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:5760 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S264674AbTI2Tyx (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 15:54:53 -0400
Message-Id: <200309291954.h8TJsm6p002210@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: -mregparm=3 (was  Re: [PATCH] i386 do_machine_check() is redundant. 
In-Reply-To: Your message of "Mon, 29 Sep 2003 11:46:12 PDT."
             <Pine.LNX.4.44.0309291142430.3626-100000@home.osdl.org> 
From: Valdis.Kletnieks@vt.edu
References: <Pine.LNX.4.44.0309291142430.3626-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-479303268P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 29 Sep 2003 15:54:48 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-479303268P
Content-Type: text/plain; charset=us-ascii

On Mon, 29 Sep 2003 11:46:12 PDT, Linus Torvalds said:

> Has anybody checked out whether the kernel works with -mregparm=3? I
> forget who did a lot of the work on it originally, and it certainly _used_
> to work fine. The improvements to both code size and performance were, if 
> I remember correctly, measurable but not huge.

It works well enough that my laptop made it to initlevel 3.  The code size
wasn't drastically smaller (perhaps another 2-3% but I already compile with
-Os).  The system "felt" snappier, but I have no benchmark numbers to give.  I
could probably get some numbers if anybody cares, but there's a showstopper for
me - I can't make it to initlevel 5 easily:

> One worry (apart from just broken compilers and missing "asmlinkage" 
> annotations) is that having compiler-version-dependent calling conventions 
> makes for another variable to take into account when chasing down bugs and 
> worrying about things like the Nvidia module etc. So it's probably not 
> worth doing unless the advantages are clear.

Quite correct - even after recompiling the sourced portions of the NVidia
driver, it dies a horrid death on 'insmod' when the closed-source portion
passes a parameter on the stack and the open side expects the value in a
register, and follows the register value to a quick death....

Yes, yes, I know, I could re-try with the open-source nv driver instead of the
closed-source NVidia driver - but the open-source one costs me more in
performance (as it's unaccelerated) than the mregparm=3 is likely to get me
back....


--==_Exmh_-479303268P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/eI4HcC3lWbTT17ARAj0tAKC8DAx5twVluR2t+QULVICGZhynOQCfekLg
I+WH4SAtxV9DfSkoJ9rNVB4=
=OXr9
-----END PGP SIGNATURE-----

--==_Exmh_-479303268P--
