Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751350AbWITNns@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751350AbWITNns (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 09:43:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751352AbWITNns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 09:43:48 -0400
Received: from tomts36.bellnexxia.net ([209.226.175.93]:63413 "EHLO
	tomts36-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1751350AbWITNnr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 09:43:47 -0400
Date: Wed, 20 Sep 2006 09:38:34 -0400
From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
To: "Frank Ch. Eigler" <fche@redhat.com>
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
Message-ID: <20060920133834.GB17032@Krystal>
References: <20060919183447.GA16095@Krystal> <y0m4pv3ek49.fsf@ton.toronto.redhat.com> <20060919193623.GA9459@Krystal> <20060919194515.GB18646@redhat.com> <20060919202802.GB552@Krystal> <20060919210703.GD18646@redhat.com> <45106B20.6020600@opersys.com> <20060920132008.GF18646@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=_Krystal-9116-1158759514-0001-2"
Content-Disposition: inline
In-Reply-To: <20060920132008.GF18646@redhat.com>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 09:33:57 up 28 days, 10:42,  2 users,  load average: 0.15, 0.20, 0.18
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_Krystal-9116-1158759514-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Frank Ch. Eigler (fche@redhat.com) wrote:
> Hi -
>=20
> > > [...]  For the static part of the instrumentation, a
> > > marker that could be hooked up to either type of probing system was
> > > desirable, which implies some sort of run-time changeability.
> >=20
> > Ok. So if I get what you're saying here, you'd like to be able to
> > overload a marker?=20
>=20
> Sort of.  Remember, we discussed markers as *marking* places and
> things, with the intent that they be decoupled from the actual
> *action* that is taken when the marker is hit.
>=20
> > Can you suggest a macro that can do what you'd like. [...]
>=20
> Compare the kind of marker I showed at OLS and presently supported by
> systemtap.  Its unparametrized version looks like this:
>=20
> #define STAP_MARK(name) do { \
>    static void (*__mark_##name##_)(); \
>    if (unlikely (__mark_##name##_)) \
>    (void) (__mark_##name##_()); \
> } while (0)
>=20
> A tracing/probing tool would hook up to a particular and specific
> marker at run time by locating the __mark_NAME static variable (a
> function pointer) in the data segment, for example using the ordinary
> symbol table, and swapping into it the address of a compatible
> back-end handler function.  When a particular tracing/probing session
> ends, the function pointer is reset to null.
>=20
> Note that this technique:
>=20
> - operates at run time
> - is portable
> - in its parametrized variants, is type-safe
> - does not require any future technology
> - does impose some overhead even when a marker is not active
>=20
>=20
Hi Frank,

Yes, I think there is much to gain to switch from the 5 nops "jumpprobe" to
this scheme. In its parametrized variant, the jump will probably jump over a
stack setup and function call. Do you think I should simply switch from the
5 nops marker to this technique ? I guess the performance impact of a
predicted branch will be similar to 5 nops anyway...

The clear advantage I see in the parametrized variant is that the parameters
will be ready for the called function : it makes it trivial to access any
variable from the traced function.

Mathieu


OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj=
=2Egpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68=20

--=_Krystal-9116-1158759514-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFEURaPyWo/juummgRAoxiAJ4mv6Rg7p3PWj2ut6WpMEHOd8Ym8wCfZ18Y
9h0xeyROhRFowmjV4Saq70o=
=1C8v
-----END PGP SIGNATURE-----

--=_Krystal-9116-1158759514-0001-2--
