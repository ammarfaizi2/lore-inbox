Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267748AbUJGSsc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267748AbUJGSsc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 14:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267709AbUJGSq6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 14:46:58 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:5849 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S267708AbUJGSpl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 14:45:41 -0400
Message-Id: <200410071845.i97Ijcv2025341@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 07/26/2004 with nmh-1.1-RC3
To: Fabiano Ramos <ramos_fabiano@yahoo.com.br>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: strange AMD x Intel Behaviour in 2.4.26 
In-Reply-To: Your message of "Thu, 07 Oct 2004 15:15:36 -0300."
             <1097172936.3832.1.camel@lfs.barra.bali> 
From: Valdis.Kletnieks@vt.edu
References: <1097172936.3832.1.camel@lfs.barra.bali>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_53856430P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 07 Oct 2004 14:45:38 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_53856430P
Content-Type: text/plain; charset=us-ascii

On Thu, 07 Oct 2004 15:15:36 -0300, Fabiano Ramos said:

>   The code is producing correct results (same as ptrace, I mean)
> but is RUNNING FASTER on a 500Mhz AMD K6-2 than on a 2.6Ghz HT
> Pentium 4 !!!!  The monitored code runs faster on P4 if not being
> monitored, as expected.

Most likely, the old slow AMD chipset doesn't take a big performance
hit for each of the loops into debug-land, and the P4 chipset takes a
big hit.  Not sure if it's a pipeline-drain issue, or relative cost
of L1/2 cache misses, or what - an architecture expert could probably
say more.  Basically, the AMD goes faster because it has less to forget
at the end of each counted instruction, while the P4 gains much of its
speed via a lot of caching/decoding/pipelining tricks, so it has to throw
away more, and then re-establish state when it comes back.

Imagine 2 people walking down a hallway - one moves at 1 mile per hour
when walking, the other at 5.  However, every third step each of them drops
the stack of papers they are carrying - and the slow person drops 5 sheets
of paper and the fast one drops 200.  Who reaches the end of the hall first?

It's probably sort of like that....

--==_Exmh_53856430P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBZY7ScC3lWbTT17ARAvJpAKCt/IqFsrEwUSQPeocUuksmaXTlBQCg08mX
OBv/LYJaA2k5CrtD4DuBD+o=
=6XbY
-----END PGP SIGNATURE-----

--==_Exmh_53856430P--
