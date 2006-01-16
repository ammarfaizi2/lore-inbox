Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751150AbWAPSsI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbWAPSsI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 13:48:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751159AbWAPSsI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 13:48:08 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:42413 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1751150AbWAPSsH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 13:48:07 -0500
Message-Id: <200601161848.k0GIm3xH016052@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Shared memory usage 
In-Reply-To: Your message of "Mon, 16 Jan 2006 09:15:16 EST."
             <Pine.LNX.4.61.0601160909590.22754@chaos.analogic.com> 
From: Valdis.Kletnieks@vt.edu
References: <Pine.LNX.4.61.0601160909590.22754@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1137437283_3744P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 16 Jan 2006 13:48:03 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1137437283_3744P
Content-Type: text/plain; charset=us-ascii

On Mon, 16 Jan 2006 09:15:16 EST, "linux-os (Dick Johnson)" said:
> But the customer complained during certification testing
> that shared memory in use is not measured and therefore
> cannot be verified. This means that there may be rogue
> communications channels, using shared memory, in the
> system. I need to prove that there are no such channels
> by metering the shared memory and then accounting for
> every bit shown.

The customer is confused, and your test is broken as designed.

The fact that you look in /proc/meminfo and account for every shared
memory page *at this instant* doesn't mean there isn't a communication
channel *at some other time*. Even if you run a daemon that does nothing
but monitor this usage 10 times a second, and complain if a discrepancy
is found, it *still* won't work:

1) It's racy - 2 processes can mmap() some space during that 0.1 seconds,
transfer the info, and detach the memory without your knowledge.

2) It's racy - if you inquire *while* some other process is in some intermediate
state, causing false positives that will drive the SSO nuts.

The *proper* solution is to use something like SELinux that will flat-out
*prohibit* the attachment of a shared memory segment that isn't permitted.

--==_Exmh_1137437283_3744P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFDy+pjcC3lWbTT17ARAnxaAJ0ZFXiGSMhGNKmW2ALxeZtV1pr4zQCdHPVZ
tfJB+D0XCjTB15icP/+KDmw=
=wSnv
-----END PGP SIGNATURE-----

--==_Exmh_1137437283_3744P--
