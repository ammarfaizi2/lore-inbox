Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266133AbTLaGYf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 01:24:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266136AbTLaGYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 01:24:35 -0500
Received: from h80ad2762.async.vt.edu ([128.173.39.98]:23171 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S266133AbTLaGYc (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 01:24:32 -0500
Message-Id: <200312250756.hBP7ubq8014587@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: hmm.. 
In-Reply-To: Your message of "Mon, 22 Dec 2003 13:31:51 PST."
             <Pine.LNX.4.58.0312221316090.6868@home.osdl.org> 
From: Valdis.Kletnieks@vt.edu
References: <3FE74FD3.8040807@antitux.net>
            <Pine.LNX.4.58.0312221316090.6868@home.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1112948997P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 25 Dec 2003 02:56:37 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1112948997P
Content-Type: text/plain; charset=us-ascii

On Mon, 22 Dec 2003 13:31:51 PST, Linus Torvalds said:

>  - algorithmically, there aren't that many ways to test whether a 
>    character is a number or not. That's _especially_ true in
>    C, where a macro must not use it's argument more than once. So for 
>    example, the "obvious" implementation of "isdigit()" (which tests for 
>    whether a character is a digit or not) would be
> 
> 	#define isdigit(x) ((x) >= '0' && (x) <= '9')
> 
>    but this is not actually allowed by the C standard (because 'x' is used 
>    twice).

Somebody tell IBM that.  From the AIX 4.3.3 and 5.1 /usr/include/ctype.h:

#define _VALC(__c)              ((__c)>=0&&(__c)<=256)
#define _IS(__c,__m)            (__OBJ_DATA(__lc_ctype)->mask[__c] & __m)
#define isalpha(__a)    (_VALC(__a)?_IS(__a,_ISALPHA):0)
#define isalnum(__a)    (_VALC(__a)?_IS(__a,_ISALNUM):0)
#define iscntrl(__a)    (_VALC(__a)?_IS(__a,_ISCNTRL):0)
#define isdigit(__a)    (_VALC(__a)?_IS(__a,_ISDIGIT):0)
#define isgraph(__a)    (_VALC(__a)?_IS(__a,_ISGRAPH):0)
#define islower(__a)    (_VALC(__a)?_IS(__a,_ISLOWER):0)
#define isprint(__a)    (_VALC(__a)?_IS(__a,_ISPRINT):0)
#define ispunct(__a)    (_VALC(__a)?_IS(__a,_ISPUNCT):0)
#define isspace(__a)    (_VALC(__a)?_IS(__a,_ISSPACE):0)
#define isupper(__a)    (_VALC(__a)?_IS(__a,_ISUPPER):0)
#define isxdigit(__a)   (_VALC(__a)?_IS(__a,_ISXDIGIT):0)
#define isascii(c)      (!((c) & ~0177))

You'd be *amazed* how far through memory a 'while (isalpha(*s++)) {..};' can go
(which in fact is how I discovered this blecherousness).

The AIX 4.3 support I contributed to  Sendmail 8.9.0 back in Feb 98 included a
work-around because IBM refused to fix it on the grounds that the VALC macro
was to protect against a SEGV if the macro was fed an 'int' rather than a
'char' (why they didn't just use 'mask[__c & 255]' is beyond me), and that you
only got hit if you compiled(*) with -D_ILS_MACROS.  At least IBM eventually fixed
isascii(), which was originally broken the same way.... 

Feel free to file this under "Code we can prove that IBM never contributed" :)

(*) The default is to use actual function calls due to locale considerations - building
with _ILS_MACROS provides a measured 30%+ CPU savings for Sendmail, which
doesn't care if it's nailed into a 'LANG=C' environ anyhow...





--==_Exmh_-1112948997P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/6pg0cC3lWbTT17ARAtzaAJ4o3CwmQL8uGpB0emdFz++KrRY7oQCeLUQw
M+fuSbG+4GdfinTsmSMFGi4=
=S4yN
-----END PGP SIGNATURE-----

--==_Exmh_-1112948997P--
