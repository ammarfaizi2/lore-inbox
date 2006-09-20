Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932074AbWITRT0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbWITRT0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 13:19:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932075AbWITRT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 13:19:26 -0400
Received: from tomts16-srv.bellnexxia.net ([209.226.175.4]:35049 "EHLO
	tomts16-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S932074AbWITRTZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 13:19:25 -0400
Date: Wed, 20 Sep 2006 13:14:13 -0400
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
Message-ID: <20060920171413.GA18333@Krystal>
References: <y0m4pv3ek49.fsf@ton.toronto.redhat.com> <20060919193623.GA9459@Krystal> <20060919194515.GB18646@redhat.com> <20060919202802.GB552@Krystal> <20060919210703.GD18646@redhat.com> <45106B20.6020600@opersys.com> <20060920132008.GF18646@redhat.com> <20060920133834.GB17032@Krystal> <20060920145739.GA8502@Krystal> <20060920155358.GH18646@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=_Krystal-1300-1158772453-0001-2"
Content-Disposition: inline
In-Reply-To: <20060920155358.GH18646@redhat.com>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 13:12:11 up 28 days, 14:20,  5 users,  load average: 0.41, 0.33, 0.35
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_Krystal-1300-1158772453-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

And here is the sample module to use my jump-marker symbols :

(yes, it works!)

Adresses are taken by hand from /proc/kallsyms for now.

---BEGIN---

/* test-mark.c
 *
 */

#include <linux/marker.h>
#include <linux/module.h>

static void **__mark_subsys_mark1_call =3D (void**)0xf887580c;
static void **__mark_subsys_mark1_jump_over =3D (void**)0xf8875814;
static void **__mark_subsys_mark1_jump_call =3D (void*)0xf8875810;
static void *__this_mark_empty_function =3D (void*)0xf8875000;

static void *saved_over;

void do_mark1(const char *format, int value)
{
	printk("value is %d\n", value);
}

int init_module(void)
{
	*__mark_subsys_mark1_call =3D (void*)do_mark1;
	saved_over =3D *__mark_subsys_mark1_jump_over;
	*__mark_subsys_mark1_jump_over =3D *__mark_subsys_mark1_jump_call;

	return 0;
}

void cleanup_module(void)
{
	*__mark_subsys_mark1_jump_over =3D saved_over;
	*__mark_subsys_mark1_call =3D __this_mark_empty_function;
}

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Mathieu Desnoyers");
MODULE_DESCRIPTION("Marker Test");

---END---




OpenPGP public key:	      http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68=20

--=_Krystal-1300-1158772453-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFEXblPyWo/juummgRAuTSAKCPuQvvkhg9mZ2HHfK80VI89Q+QBACcDj4x
ZrzJCtsbI7aR6JadsnouBDk=
=DNHr
-----END PGP SIGNATURE-----

--=_Krystal-1300-1158772453-0001-2--
