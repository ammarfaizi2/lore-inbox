Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262127AbVA0HWo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262127AbVA0HWo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 02:22:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262529AbVA0HWo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 02:22:44 -0500
Received: from h80ad2540.async.vt.edu ([128.173.37.64]:8459 "EHLO
	h80ad2540.async.vt.edu") by vger.kernel.org with ESMTP
	id S262127AbVA0HU4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 02:20:56 -0500
Message-Id: <200501270720.j0R7Kmei002741@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: ych43 <ych43@student.canterbury.ac.nz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: how to check the validity of a running daemon on Linux 
In-Reply-To: Your message of "Thu, 27 Jan 2005 15:33:49 +1300."
             <41F0CDD6@webmail> 
From: Valdis.Kletnieks@vt.edu
References: <41F0CDD6@webmail>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1106810447_17814P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 27 Jan 2005 02:20:48 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1106810447_17814P
Content-Type: text/plain; charset=us-ascii

On Thu, 27 Jan 2005 15:33:49 +1300, ych43 said:

>   Does anybody know how to check the validity of a deamon. which runs on Linux 
> -platform host . This daemon can save some information in a log file of the 
> host. I mean that if an attacker compromises this host and gets root access, 
> he can replace this daemon with a rogue version. Therfefore, the information 
> saved on the log file is incorrect. So how can I check the validity of the 
> daemon to show this  daemon is correct version and not a rogue version. So I 
> trust the information saved on the host.

If you trust your kernel, there's several ways:

1) There's Tripwire and Aide (http://aide.sf.net) for cronjob-style checking
of your system.

2) There's the DigSig patches, and Fedora kernels have a 'modsign' patch, both of
which use digital signatures checked at exec() time to prevent tampering.  I
haven't checked whether either of those will detect the case of subverting the
daemon by means of code that's actually in some libshared.so rather than
modifying the daemon binary itself.

If you don't trust your kernel (for instance, if you suspect that the attacker
has loaded a kernel module that hides his activities - building your kernel
without module support does *NOT*, repeat *NOT* stop this attack), your only
choice is to boot from known trusted media (a CD-based rescue disk or Knoppix
or similar) and compare the binary that's on your system to a "known good"
copy on the CD.

This of course requires that you trust your system BIOS.  If you don't trust
that, you're on your own.  I hear tin foil is on sale down at the local market ;)

--==_Exmh_1106810447_17814P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFB+JZPcC3lWbTT17ARAmcAAKC2EOuuaTB/pr5eWAnBT+vsjVMClgCfbzMT
uGObnpMLr7bjEHNqlc9cLyI=
=xCmN
-----END PGP SIGNATURE-----

--==_Exmh_1106810447_17814P--
