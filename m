Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755518AbWK1W7I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755518AbWK1W7I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 17:59:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757477AbWK1W7I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 17:59:08 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:50399 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1755518AbWK1W7F (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 17:59:05 -0500
Message-Id: <200611282258.kASMwW2f025365@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, trivial@kernel.org
Subject: Friends dont let friends use GCC -W (was Re: [PATCH] Don't compare unsigned
In-Reply-To: Your message of "Tue, 28 Nov 2006 23:17:13 +0100."
             <200611282317.14020.jesper.juhl@gmail.com>
From: Valdis.Kletnieks@vt.edu
References: <200611282317.14020.jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1164754712_2995P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 28 Nov 2006 17:58:32 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1164754712_2995P
Content-Type: text/plain; charset=us-ascii

On Tue, 28 Nov 2006 23:17:13 +0100, Jesper Juhl said:
> In kernel/sys.c::sys_prctl() the argument named 'arg2' is very clearly
> of type 'unsigned long', and when compiling with "gcc -W" gcc also warns :
>   kernel/sys.c:2089: warning: comparison of unsigned expression < 0 is always false
>
> So this patch removes the test of "arg2 < 0".

For those playing along at home - often the bug (not here though) is it should
have been a *signed* long, because arg2 could be passed from some other
function that returns negative numbers on error?  Remember that papering over
a bug is a bad idea...

On Tue, 28 Nov 2006 14:27:51 PST, Linus Torvalds said:
> The fact is, if it's unsigned, it's not something that the programmer 
> should have to care about. We should write our code to be readable and 
> obviously safe, and that means that

Unfortunately, it's *easy* for GCC to determine that Something Odd has
happened. Either the variable was made unsigned in error, or the test is in
error. However, there's no real way for the compiler to know which was
intended.  And let's face it - we've had enough of our share of bugs *both*
ways, which is why GCC emits a warning.



--==_Exmh_1164754712_2995P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFbL8YcC3lWbTT17ARAq9oAKCHci4CzKIqiiaP6L3PQ2Bsr2IcvwCfeRE2
dJl62tZdYqA4/tKA0rZ2AuU=
=NwTR
-----END PGP SIGNATURE-----

--==_Exmh_1164754712_2995P--
