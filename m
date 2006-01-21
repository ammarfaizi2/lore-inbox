Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964796AbWAUBdX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964796AbWAUBdX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 20:33:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964828AbWAUBdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 20:33:22 -0500
Received: from h80ad2542.async.vt.edu ([128.173.37.66]:10653 "EHLO
	h80ad2542.async.vt.edu") by vger.kernel.org with ESMTP
	id S964796AbWAUBdW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 20:33:22 -0500
Message-Id: <200601210132.k0L1WbIP006348@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: set_bit() is broken on i386? 
In-Reply-To: Your message of "Fri, 20 Jan 2006 19:53:14 EST."
             <200601201955_MC3-1-B649-DCF5@compuserve.com> 
From: Valdis.Kletnieks@vt.edu
References: <200601201955_MC3-1-B649-DCF5@compuserve.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1137807155_2937P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 20 Jan 2006 20:32:36 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1137807155_2937P
Content-Type: text/plain; charset=us-ascii

On Fri, 20 Jan 2006 19:53:14 EST, Chuck Ebbert said:
> /* 
>  * setbit.c -- test the Linux set_bit() function
>  *
>  * Compare the output of this program with and without the
>  * -finline-functions option to GCC.
>  *
>  * If they are not the same, set_bit is broken.
>  *
>  * Result on i386 with gcc 3.3.2 (Fedora Core 2):
>  *
>  * [me@d2 t]$ gcc -O2 -o setbit.ex setbit.c ; ./setbit.ex
>  * 00010001
>  * [me@d2 t]$ gcc -O2 -o setbit.ex -finline-functions setbit.c ; ./setbit.ex
>  * 00000001

It certainly seems to be gcc version dependent (and I'd not be surprised if the
exact combo of -O2, -Os, and -mfoo and -fwhatever flags as well).  Trond is
probably right that a memory clobber will force gcc to DTIT (Do The Intended
Thing, which may be different from a DTRT) regardless of what gcc's code generator
decides to do....

% gcc -v
Using built-in specs.
Target: i386-redhat-linux
Configured with: ../configure --prefix=/usr --mandir=/usr/share/man --infodir=/usr/share/info --enable-shared --enable-threads=posix --enable-checking=release --with-system-zlib --enable-__cxa_atexit --disable-libunwind-exceptions --enable-libgcj-multifile --enable-languages=c,c++,objc,obj-c++,java,fortran,ada --enable-java-awt=gtk --disable-dssi --with-java-home=/usr/lib/jvm/java-1.4.2-gcj-1.4.2.0/jre --host=i386-redhat-linux
Thread model: posix
gcc version 4.1.0 20060117 (Red Hat 4.1.0-0.15)
% gcc -O2 -o setbit.ex setbit.c ; ./setbit.ex
00000001
% gcc -O2 -o setbit.ex -finline-functions setbit.c ; ./setbit.ex
00000001

Fedora Core -devel tree as of this morning (so sort-of FC5 test2).

--==_Exmh_1137807155_2937P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFD0Y8zcC3lWbTT17ARAjr8AJ9h6zhOYLQB1l9kPwVnWpdJt+HWiACgi+dt
He1R7HE8Y3ctu50VDJfOidc=
=6JVX
-----END PGP SIGNATURE-----

--==_Exmh_1137807155_2937P--
