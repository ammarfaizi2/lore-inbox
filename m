Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263996AbTJ1PYN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 10:24:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263999AbTJ1PYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 10:24:13 -0500
Received: from h80ad275b.async.vt.edu ([128.173.39.91]:6547 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263996AbTJ1PYL (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 10:24:11 -0500
Message-Id: <200310281521.h9SFLQxF024354@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Pavel Machek <pavel@suse.cz>
Cc: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Patrick Mochel <mochel@osdl.org>, George Anzinger <george@mvista.com>,
       John stultz <johnstul@us.ibm.com>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [pm] fix time after suspend-to-* 
In-Reply-To: Your message of "Tue, 28 Oct 2003 10:32:33 +0100."
             <20031028093233.GA1253@elf.ucw.cz> 
From: Valdis.Kletnieks@vt.edu
References: <Pine.LNX.4.44.0310271535160.13116-100000@cherise> <1067329994.861.3.camel@teapot.felipe-alfaro.com>
            <20031028093233.GA1253@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1034812212P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 28 Oct 2003 10:21:26 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1034812212P
Content-Type: text/plain; charset=us-ascii

On Tue, 28 Oct 2003 10:32:33 +0100, Pavel Machek said:

> Not sure... We do not want applications to know. Certainly we can't
> send a signal; SIGPWR already has some meaning and it would be bad to
> override it.

You are correct that SIGPWR already has an assigned semantic.

However, I'm not convinced that we don't want applications to know.
Others have mentioned timeouts of network connections, and there's other
issues as well - for instance, on my laptop, it is almost guaranteed (due to my
work habits) that if I were to suspend it, when it wakes up the network
configuration would be *wrong*.  It's possible to intuit what the right
config is by looking at the number of ethernets and their link state, but
that requires a wakeup of *something* in userspace - blindly going on
as if nothing happened simply won't work.

Would having a pair of 'sleep/wakeup' calls in /etc/inittab (similar to the
powerfail/powerok pair) be a solution here?  

--==_Exmh_1034812212P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/nol2cC3lWbTT17ARAoj1AKC3lphuTtz3/o6gda1Oo09Zik8xkACcC3y0
tDlpFQFYcHRp6JMX/Y+ZFCo=
=G4Se
-----END PGP SIGNATURE-----

--==_Exmh_1034812212P--
