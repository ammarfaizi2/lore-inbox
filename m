Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267901AbUJGTbL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267901AbUJGTbL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 15:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267772AbUJGT3d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 15:29:33 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:4291 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S267841AbUJGT1b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 15:27:31 -0400
Message-Id: <200410071927.i97JRQKO006355@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 07/26/2004 with nmh-1.1-RC3
To: "David S. Miller" <davem@davemloft.net>
Cc: arun.sharma@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Kill a sparse warning in binfmt_elf.c 
In-Reply-To: Your message of "Thu, 07 Oct 2004 12:16:23 PDT."
             <20041007121623.674796d1.davem@davemloft.net> 
From: Valdis.Kletnieks@vt.edu
References: <4164756E.4010408@intel.com> <200410071811.i97IBQf0031262@turing-police.cc.vt.edu> <41658FB4.5090402@intel.com> <200410071854.i97IsvU5031703@turing-police.cc.vt.edu>
            <20041007121623.674796d1.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_68684898P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 07 Oct 2004 15:27:26 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_68684898P
Content-Type: text/plain; charset=us-ascii

On Thu, 07 Oct 2004 12:16:23 PDT, "David S. Miller" said:

> The caller's aren't, that is the point.  They run dump_write()
> with set_fs(KERNEL_DS), which allows kernel pointers to be treated
> as user ones in system call handling paths, which is why the cast
> is needed somewhere.

Right - and my point is that putting one cast way down at the bottom
to quiet a warning doesn't do much good - the cast should be pushed
up to as close to that set_fs() as feasible.  Otherwise if some other,
new, caller surfaces and bogusly passes something *else* in that
void * pointer, it gets a lot harder for sparse and similar to do their
jobs. 


--==_Exmh_68684898P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBZZiecC3lWbTT17ARAn6HAJ9MkB/1noTVsKBfbWYsqMBK2cYfbwCdEMaI
2OVRSwrzlkOnDMvOUL0JaXk=
=DZOA
-----END PGP SIGNATURE-----

--==_Exmh_68684898P--
