Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262510AbUKRCAG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262510AbUKRCAG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 21:00:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262491AbUKQUlO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 15:41:14 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:3741 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S262524AbUKQUjt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 15:39:49 -0500
Message-Id: <200411162133.iAGLXn7v018578@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 10/11/2004 with nmh-1.1-RC3
To: A M <alim1993@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Accessing program counter registers from within C or Aseembler. 
In-Reply-To: Your message of "Tue, 16 Nov 2004 13:20:15 PST."
             <20041116212015.32217.qmail@web51901.mail.yahoo.com> 
From: Valdis.Kletnieks@vt.edu
References: <20041116212015.32217.qmail@web51901.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1806489916P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 16 Nov 2004 16:33:49 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1806489916P
Content-Type: text/plain; charset=us-ascii

On Tue, 16 Nov 2004 13:20:15 PST, A M said:

> Does anybody know how to access the address of the
> current executing instruction in C while the program
> is executing?

For what processor?  x86, itanium, sparc, s390 all do it differently.

Also, the answer to "this *very* instruction" is different from
"where this instruction was when we trapped/kdbg/interrupt/whatever
it so we could look at the current process/thread/worker state".

In other words, are you trying to answer "Where in memory am *I*?"
or "Where in memory is <that very recent code I want to look at>?"

(Hint - for the former, you can probably get very good approximations
by just looking at the entry point address for the function:

	(void *) where = &__FUNCTION__;

> Also, is there a method to load a program image from
> memory not a file (an exec that works with a memory
> address)? Mainly I am looking for a method that brings
> a program image into memory modify parts of it and
> start the in-memory modified version.

In user space, you probably want either mmap() or dlopen(), depending what it
is you're trying to do, most likely...

In kernel space, you'll have to be more specific as to what you're
trying to do, but you're always welcome to write a replacement for
fs/binfmt_elf.c :)

> Can anybody think of a method to replace a thread
> image without replacing the whole process image? 

What are you trying to achieve here?  It's unclear what you're
hoping will happen....

--==_Exmh_-1806489916P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBmnI9cC3lWbTT17ARAkRGAKDx9bN4jAZxlKqOePw5lS/E7Vr3ZgCfcoce
pjF65D+U08oRJCDRwMaE2ys=
=JcKq
-----END PGP SIGNATURE-----

--==_Exmh_-1806489916P--
