Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264732AbUEUX5x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264732AbUEUX5x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 19:57:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264692AbUEUXyI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 19:54:08 -0400
Received: from turing-police.cirt.vt.edu ([128.173.54.129]:4484 "EHLO
	turing-police.cirt.vt.edu") by vger.kernel.org with ESMTP
	id S265181AbUEUXgS (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 19:36:18 -0400
Message-Id: <200405212336.i4LNa5lJ015312@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Jirka Kosina <jikos@jikos.cz>
Cc: linux-kernel@vger.kernel.org, pekkas@netcore.fi, davem@redhat.com
Subject: Re: [PATCH] IPv6 can't be built as module additionally 
In-Reply-To: Your message of "Fri, 21 May 2004 00:16:06 +0200."
             <Pine.LNX.4.58.0405210007240.25914@twin.jikos.cz> 
From: Valdis.Kletnieks@vt.edu
References: <Pine.LNX.4.58.0405210007240.25914@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_669016182P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 21 May 2004 19:36:05 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_669016182P
Content-Type: text/plain; charset=us-ascii

On Fri, 21 May 2004 00:16:06 +0200, Jirka Kosina said:

> It is not possible to build ipv6 for already compiled and running kernel, 
> recompilation of whole kernel, even if building as a module, is typically 
> a must. This is because ipv6-specific functions in drivers/char/random.c 
> are inside #ifdefs, and as random.c is almost always built directly into 
> kernel, recompilation of whole kernel can't be avoided.

What you're getting bit by is the fact that some heavily-used kernel structures
get their size changed when you define CONFIG_IPV6, and *that* forces
the rebuild.

Rebuilding random.o should be relatively fast - that's 1 CC, then a few LD's
to rebuild drivers/char/built-in.o, then drivers/build-in.o, then increment the
kernel build version, and rebuild vmlinux.  Shouldn't be more than 30-40 lines of
output, total.  

In addition, the proposed removal of the ifdef's causes bloat in random.c for
those systems that don't configure it.  So it's a bad fix for the wrong problem...

--==_Exmh_669016182P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFArpJlcC3lWbTT17ARAkXfAKCvZrojKyIQpLvjgoZARoVg49AJYACgw4Uu
DnU640LdCKCJ6Ki6qPJUjOs=
=eHGC
-----END PGP SIGNATURE-----

--==_Exmh_669016182P--
