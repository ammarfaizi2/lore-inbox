Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932278AbWJBNDE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932278AbWJBNDE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 09:03:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932280AbWJBNDE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 09:03:04 -0400
Received: from pool-72-66-199-147.ronkva.east.verizon.net ([72.66.199.147]:4805
	"EHLO turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S932278AbWJBNDC (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 09:03:02 -0400
Message-Id: <200610021302.k92D23W1003320@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Jim Gettys <jg@laptop.org>,
       John Stultz <johnstul@us.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
Subject: Re: [patch 00/21] high resolution timers / dynamic ticks - V2
In-Reply-To: Your message of "Sun, 01 Oct 2006 22:59:01 -0000."
             <20061001225720.115967000@cruncher.tec.linutronix.de>
From: Valdis.Kletnieks@vt.edu
References: <20061001225720.115967000@cruncher.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1159794123_2699P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 02 Oct 2006 09:02:03 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1159794123_2699P
Content-Type: text/plain; charset=us-ascii

On Sun, 01 Oct 2006 22:59:01 -0000, Thomas Gleixner said:
> the following patch series is an update in response to your review.

First runtime results - no lockups or other severe badness in a half-hour or so
of running.

-mm2-hrt-dynticks5 shows severe clock drift issues if you run 'cpuspeed'.

Using speedstep-ich as a kernel built-in, and cpuspeed is invoked as:

cpuspeed -d -n -i 10 -p 10 50 -a /proc/acpi/ac_adapter/*/state

If cpuspeed drops the CPU speed from the default 1.6Ghz down to 1.2Ghz (the
only 2 speeds available on this core), the system clock proceeds to lose
about 15 seconds a minute.  I haven't dug further into why yet. (If the system
is busy so cpuspeed keeps the processor at 1.6Ghz, the clock doesn't drift
as much - so it looks like a "when speed is 1.2Ghz" issue...)

I'm also seeing gkrellm reporting about 25% CPU use when "near-idle" (X is up
but not much is going on) when that's usually down around 5-6%.  I need to
collect some oprofile numbers and investigate that as well.

--==_Exmh_1159794123_2699P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFIQ3LcC3lWbTT17ARAucrAKCXWMB2Z45PAfp0krYYY715bOvylwCg9CIq
hStcnGocagt3EJS8jMFnw14=
=uKsL
-----END PGP SIGNATURE-----

--==_Exmh_1159794123_2699P--
