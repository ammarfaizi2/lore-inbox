Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264844AbUD1QBb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264844AbUD1QBb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 12:01:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264864AbUD1QBa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 12:01:30 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:6786 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S264844AbUD1QB2 (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 12:01:28 -0400
Message-Id: <200404281601.i3SG1Dl5018016@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: ncunningham@linuxmail.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: What does tainting actually mean? 
In-Reply-To: Your message of "Wed, 28 Apr 2004 15:18:35 +1000."
             <opr65ic90vshwjtr@laptop-linux.wpcb.org.au> 
From: Valdis.Kletnieks@vt.edu
References: <opr65eq9ncshwjtr@laptop-linux.wpcb.org.au> <20040428042742.GA1177@middle.of.nowhere> <opr65f48sfshwjtr@laptop-linux.wpcb.org.au> <408F3EE4.1080603@nortelnetworks.com>
            <opr65ic90vshwjtr@laptop-linux.wpcb.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-2048971323P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 28 Apr 2004 12:01:13 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-2048971323P
Content-Type: text/plain; charset=us-ascii

On Wed, 28 Apr 2004 15:18:35 +1000, Nigel Cunningham said:

> I don't know what module you're talking about, but surely there must be  
> something that could be done kernel-side to protect against such problems.  
> Reference counting or such like? I guess if it was a hardware issue, but  
> then again that might be an issue with too many assumptions being made  
> about prior state? Maybe I am being too naive :>

I once had the joy of debugging a memory overlay issue in an X.500 product,
that surfaced while porting from a "working" platform (IBM's AIX/370 product)
to IBM's AIX on the RS6K line.

The problem had the following characteristics:

It worked fine on AIX/370 (due to the way it's malloc() worked).
It worked fine on the RS6K if a debugging malloc() was used (and I tried
3 different ones).

It only crashed using the native malloc(), and the actual overlay happened
fairly early on, but the overlay's effects didn't become apparent till some 6
million (yes really) more malloc() calls allocated another 120M (yes really) on
the heap.  It was going *way* off the end of an allocated array, and the
canaries allocated by the AIX/370 and debugging mallocs caused the stray store
to hit non-critical data - but it hit a pointer used by the native malloc
(actually hopping over 2 entire other structures in the process), and said
botched pointer didn't surface till free() was called on that specific
structure.

Isn't much you can do kernel-side to protect against that sort of stray
pointer, unless you're using a tagged architecture like the late Intel i432
chipset.


--==_Exmh_-2048971323P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAj9VJcC3lWbTT17ARAhu2AJ0QdKSbBX+O2r3VLOPO77YedzLfOQCgg5Wt
VzrbG9F6jMHF3IMY0Y2Jvxc=
=D9GY
-----END PGP SIGNATURE-----

--==_Exmh_-2048971323P--
