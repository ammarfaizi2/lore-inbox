Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261862AbVEPUUP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261862AbVEPUUP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 16:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261863AbVEPUTr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 16:19:47 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:12046 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261862AbVEPUTJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 16:19:09 -0400
Message-Id: <200505162018.j4GKIakq017333@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Reiner Sailer <sailer@us.ibm.com>
Cc: linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au,
       davem@davemloft.net, linux-kernel@vger.kernel.org
Subject: Re: crypto api initialized late 
In-Reply-To: Your message of "Mon, 16 May 2005 15:15:22 EDT."
             <Pine.WNT.4.63.0505161359560.840@laptop> 
From: Valdis.Kletnieks@vt.edu
References: <Pine.WNT.4.63.0505161359560.840@laptop>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1116274714_5623P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 16 May 2005 16:18:35 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1116274714_5623P
Content-Type: text/plain; charset=us-ascii

On Mon, 16 May 2005 15:15:22 EDT, Reiner Sailer said:
> 
> I am writing a Linux Security Module that needs SHA1 support very early in 
> the kernel startup (before any fs are mounted,modules are loaded,  or 
> files are mapped; including initrd). Therefore, I use the __initcall 
> to initialize the security module. SHA1 can currently be used only 
> through the crypto-api (static definitions and hidden context structure).
> 
> This crypto-API, however, initializes AFTER the security module
> code in the __initicall block. Currently, I use the following patch into 
> the main Linux Makefile to start up the crypto-API earlier:

I hit the same problem trying to add sysctl's from inside the LSM.  What I
ended up doing was letting the security_initcall() set up the *other* stuff I
needed, and then had a regular initcall() that ended up called after sysctl was
initialized, but before we went to userspace.  I'm pretty sure that all the
initcall chails get run before we mount the initrd and all that.


--==_Exmh_1116274714_5623P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCiQAacC3lWbTT17ARAoK4AKDjVGAa2rvsrVlhKaYQy2vVfkxwHQCg4/I6
MrG71DpcWDY5s8xKHxDekQA=
=7ywl
-----END PGP SIGNATURE-----

--==_Exmh_1116274714_5623P--
