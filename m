Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261422AbUFNARJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261422AbUFNARJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jun 2004 20:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261425AbUFNARJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jun 2004 20:17:09 -0400
Received: from turing-police.cirt.vt.edu ([128.173.54.129]:15232 "EHLO
	turing-police.cirt.vt.edu") by vger.kernel.org with ESMTP
	id S261422AbUFNARF (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jun 2004 20:17:05 -0400
Message-Id: <200406140017.i5E0HKGk001942@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Coding style questions for patches.. 
In-Reply-To: Your message of "Mon, 14 Jun 2004 09:55:58 +1000."
             <16588.59790.738289.512560@cse.unsw.edu.au> 
From: Valdis.Kletnieks@vt.edu
References: <200406121959.i5CJxLAm008168@turing-police.cc.vt.edu>
            <16588.59790.738289.512560@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_351922304P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 13 Jun 2004 20:17:20 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_351922304P
Content-Type: text/plain; charset=us-ascii

On Mon, 14 Jun 2004 09:55:58 +1000, Neil Brown said:

> This would look better as:
> 
> #ifdef CONFIG_SECURITY_RANDPID
> #include <linux/random>
> extern int security_enable_randpid;
> #else
> #define security_enable_randpid (0)
> #endif
> 
> static inline int alloc_next_pid(int last_pid) {
> 	int next;
> 	if (security_enable_randpid && (last_pid >= RESERVED_PIDS)) {
> 		pid = (get_random_long() % (pid_max - RESERVED_PIDS)) + RESERVE
D_PIDS + 1;
> 	}
> 	else next = last_pid + 1;
> 	return next;
> }

OK.. Begging the question then - if I go *that* route, I can get rid of the
whole static inline and do it in the one place it gets called (since there's then
no #ifdef'ing in the main .c which was the style commentary I got)....

Would the Style Gods prefer Neils's suggested ifdef stuff in pid.h and then
the 3 line code in pid.c without ifdef's?

--==_Exmh_351922304P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAzO6QcC3lWbTT17ARAnDwAKDxwbeWrwgGJU89abgKeq0DWdwiBQCcDufU
n+akICrQQFQP9a63ci0a77E=
=o+T8
-----END PGP SIGNATURE-----

--==_Exmh_351922304P--
