Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262209AbULQWmp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262209AbULQWmp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 17:42:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262213AbULQWmp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 17:42:45 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:61661 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S262209AbULQWmm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 17:42:42 -0500
Message-Id: <200412172242.iBHMgVav003005@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 10/11/2004 with nmh-1.1-RC3
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.10-rc3-mm1-V0.7.33-03 and NVidia wierdness, with workaround... 
In-Reply-To: Your message of "Fri, 17 Dec 2004 16:52:34 EST."
             <1103320354.3538.11.camel@localhost.localdomain> 
From: Valdis.Kletnieks@vt.edu
References: <200412161626.iBGGQ5CI020770@turing-police.cc.vt.edu> <1103300362.12664.53.camel@localhost.localdomain> <1103303011.12664.58.camel@localhost.localdomain> <200412171810.iBHIAQP3026387@turing-police.cc.vt.edu> <1103313861.12664.71.camel@localhost.localdomain>
            <1103320354.3538.11.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_80231966P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 17 Dec 2004 17:42:31 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_80231966P
Content-Type: text/plain; charset=us-ascii

On Fri, 17 Dec 2004 16:52:34 EST, Steven Rostedt said:

> I just tried it again, but this time with V0.7.33-04 and it still has
> the same problems.  I also forced the nv.c not use the class_simple
> code. But it still breaks on start-up.  Do you have either
> CONFIG_DEBUG_SPINLOCK_SLEEP or CONFIG_DEBUG_PREEMPT defined?  If not,
> you won't see the dump I see with the might_sleep. This is only tested
> if you have either of the two configure.

I had SPINLOCK_SLEEP defined on -rc3-mm1, and have DEBUG_PREEMPT defined both
now and on the base -rc3-mm1. So at least on my box with a UP kernel, neither
of those is a problem... (SPINLOCK_SLEEP doesn't show up on -RT because of an
added Kconfig 'depends on !DEBUG_PREEMPT' the -RT patch adds).
 
> But just to let you know, here's the dump when it happens.

> BUG: sleeping function called from invalid context XFree86(5029) at kernel/rt.c:1443

Hmm.. best I can do is:

Dec 13 11:59:06 turing-police kernel:  <3>BUG: sleeping function called from invalid context sendmail(10011) at include/linux/rwsem.h:47

Multiple hits on rwsem.h:47, sendmail/gpg/bash, only on V0.7.31-15, nothing
X-related, and quite possibly due to my ham-handed attempt to make Ingo's
-rc2-mm3 patch apply to -rc2-mm4 myself. ;)

Most likely, the fact you have SMP/HT and I'm just on a PREEMPT-UP kernel is
what's making the difference.  There's almost certainly a '#ifdef CONFIG_SMP'
involved here somehow....

--==_Exmh_80231966P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBw2DVcC3lWbTT17ARAiZrAKCHzIn2j6Qdr4mnSBuqoa7fWqLw5ACfZHQ4
zEVi5Mb597XI180BsPoNXDc=
=4814
-----END PGP SIGNATURE-----

--==_Exmh_80231966P--
