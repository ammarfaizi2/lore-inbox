Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261463AbTBKS5I>; Tue, 11 Feb 2003 13:57:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264920AbTBKS5I>; Tue, 11 Feb 2003 13:57:08 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:47233 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S261463AbTBKS5H>; Tue, 11 Feb 2003 13:57:07 -0500
Message-Id: <200302111906.h1BJ6gU6006172@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6 02/09/2003 with nmh-1.0.4+dev
To: dank@suburbanjihad.net (nick black)
Cc: linux-kernel@vger.kernel.org
Subject: Re: checksumming with mmx, comment in arch/i386/lib/mmx.c 
In-Reply-To: Your message of "Tue, 11 Feb 2003 13:37:07 EST."
             <20030211183707.GA23376@suburbanjihad.net> 
From: Valdis.Kletnieks@vt.edu
References: <20030211183707.GA23376@suburbanjihad.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-52381134P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 11 Feb 2003 14:06:42 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-52381134P
Content-Type: text/plain; charset=us-ascii

On Tue, 11 Feb 2003 13:37:07 EST, dank@suburbanjihad.net (nick black)  said:

> firstly, to what domain of checksums does this comment apply?  secondly,
> why is it true?  it seems the PADDW family of instructions could work
> well here; is the slowdown a result of the kernel's need to muck with
> fpu state (from what i can tell, mmx uses the fp registers)?

(Note - second-hand info from somebody else who looked at MMX/SSE to optimize
an inner loop.  Double-check with CPU documentation).

There's a big "urp" sound as the processor switches from FP to MMX mode and
back, which apparently takes a large number of cycles.  You can to some extent
amortize this if you're switching once for a LONG loop (the analysis I saw was
with a million or so pixels on a screen image) - if you're switching in and out
for a 1500 byte packet (or even worse, a 100-byte packet) the impact may be
more noticable. You may wish to examine the SSE/SSE2 opcodes, which apparently
don't take this performance hit.

-- 
				Valdis Kletnieks
				Computer Systems Senior Engineer
				Virginia Tech


--==_Exmh_-52381134P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+SUnCcC3lWbTT17ARAlY6AKDhqn32LRNYjqAFjc0dXwbxcXpKaACg7wp9
FEkuOf/VKV8EqxF1IjeaLpc=
=qcPo
-----END PGP SIGNATURE-----

--==_Exmh_-52381134P--
