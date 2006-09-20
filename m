Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751625AbWITPzN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751625AbWITPzN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 11:55:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751633AbWITPzM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 11:55:12 -0400
Received: from mx1.redhat.com ([66.187.233.31]:13012 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751625AbWITPzK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 11:55:10 -0400
Date: Wed, 20 Sep 2006 11:53:58 -0400
From: "Frank Ch. Eigler" <fche@redhat.com>
To: Mathieu Desnoyers <compudj@krystal.dyndns.org>
Cc: Karim Yaghmour <karim@opersys.com>, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>,
       Douglas Niehaus <niehaus@eecs.ku.edu>, Tom Zanussi <zanussi@us.ibm.com>,
       Paul Mundt <lethal@linux-sh.org>, Jes Sorensen <jes@sgi.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       William Cohen <wcohen@redhat.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       systemtap@sources.redhat.com, ltt-dev@shafik.org
Subject: Re: [PATCH] Linux Kernel Markers 0.2 for Linux 2.6.17
Message-ID: <20060920155358.GH18646@redhat.com>
References: <20060919183447.GA16095@Krystal> <y0m4pv3ek49.fsf@ton.toronto.redhat.com> <20060919193623.GA9459@Krystal> <20060919194515.GB18646@redhat.com> <20060919202802.GB552@Krystal> <20060919210703.GD18646@redhat.com> <45106B20.6020600@opersys.com> <20060920132008.GF18646@redhat.com> <20060920133834.GB17032@Krystal> <20060920145739.GA8502@Krystal>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Rn7IEEq3VEzCw+ji"
Content-Disposition: inline
In-Reply-To: <20060920145739.GA8502@Krystal>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Rn7IEEq3VEzCw+ji
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi -

Mathieu Desnoyers wrote:

> [...]  Do you have ideas on how we can export the function symbol?
> (is it necessary ?)

It turns out that static variables like that get included in the
ordinary symbol tables along with other (un)initialized globals - it
has been making it into /proc/kallsyms.  If the normal symbol table is
not available, then some other measure would be needed to find the
variable containing the function pointer.

> [...]
> #define MARK(name, format, args...) \
>         do { \
>                 __mark_check_format(format, ## args); \
>                 MARK_SYM(name); \
>                 MARK_CALL(name, format, ## args); \
>         } while(0)

While varargs simplify some things, it sacrifices type-safety, in that
a handler function would have to be varargs too.  For the systemtap
marker prototype, parametrized variants use scores of (automatically
generated) macros, with different arity/type permutations, each
self-describing and type-safe.

Regarding a marker variant that would require kprobes (inserting a
labelled NOP or few), it may be an appropriate choice where dormant
marker overhead must be minimal and robust parameter passing is less
important.

- FChE

--Rn7IEEq3VEzCw+ji
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFFEWQWVZbdDOm/ZT0RAvwgAJ9FATR8Ru5NHusHpefefsDZPPTcJgCffRpf
tFPOYEJql5WTc6NywOIm1+4=
=ylZC
-----END PGP SIGNATURE-----

--Rn7IEEq3VEzCw+ji--
