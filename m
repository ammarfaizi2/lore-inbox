Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751241AbWITNVQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbWITNVQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 09:21:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbWITNVQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 09:21:16 -0400
Received: from mx1.redhat.com ([66.187.233.31]:26291 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751241AbWITNVO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 09:21:14 -0400
Date: Wed, 20 Sep 2006 09:20:08 -0400
From: "Frank Ch. Eigler" <fche@redhat.com>
To: Karim Yaghmour <karim@opersys.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>,
       Douglas Niehaus <niehaus@eecs.ku.edu>, Tom Zanussi <zanussi@us.ibm.com>,
       Paul Mundt <lethal@linux-sh.org>, Jes Sorensen <jes@sgi.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       William Cohen <wcohen@redhat.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       systemtap@sources.redhat.com, ltt-dev@shafik.org
Subject: Re: [PATCH] Linux Kernel Markers 0.2 for Linux 2.6.17
Message-ID: <20060920132008.GF18646@redhat.com>
References: <20060919183447.GA16095@Krystal> <y0m4pv3ek49.fsf@ton.toronto.redhat.com> <20060919193623.GA9459@Krystal> <20060919194515.GB18646@redhat.com> <20060919202802.GB552@Krystal> <20060919210703.GD18646@redhat.com> <45106B20.6020600@opersys.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Pgaa2uWPnPrfixyx"
Content-Disposition: inline
In-Reply-To: <45106B20.6020600@opersys.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Pgaa2uWPnPrfixyx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi -

> > [...]  For the static part of the instrumentation, a
> > marker that could be hooked up to either type of probing system was
> > desirable, which implies some sort of run-time changeability.
>=20
> Ok. So if I get what you're saying here, you'd like to be able to
> overload a marker?=20

Sort of.  Remember, we discussed markers as *marking* places and
things, with the intent that they be decoupled from the actual
*action* that is taken when the marker is hit.

> Can you suggest a macro that can do what you'd like. [...]

Compare the kind of marker I showed at OLS and presently supported by
systemtap.  Its unparametrized version looks like this:

#define STAP_MARK(name) do { \
   static void (*__mark_##name##_)(); \
   if (unlikely (__mark_##name##_)) \
   (void) (__mark_##name##_()); \
} while (0)

A tracing/probing tool would hook up to a particular and specific
marker at run time by locating the __mark_NAME static variable (a
function pointer) in the data segment, for example using the ordinary
symbol table, and swapping into it the address of a compatible
back-end handler function.  When a particular tracing/probing session
ends, the function pointer is reset to null.

Note that this technique:

- operates at run time
- is portable
- in its parametrized variants, is type-safe
- does not require any future technology
- does impose some overhead even when a marker is not active


- FChE

--Pgaa2uWPnPrfixyx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFFEUAIVZbdDOm/ZT0RArLyAJ9ruOE2k/y0zeRlhhbNhdPSDi/VfgCfbQwT
Arhx3URz498QyTFNvs47zX4=
=4hPy
-----END PGP SIGNATURE-----

--Pgaa2uWPnPrfixyx--
