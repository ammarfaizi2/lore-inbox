Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262010AbTHTPOk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 11:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262012AbTHTPOk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 11:14:40 -0400
Received: from 13.2-host.augustakom.net ([80.81.2.13]:36510 "EHLO phoebee")
	by vger.kernel.org with ESMTP id S262010AbTHTPOh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 11:14:37 -0400
Date: Wed, 20 Aug 2003 17:14:31 +0200
From: Martin Zwickel <martin.zwickel@technotrend.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.6.0-t3: vfs/ext3 do_lookup bug?!
Message-Id: <20030820171431.0211930e.martin.zwickel@technotrend.de>
Organization: TechnoTrend AG
X-Mailer: Sylpheed version 0.9.4claws17 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Operating-System: Linux Phoebee 2.4.21-rc4 i686 Intel(R) Pentium(R) 4 CPU
 2.40GHz
X-Face: $rTNP}#i,cVI9h"0NVvD.}[fsnGqI%3=N'~,}hzs<FnWK/T]rvIb6hyiSGL[L8S,Fj`u1t.
 ?J0GVZ4&
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.h1Qq5GvK6'yC8."
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.h1Qq5GvK6'yC8.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi there!

Today I wanted to check out some src-files from cvs.
But my fault was, that I ran cvs twice at the same time.

so two "cvs upd -d -A" are now in 'D' state.

I think they got stuck because both tried to access the same file.


#ps lax
4     0 11833 11832  15   0  4136 2664 down   D    pts/18     0:07 cvs upd -d -A
4     0 11933 11932  22   0  2672 1180 down   D    pts/19     0:00 cvs upd -d -A

#sysrq-t + dmesg:
cvs           D 00000196 294197680 11833  11832                     (NOTLB)
dc84de5c 00000082 d2314a0c 00000196 d23148fc dc84de58 cafba080 cccee770 
       00000282 cafba080 cccee778 c0107f8e 00000001 cafba080 c0119687 d49d3e94 
       cccee778 dc84de7c 00000000 d919a9f0 00000000 cccee770 cccee708 d919a980 
Call Trace:
 [<c0107f8e>] __down+0x7c/0xc7
 [<c0119687>] default_wake_function+0x0/0x2e
 [<c0108118>] __down_failed+0x8/0xc
 [<c0159df3>] .text.lock.namei+0x5/0x16a
 [<c0156c98>] do_lookup+0x96/0xa1
 [<c0157077>] link_path_walk+0x3d4/0x762
 [<c0157c57>] open_namei+0x8e/0x3f3
 [<c014a265>] filp_open+0x43/0x69
 [<c014a64c>] sys_open+0x5b/0x8b
 [<c0109063>] syscall_call+0x7/0xb

cvs           D C8E86424 297794096 11933  11932                     (NOTLB)
d49d3e80 00000086 c03a561b c8e86424 00000001 d092d408 c2dd2080 cccee770 
       00000286 c2dd2080 cccee778 c0107f8e 00000001 c2dd2080 c0119687 cccee778 
       dc84de70 d49d3f38 dffe46c0 d49d3ee4 00000000 cccee770 cccee708 d919a980 
Call Trace:
 [<c0107f8e>] __down+0x7c/0xc7
 [<c0119687>] default_wake_function+0x0/0x2e
 [<c0108118>] __down_failed+0x8/0xc
 [<c0159df3>] .text.lock.namei+0x5/0x16a
 [<c0156c98>] do_lookup+0x96/0xa1
 [<c0157077>] link_path_walk+0x3d4/0x762
 [<c015783c>] __user_walk+0x49/0x5e
 [<c0149be1>] sys_access+0x93/0x150
 [<c015393d>] sys_stat64+0x37/0x39
 [<c0109063>] syscall_call+0x7/0xb


So is it a kernel bug? the down in do_lookup shouldn't lock the process
forever...

Regards,
Martin

-- 
MyExcuse:
The salesman drove over the CPU board.

Martin Zwickel <martin.zwickel@technotrend.de>
Research & Development

TechnoTrend AG <http://www.technotrend.de>

--=.h1Qq5GvK6'yC8.
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/Q5BZmjLYGS7fcG0RAvWWAJwJx0FxEf5OHGi3H5MLcG9yZoCVQgCbBjJv
OAAfwsMLZ0s9FZxO9aFBPhk=
=b+lh
-----END PGP SIGNATURE-----

--=.h1Qq5GvK6'yC8.--
