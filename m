Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268297AbTBMVFN>; Thu, 13 Feb 2003 16:05:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268298AbTBMVFN>; Thu, 13 Feb 2003 16:05:13 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:8068 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S268297AbTBMVFI>; Thu, 13 Feb 2003 16:05:08 -0500
Message-Id: <200302132114.h1DLEmFT010583@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6 02/09/2003 with nmh-1.0.4+dev
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.60-bk pdflush oops. 
In-Reply-To: Your message of "Thu, 13 Feb 2003 20:56:08 GMT."
             <20030213205608.GB24109@codemonkey.org.uk> 
From: Valdis.Kletnieks@vt.edu
References: <20030213205608.GB24109@codemonkey.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1882242768P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 13 Feb 2003 16:14:48 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1882242768P
Content-Type: text/plain; charset=us-ascii


> Looking back through the logs, this also this bizarre snippet during boot:-
> 
> Feb 13 20:30:24 mesh kernel: Checking if this processor honours the WP bit ev
en in supervisor mode... Ok.
> Feb 13 20:30:24 mesh kernel: Call Trace:
> Feb 13 20:30:24 mesh kernel:  [<c014a8b4>] kmem_cache_alloc+0x134/0x140
> Feb 13 20:30:24 mesh kernel:  [<c014916f>] kmem_cache_create+0xbf/0x5a0
> Feb 13 20:30:24 mesh kernel:  [<c0105000>] _stext+0x0/0x30
> Feb 13 20:30:24 mesh kernel: 
> Feb 13 20:30:24 mesh kernel: Dentry cache hash table entries: 16384 (order: 5
, 131072 bytes)

I caught this one too:

Memory: 255056k/262024k available (2010k kernel code, 6248k reserved, 895k data,
 104k init, 0k highmem)
Debug: sleeping function called from illegal context at mm/slab.c:1618
Call Trace:
 [<c0135353>] kmem_cache_alloc+0x51/0x55
 [<c013490f>] kmem_cache_create+0x6c/0x448
 [<c0105000>] _stext+0x0/0x22

Security Scaffold v1.0.0 initialized
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)

So it's after test_wp_bit() is called, and before security_scaffolding_startup().

Interesting that you didn't get the 'sleeping function called' message?

--==_Exmh_1882242768P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+TArIcC3lWbTT17ARAuMBAJ4jY7EAc13HJs1u9t19ClfHt2F5qwCg37Dy
SZm41D7UMM4r6ChAG/xlMA0=
=kS0L
-----END PGP SIGNATURE-----

--==_Exmh_1882242768P--
