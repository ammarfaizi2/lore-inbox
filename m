Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161168AbWGIVmE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161168AbWGIVmE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 17:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161171AbWGIVmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 17:42:04 -0400
Received: from pool-72-66-195-15.ronkva.east.verizon.net ([72.66.195.15]:36803
	"EHLO turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1161168AbWGIVmD (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 17:42:03 -0400
Message-Id: <200607092133.k69LXBuA008132@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-kernel@vger.kernel.org, johnstul@us.ibm.com, pavel@ucw.cz
Subject: Re: [BUG] APM resume breakage from 2.6.18-rc1 clocksource changes
In-Reply-To: Your message of "Sun, 09 Jul 2006 22:58:31 +0200."
             <200607092058.k69KwVxN026427@harpo.it.uu.se>
From: Valdis.Kletnieks@vt.edu
References: <200607092058.k69KwVxN026427@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1152480699_7106P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 09 Jul 2006 17:31:39 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1152480699_7106P
Content-Type: text/plain; charset=us-ascii

On Sun, 09 Jul 2006 22:58:31 +0200, Mikael Pettersson said:

> I've traced the cause of this problem to the i386 time-keeping
> changes in kernel 2.6.17-git11. What happens is that:
> - The kernel autoselects TSC as my clocksource, which is
>   reasonable since it's a PentiumII. 2.6.17 also chose the TSC.
> - Immediately after APM resumes (arch/i386/kernel/apm.c line
>   1231 in 2.6.18-rc1) there is an interrupt from the PIT,
>   which takes us to kernel/timer.c:update_wall_time().
> - update_wall_time() does a clocksource_read() and computes
>   the offset from the previous read. However, the TSC was
>   reset by HW or BIOS during the APM suspend/resume cycle and
>   is now smaller than it was at the prevous read. On my machine,
>   the offset is 0xffffffd598e0a566 at this point, which appears
>   to throw update_wall_time() into a very very long loop.

Does applying this patch make it work?

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc1/2.6.18-rc1-mm1/broken-out/adjust-clock-for-lost-ticks.patch

Or is this a different breakage?

--==_Exmh_1152480699_7106P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEsXW7cC3lWbTT17ARAhn+AJ9Y2LqrJTFZwDvlXAeD2KdE0pir+gCg+Tm9
QzkKPA5tCdZurT2o4NoUUL4=
=Kneg
-----END PGP SIGNATURE-----

--==_Exmh_1152480699_7106P--
