Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161194AbWJDKBt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161194AbWJDKBt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 06:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030791AbWJDKBt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 06:01:49 -0400
Received: from pool-72-66-199-147.ronkva.east.verizon.net ([72.66.199.147]:32707
	"EHLO turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1030790AbWJDKBs (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 06:01:48 -0400
Message-Id: <200610040958.k949w7ur029526@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Ingo Molnar <mingo@elte.hu>
Cc: tglx@linutronix.de, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, Jim Gettys <jg@laptop.org>,
       John Stultz <johnstul@us.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
Subject: Re: [patch] dynticks core: Fix idle time accounting
In-Reply-To: Your message of "Wed, 04 Oct 2006 09:56:57 +0200."
             <20061004075657.GA31485@elte.hu>
From: Valdis.Kletnieks@vt.edu
References: <20061001225720.115967000@cruncher.tec.linutronix.de> <200610021302.k92D23W1003320@turing-police.cc.vt.edu> <1159796582.1386.9.camel@localhost.localdomain> <200610021825.k92IPSnd008215@turing-police.cc.vt.edu> <1159814606.1386.52.camel@localhost.localdomain> <200610022017.k92KH4Ch004773@turing-police.cc.vt.edu> <1159824158.1386.77.camel@localhost.localdomain> <200610022135.k92LZHCn008618@turing-police.cc.vt.edu> <1159905750.1386.215.camel@localhost.localdomain> <200610040233.k942Xk1v004859@turing-police.cc.vt.edu>
            <20061004075657.GA31485@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1159955886_3267P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 04 Oct 2006 05:58:07 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1159955886_3267P
Content-Type: text/plain; charset=us-ascii

On Wed, 04 Oct 2006 09:56:57 +0200, Ingo Molnar said:
> 
> * Valdis.Kletnieks@vt.edu <Valdis.Kletnieks@vt.edu> wrote:
> 
> > Even though I have CONFIG_HZ=1000, this ends up generating a synthetic 
> > count that works out to 100 per second.  gkrellm and vmstat are happy 
> > with that state of affairs, but I'm not sure why it came out to 
> > 100/sec rather than 1000/sec.
> 
> that's how it worked for quite some time: all userspace APIs are 
> HZ-independent and depend on USER_HZ (which is 100 even if HZ is 1000).

Nevermind - I missed where fs/proc/proc_misc.c applied jiffies_64_to_clock_t()
to the number before handing it to userspace.  So the numbers *were* being
kept in terms of HZ (as my reading of the code indicated), they just didn't
manage to escape to userspace that way....




--==_Exmh_1159955886_3267P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFI4WucC3lWbTT17ARAt0qAJ9Yd0+cZTxkH3vV3zhU1L59kOQ77gCgsQL6
knlDSxx7QbUUxpsoxCKIKL0=
=LdTd
-----END PGP SIGNATURE-----

--==_Exmh_1159955886_3267P--
