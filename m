Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751695AbWIYXdk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751695AbWIYXdk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 19:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751691AbWIYXdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 19:33:39 -0400
Received: from tomts40-srv.bellnexxia.net ([209.226.175.97]:50881 "EHLO
	tomts40-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1751688AbWIYXdi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 19:33:38 -0400
Date: Mon, 25 Sep 2006 19:28:28 -0400
From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
To: "Frank Ch. Eigler" <fche@redhat.com>
Cc: Martin Bligh <mbligh@google.com>,
       Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, prasanna@in.ibm.com,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       ltt-dev@shafik.org, systemtap@sources.redhat.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jeremy Fitzhardinge <jeremy@goop.org>,
       Karim Yaghmour <karim@opersys.com>, Pavel Machek <pavel@suse.cz>,
       Joe Perches <joe@perches.com>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       "Jose R. Santos" <jrs@us.ibm.com>
Subject: Re: [PATCH] Linux Kernel Markers 0.11 for 2.6.17
Message-ID: <20060925232828.GA29343@Krystal>
References: <20060925151028.GA14695@Krystal> <20060925160115.GE25296@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=_Krystal-13748-1159226909-0001-2"
Content-Disposition: inline
In-Reply-To: <20060925160115.GE25296@redhat.com>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 19:19:12 up 33 days, 20:27,  6 users,  load average: 0.53, 0.24, 0.16
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_Krystal-13748-1159226909-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

* Frank Ch. Eigler (fche@redhat.com) wrote:
> Hi -
>=20
> > [...]
> > - It _does not_ change the compiler optimisations.
>=20
> Like any similar mechanism, it does force the compiler to change its
> code generation, so one can't claim this too strongly.
>=20
Yes, memory dependencies are changed, you are right. I was principally talk=
ing
about the inline and unrolled loops optimisations.


> > [...]  Comments are welcome,
>=20
> I'm still uneasy about the use of varargs.  The current code now uses
> the formatting string as metadata to be matched (strcmp) between
> producer and consumer.  A general tool that would use them would have
> to start parsing general printf directives.

If you want to generate probes automatically, yes.

> I believe they are not
> quite general enough either e.g. to describe a raw binary blob.
>=20
If you want to dump a raw binary blob, what about :
MARK(mysubsys_myevent, "char %p %u", blobptr, blobsize);
where %p is a pointer to an array of char and %u the length ?

My idea is to use the string to identify what is referred by a pointer, so =
it
can be casted into this type with some kind of coherency between the marker=
 and
the probe.

> I realize they serve a useful purpose in abbreviating what otherwise
> one might have to do (like that multiplicity of STAP_MARK_* type/arity
> permutations).  But maybe there is a better way.
>=20

I think that duplicating the number of marker macros could easily make
them unflexible and ugly. This is why I am trying to come with this generic
macro.

> Also, while regparm(0) may provide some comfort on x86, is there good
> reason to believe that the same trick works (and will continue to
> work) on non-x86 platforms to invoke a non-varargs callee with a
> varargs caller?
>=20

Good point, I will setup a va_args in the probe. When correctly used, howev=
er,
there is no need to use the format string : we can directly get the variabl=
es
=66rom the var arg list if we know in advance what the string will be.

Mathieu

OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj=
=2Egpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68=20

--=_Krystal-13748-1159226909-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFGGYcPyWo/juummgRAjaRAJ4gozyOwwBPAZLK8ZPeYZpSmmwPPACgiGzU
4TE7TeG/27neMtFCOy6LTbg=
=Bxty
-----END PGP SIGNATURE-----

--=_Krystal-13748-1159226909-0001-2--
