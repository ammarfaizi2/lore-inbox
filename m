Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265203AbUFAUCa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265203AbUFAUCa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 16:02:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265198AbUFAUBc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 16:01:32 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:15287 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S265196AbUFAUBA (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 16:01:00 -0400
Message-Id: <200406012000.i51K0vor019011@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: FabF <fabian.frederick@skynet.be>
Cc: linux-kernel@vger.kernel.org
Subject: Re: why swap at all? 
In-Reply-To: Your message of "Tue, 01 Jun 2004 21:53:32 +0200."
             <1086119611.2278.16.camel@localhost.localdomain> 
From: Valdis.Kletnieks@vt.edu
References: <E1BUwEH-00030X-00@calista.eckenfels.6bone.ka-ip.net> <1086114982.2278.5.camel@localhost.localdomain> <200406011902.i51J2mZ3016721@turing-police.cc.vt.edu>
            <1086119611.2278.16.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_632806051P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 01 Jun 2004 16:00:57 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_632806051P
Content-Type: text/plain; charset=us-ascii

On Tue, 01 Jun 2004 21:53:32 +0200, FabF said:

> I was thinking about some rule e.g. any process using libX* isn't
> swapped to disk until OOM ...

Odd.. some of the processes that I'd want kept in memory use libX*,
but others that also use it are at the top of my list of things to migrate
out (unlike some, I don't mind if Mozilla or OpenOffice end up out on
disk after extended inactivity - but if my window manager gets swapped
out, I get peeved when focus-follows-mouse doesn't and my typing goes
into the wrong window or some such... ;)

And that rule doesn't even help much - as it will cause at least some X
servers themselves to get swapped out.  Here's the list for my X server
at the moment, as reported by lsof:

X       13886 root  txt    REG      254,1 1960870       1966 /usr/X11R6/bin/Xorg
X       13886 root  mem    REG      254,5  105700      12388 /lib/ld-2.3.3.so
X       13886 root  mem    REG      254,5   50944      12530 /lib/libnss_files-2.3.3.so
X       13886 root  mem    REG      254,1   64040       1347 /usr/lib/libz.so.1.2.1.1
X       13886 root  mem    REG      254,5  212972      53335 /lib/tls/libm-2.3.3.so
X       13886 root  mem    REG      254,5   28008      12513 /lib/libpam.so.0.77
X       13886 root  mem    REG      254,5   15008      12471 /lib/libdl-2.3.3.so
X       13886 root  mem    REG      254,5    8332      12515 /lib/libpam_misc.so.0.77
X       13886 root  mem    REG      254,5   29660      12511 /lib/libgcc_s-3.3.3-20040413.so.1
X       13886 root  mem    REG      254,5 1451868      53258 /lib/tls/libc-2.3.3.so
X       13886 root  mem    REG      254,1  647652      32015 /usr/X11R6/lib/modules/extensions/libglx.so.1.0.5341
X       13886 root  mem    REG      254,1 4954876       8362 /usr/lib/tls/libGLcore.so.1.0.5341

Nope, no libX* here... ;)

It's a lot harder than it looks, which explains why we haven't gotten it right
yet...


--==_Exmh_632806051P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAvOB5cC3lWbTT17ARAqTVAKDVB8qPfXJ/Ra0r+HyD0IsT7nUqugCfV3vq
slI8G/bO9HsnIa6ddORoVww=
=ai66
-----END PGP SIGNATURE-----

--==_Exmh_632806051P--
