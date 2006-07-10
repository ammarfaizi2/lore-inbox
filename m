Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964809AbWGJNuE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964809AbWGJNuE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 09:50:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965015AbWGJNuD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 09:50:03 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:39362 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S964809AbWGJNuB (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 09:50:01 -0400
Message-Id: <200607101323.k6ADNmuc031378@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Arjan van de Ven <arjan@infradead.org>
Cc: Jesper Juhl <jesper.juhl@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH 0/9] -Wshadow: Making the kernel build clean with -Wshadow
In-Reply-To: Your message of "Mon, 10 Jul 2006 14:53:19 +0200."
             <1152535999.4874.36.camel@laptopd505.fenrus.org>
From: Valdis.Kletnieks@vt.edu
References: <9a8748490607100548o14dbe684j40bde90eb19a7558@mail.gmail.com>
            <1152535999.4874.36.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1152537827_25551P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 10 Jul 2006 09:23:48 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1152537827_25551P
Content-Type: text/plain; charset=us-ascii

On Mon, 10 Jul 2006 14:53:19 +0200, Arjan van de Ven said:

> I'm just about always in favor of having automated tools help us find
> bugs. However... can you give an indication of how many real bugs you
> have encountered? If it's "mostly noise" all the time.. then it's maybe
> not worth the effort... while if you find real bugs then it's obviously
> worthwhile to go through this.

I started doing similar a while back, and I hadn't come across any
actual bugs either.  However, there's 2 aspects to this:

1) The cleanup cases that Jesper is doing (which are pretty similar
to what I was doing) are mostly "function prototypes in .h files use
a variable name that collides with another global variable" ('up' for
example). (My nominee for patch 10/9:

include/net/tcp.h:469: warning: declaration of '__x' shadows a previous local
include/net/tcp.h:469: warning: shadowed declaration is here

2) The actual *bugs* are most probably in the "variable in .c file
shadows a global".

As Jesper notes, it's hard to see the latter when there's 38,000+ noise
warnings....

To get a good estimate of the *actual* bug rate, grep for how many *.c files
trigger the warning when built with -Wshadow - there's 695 of *those* in
my current config.

When I did a bunch of cleanups a while ago to make -Wundef work, I think
I scared up exactly one actual bug - but it was a subtle one in the NFS
code that wouldn't have been easu to find otherwise...


--==_Exmh_1152537827_25551P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEslTjcC3lWbTT17ARArdjAKCjeClmr+a9pYKeZqyT6c93PwyknwCgopkE
5rkWu066pEV4yKb1nwa7E3c=
=y7ks
-----END PGP SIGNATURE-----

--==_Exmh_1152537827_25551P--
