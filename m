Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261430AbULPQ0f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261430AbULPQ0f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 11:26:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261183AbULPQ0a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 11:26:30 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:55529 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261523AbULPQ0M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 11:26:12 -0500
Message-Id: <200412161626.iBGGQ5CI020770@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 10/11/2004 with nmh-1.1-RC3
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.10-rc3-mm1-V0.7.33-03 and NVidia wierdness, with workaround...
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-787537636P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 16 Dec 2004 11:26:05 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-787537636P
Content-Type: text/plain; charset="us-ascii"
Content-Id: <16488.1103214353.1@turing-police.cc.vt.edu>

(Yes, I know NVidia is evil and all that.. If you're not Ingo or NVidia,
consider this "documenting the workaround" ;)

For reasons I can't explain, the NVidia module won't initialize
correctly with V0-0.7.33-03 if built with CONFIG_SPINLOCK_BKL.  It however
works fine with CONFIG_PREEMPT_BKL, changing nothing else in the config.
It also works fine with 2.6.10-rc3-mm1 without Ingo's patch.

Relevant .config snippet from the /proc/config.gz I'm running with right now:

# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT_DESKTOP=y
# CONFIG_PREEMPT_RT is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_SOFTIRQS=y
CONFIG_PREEMPT_HARDIRQS=y
# CONFIG_SPINLOCK_BKL is not set
CONFIG_PREEMPT_BKL=y

If built with SPINLOCK_BKL, we get this in the kernel messages:

Dec 16 01:12:41 turing-police kernel: NVRM: rm_init_adapter failed

rm_init_adapter is in NVidia's binary code, so I can't shoot it.

The *odd* part is that it's failing with the spinlock but *not* the preempt version
or the unpatched version. (I was *expecting* that code that was happy with
the old-style BKL in -mm1 would be happy with the spinlock version and complain
if somebody hit the preempt flavor, not the other way around...)

Ingo? This ring any bells?

--==_Exmh_-787537636P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBwbcccC3lWbTT17ARAiKCAKCQ8RTIOZVyar21ZVVwjoH2PzFGYACgjuZo
W3XEauHD1Msnwe8nYPLdfbE=
=OBpG
-----END PGP SIGNATURE-----

--==_Exmh_-787537636P--
