Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262667AbUCERyy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 12:54:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262666AbUCERyy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 12:54:54 -0500
Received: from turing-police.cirt.vt.edu ([128.173.54.129]:23814 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S262664AbUCERyv (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 12:54:51 -0500
Message-Id: <200403051754.i25Hsjg7015052@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-rc1-mm[12] - dm_any_congested issues 
In-Reply-To: Your message of "Tue, 02 Mar 2004 20:15:36 PST."
             <20040302201536.52c4e467.akpm@osdl.org> 
From: Valdis.Kletnieks@vt.edu
References: <20040302201536.52c4e467.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1521482988P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 05 Mar 2004 12:54:45 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1521482988P
Content-Type: text/plain; charset=us-ascii

On Tue, 02 Mar 2004 20:15:36 PST, Andrew Morton <akpm@osdl.org>  said:

(Added in -rc1-mm1 which I didn't try, problem noticed in -rc2-mm2)

> queue-congestion-dm-implementation.patch
>   Implement queue congestion callout for device mapper

This is causing the following trace every second or 2 on my laptop:

Mar  4 17:47:26 turing-police kernel: Debug: sleeping function called from invalid context at include/linux/rwsem.h:43
Mar  4 17:47:26 turing-police kernel: in_atomic():1, irqs_disabled():0
Mar  4 17:47:27 turing-police kernel: Call Trace:
Mar  4 17:47:27 turing-police kernel:  [__might_sleep+159/168] __might_sleep+0x9f/0xa8
Mar  4 17:47:27 turing-police kernel:  [dm_any_congested+19/67] dm_any_congested+0x13/0x43
Mar  4 17:47:27 turing-police kernel:  [sync_sb_inodes+212/592] sync_sb_inodes+0xd4/0x250
Mar  4 17:47:27 turing-police kernel:  [writeback_inodes+87/155] writeback_inodes+0x57/0x9b
Mar  4 17:47:27 turing-police kernel:  [wb_kupdate+197/311] wb_kupdate+0xc5/0x137
Mar  4 17:47:27 turing-police kernel:  [__pdflush+278/441] __pdflush+0x116/0x1b9
Mar  4 17:47:27 turing-police kernel:  [pdflush+15/17] pdflush+0xf/0x11
Mar  4 17:47:27 turing-police kernel:  [wb_kupdate+0/311] wb_kupdate+0x0/0x137
Mar  4 17:47:27 turing-police kernel:  [kthread+106/147] kthread+0x6a/0x93
Mar  4 17:47:27 turing-police kernel:  [pdflush+0/17] pdflush+0x0/0x11
Mar  4 17:47:27 turing-police kernel:  [kthread+0/147] kthread+0x0/0x93
Mar  4 17:47:27 turing-police kernel:  [kernel_thread_helper+5/11] kernel_thread_helper+0x5/0xb

Of course backing it out makes the messages go away, since dm_any_congested()
was added by that patch.  This patch just not ready for prime time, or am I (as usual)
managing to trip over some silly corner case due to odd configuration?

--==_Exmh_-1521482988P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFASL7kcC3lWbTT17ARAisPAKCHdwywvjZyMFJGc+TWxtNMyQJ37ACg2DEi
u2BLaEpDMd9e3hqpyh3kpYQ=
=RuYb
-----END PGP SIGNATURE-----

--==_Exmh_-1521482988P--
