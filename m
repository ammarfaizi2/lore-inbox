Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267690AbTBLUqV>; Wed, 12 Feb 2003 15:46:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267699AbTBLUqV>; Wed, 12 Feb 2003 15:46:21 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:64897 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S267690AbTBLUqT>; Wed, 12 Feb 2003 15:46:19 -0500
Message-Id: <200302122056.h1CKu5pk009488@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6 02/09/2003 with nmh-1.0.4+dev
To: linux-kernel@vger.kernel.org
Subject: 2.5.60 - early Debug message.
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1021228468P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 12 Feb 2003 15:56:05 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1021228468P
Content-Type: text/plain; charset=us-ascii

Dell Latitude C840 laptop.  Didn't see this under 2.5.59.

Calibrating delay loop... 3145.72 BogoMIPS
Memory: 255056k/262024k available (2010k kernel code, 6248k reserved, 895k data,
 104k init, 0k highmem)
Debug: sleeping function called from illegal context at mm/slab.c:1618
Call Trace:
 [<c0135353>] kmem_cache_alloc+0x51/0x55
 [<c013490f>] kmem_cache_create+0x6c/0x448
 [<c0105000>] _stext+0x0/0x22

Security Scaffold v1.0.0 initialized

System continues on just fine however.  Quick perusal of the source seems
to smell like an uninitialized flag in a function call, but I don't know
where. The call trace seems wonky - addresses near _stext in the System.map:

c0104000 T empty_zero_page
c0105000 T _stext
c0105000 T stext
c0105000 t rest_init
c0105022 t do_pre_smp_initcalls
c010502b t init
c010517d t unlock_kernel

but unless there's some macro-expansion wizardry none of these guys call
kmem_cache_create directly, so it seems almost like some stack frames are
missing.

Does this ring a bell, or does anybody have a hint how to start debugging
this?  

-- 
				Valdis Kletnieks
				Computer Systems Senior Engineer
				Virginia Tech

--==_Exmh_1021228468P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+SrTlcC3lWbTT17ARAnLgAKDMVz9gu74qYaD/X31JzdddC2UA2ACaAjPo
UIVCcGFX3dLGbqFAnKK+lRE=
=kY9p
-----END PGP SIGNATURE-----

--==_Exmh_1021228468P--
