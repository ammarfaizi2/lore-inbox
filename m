Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131626AbQLPLaC>; Sat, 16 Dec 2000 06:30:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131676AbQLPL3w>; Sat, 16 Dec 2000 06:29:52 -0500
Received: from coruscant.franken.de ([193.174.159.226]:24595 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id <S131626AbQLPL3o>; Sat, 16 Dec 2000 06:29:44 -0500
Date: Sat, 16 Dec 2000 11:57:05 +0100
From: Harald Welte <laforge@gnumonks.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "Barry K. Nathan" <barryn@pobox.com>, Rusty Russell <rusty@linuxcare.com>,
        Marc Boucher <marc@mbsi.ca>, James Morris <jmorris@intercode.com.au>,
        linux-kernel@vger.kernel.org
Subject: Re: test13pre2 - netfilter modiles compile failure
Message-ID: <20001216115705.A6797@coruscant.gnumonks.org>
In-Reply-To: <Pine.LNX.4.10.10012160015521.11822-100000@penguin.transmeta.com> <Pine.LNX.4.10.10012160031450.11822-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10012160031450.11822-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Sat, Dec 16, 2000 at 12:42:53AM -0800
X-Operating-System: 2.4.0-test11p4
X-Date: Today is Prickle-Prickle, the 57th day of The Aftermath in the YOLD 3166
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 16, 2000 at 12:42:53AM -0800, Linus Torvalds wrote:
> 
>  - the DRM "true library" solution, as shown by drivers/char/drm/Makefile.
> 
>    This is closest to what the code tried to do before, and might be the
>    right solution for the "ip_nf_compat" module. However, it does result
>    in the same code being duplicated in multiple modules. Not very nice.

mmh... but this is no real problem, because the ipchains and ipfwadm
backwards compat modules are mutually exclusive.

>  - export more symbols (and mark the object files that export them as
>    "export-objs"), so that they are visible across module boundaries.
>    This is probably worth doing for at least the symbols
> 
> 	register_firewall(), ip_fw_masq_timeouts() and
> 	unregister_firewall()
> 
>    so that "ipchains" and "ipfwadm" could just cleanly be separate modules
>    on top of the "ip_fw_compat" module.

mmh.. but the ip_fw_compat layer without one of [ipchains, ipfwadm] doesn't
make sense at all. And ip_fw_compat is never going to be used more than once
because of the exclusiveness i've described above.

> Anyway, these kinds of things are really up to the netfilter people.
> 

As no other netfilter core team member responded yet, I'm going to provide 
a patch for the 'true library' solution.

> 		Linus

-- 
Live long and prosper
- Harald Welte / laforge@gnumonks.org                http://www.gnumonks.org
============================================================================
GCS/E/IT d- s-: a-- C+++ UL++++$ P+++ L++++$ E--- W- N++ o? K- w--- O- M- 
V-- PS+ PE-- Y+ PGP++ t++ 5-- !X !R tv-- b+++ DI? !D G+ e* h+ r% y+(*)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
