Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263154AbUDET1M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 15:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263156AbUDET1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 15:27:12 -0400
Received: from turing-police.cirt.vt.edu ([128.173.54.129]:13191 "EHLO
	turing-police.cirt.vt.edu") by vger.kernel.org with ESMTP
	id S263154AbUDET1F (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 15:27:05 -0400
Message-Id: <200404051927.i35JR2EN017101@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Sergiy Lozovsky <serge_lozovsky@yahoo.com>
Cc: Timothy Miller <miller@techsource.com>,
       Helge Hafting <helgehaf@aitel.hist.no>, linux-kernel@vger.kernel.org
Subject: Re: kernel stack challenge 
In-Reply-To: Your message of "Mon, 05 Apr 2004 10:59:40 PDT."
             <20040405175940.94093.qmail@web40509.mail.yahoo.com> 
From: Valdis.Kletnieks@vt.edu
References: <20040405175940.94093.qmail@web40509.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1765474996P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 05 Apr 2004 15:27:02 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1765474996P
Content-Type: text/plain; charset=us-ascii

On Mon, 05 Apr 2004 10:59:40 PDT, Sergiy Lozovsky said:

> 1. Give system administrator possibility to change
> security policy easy enough without C programminig
> inside the kernel (we should not expect system
> administartor to be a kernel guru). Language of higher
> lavel make code more compact (C - is too low level,
> that's why people use PERL for example or LISP). Lisp
> was chosen because of very compact VM - around 100K.

Didn't seem to slow the SELinux crowd down any...

You may not need the exact SELinux config language, but it does address the
issue of making something fairly easy for the sysadmin to write while not
requiring a large interpreter in the kernel (the kernel side of the selinuxfs
pseudo-filesystem is all of 14K, the loadpolicy is about a 4K binary and a 60K
shared library, and the policy compiler is about 100K and the shared lib).

So you're including a much bigger interface for little gain.  The total
footprint of the two solutions is about the same, but SELinux the vast majority
of it is in userspace, and only costs you when you're actually compiling/
loading a new policy, whereas yours takes up 100K of kernel space all the
time....

> 2. Protect system from bugs in security policy created
> by system administrator (user). LISP interpreter is a
> LISP Virtual Machine (as Java VM). So all bugs are
> incapsulated and don't affect kernel. Even severe bugs
> in this LISP kernel module can cause termination of
> user space application only (except of stack overflow
> - which I can address). LISP error message will be
> printed in the kernel log.

If you think that "all bugs are encapsulated" actually means anything in the
context of the Linux kernel, you're in for a very big surprise.

For example - your Lisp error messages go through the kernel log, so you're
using printk() and friends.  Note that it *is* possible for a buggy call to
printk() to cause problems for the kernel.


--==_Exmh_1765474996P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAcbMGcC3lWbTT17ARAg3lAKD8ZJNWrbx8kPWhoQDfyS//dX14eACgqZjg
mrkVZo3WoRvDAs6vys7xgGs=
=V7LS
-----END PGP SIGNATURE-----

--==_Exmh_1765474996P--
