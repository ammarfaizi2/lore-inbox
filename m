Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266135AbUBQMhD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 07:37:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266144AbUBQMhD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 07:37:03 -0500
Received: from smtp6.clb.oleane.net ([213.56.31.26]:17593 "EHLO
	smtp6.clb.oleane.net") by vger.kernel.org with ESMTP
	id S266135AbUBQMg4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 07:36:56 -0500
Subject: Re: UTF-8 practically vs. theoretically in the VFS API (was: Re:
From: Nicolas Mailhot <Nicolas.Mailhot@laPoste.net>
To: linux-kernel@vger.kernel.org
Cc: Alex Belits <abelits@phobos.illtel.denver.co.us>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-3jBRGqohoRsJis1iDFJM"
Organization: Adresse personnelle
Message-Id: <1077021379.6605.42.camel@ulysse.olympe.o2t>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.3 (1.5.3-1) 
Date: Tue, 17 Feb 2004 13:36:19 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-3jBRGqohoRsJis1iDFJM
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

|Alex Belit a =C3=A9crit :
|
|On Mon, 16 Feb 2004, Marc Lehmann wrote:
|
|> > I have never claimed that the kernel really talk s UTF-8, and indeed, =
I
|> > would say that such a kernel would be terminally and horribly broken.
|>
|> And I'd say such a kernel would be highly useful, as it would standardiz=
e
|> the encoding of filenames, just as unix standardizes on "mostly ascii"
|> (i.e. the SuS).
|>
|> However, just as POSIX is a nice but very limited base, (mostly) ASCII
|> is a nice and very limited base. UTF-8 would also be a good base.
|
|  UTF-8 is dependent on Unicode, that is cumbersome [...] Enforcing UTF-8
| will burn the bridges to any other language support infrastructure or=20
| encoding, right at the time when such infrastructure is likely to be crea=
ted.

Quite the contrary. The current UTF-8 migration shows the major showstopper=
=20
when changing filename encodings is right know you don't know what damned=20
encoding to convert from.

With a clear policy (for *current* encodings) one can change.

Without one you're reduced to expensive guesswork (ie *humans* have to spen=
d
 *days* checking the conversion worked as expected.)

I happen to hate imperial units. *My* country switched to full metric more =
than
 two hundred years ago. However I'll take a value in imperial units any day=
 over
some number without explicit unit any day.

Implicit unit/encoding is a damn stupid thing to do. There are numerous exa=
mples
 of big expensive projects that failed because of this kind of misunderstan=
ding.=20
Many apps and humans need to interpret filenames to perform their job.

(BTW if anyone cares I was raised next to a computer which primary purpose =
was=20
translating to a non-latin language. So I know quite a lot of the recipes f=
or
"getting by" and having worthless archives after a few years)

|> 8-bit bytes as filenames is not a good base, however, since they enforce
|> a difefrent layer of interrpetation between the user and the kernel, and
|> this interpretation cannot be based on the locale nor the filesystem
|> itself, as there is no way to find out what encoding the filename is in.
|
|  This is a matter of GUI implementation. If someone cared about this, he
|would store language metadata with filename, too, however this is clearly
|contrary to the Unix filesystem design.

If you think filename interpretation is GUI-only stuff you're sadly mistake=
n.
Filename-based processing is widespread.

|> 8-bit bytes is convinient, but not useful for i18n environments. in the
|> past, it was also convinient and nobody cared, since everything was
|> either 8-bit or double-byte, and nobody exchanged files.
|
|  I did, and it worked _fine_. Everyone who is willing to use UTF-8 is
|free to do this right now, and everything will already work great for
|them. Writing software to deliberately enforce UTF-8 is something
|completely different from using UTF-8 for yourself.

|> This, however, is going to change, and the current methodology of "just
|> guess, you might be right" is a hindrance to this.
|
|  This was "going to change" for more than a decade already, or,
|alternatively, already happened if you listen to someone like Martin
|Duerst. The reality is, everything can pass UTF-8 already, yet people use
|other encodings for everything, too, and as long as they don't break,
|things work.

Till a certain point.
Past this point all the heuristics in the world won't help you and people=20
suddenly revise their "work" definition.

| Breaking byte-value transparency in any place in the system
|is counterproductive

There is nothing transparent in the system for filename users.
Generalised guesswork is not transparency.

[...]

|> However, just as with URLs (which are byte-streams, too), byte-streams a=
re
|> useless to store text. You need bytestreams + known encoding.
|
|  MIME has a perfectly usable standard for declaring encodings, and huge
|amounts of text (that may include filenames) are distributed by
|MIME-compliant or MIME-like protocols (mail and HTTP, to name two).=20

Fine. Just convert all your filenames to garbage at see how great it is the=
ir=20
contents are still readable because the file formats have encoding info. I'=
m
pretty sure you'll still miss your nice filenames.

Let me repeat my point :
1. filenames have a meaning
2. the meanings are important
3. they can not be reliably decoded without encoding info

Therefore encoding info needs to be added, using either FS metadata or a cl=
ear standard.
And I don't care if the standard is UTF-8, UCS-foo, egyptian hieroglyphs or=
 whatever.
I want a f* standard. Every single person that had to work on the mess that=
 results now
from many users using different incompatible locales on a single FS want a =
f* standard.

Someone wrote about it being akin to changing read() write() to do encoding=
 conversion=20
on the fly. This is blatantly false - filename contents are userspace-level=
 and an app=20
isn't expected to read other app files. And an app can use formats that dec=
lare file
encoding. But any app *will* need to read files it didn't generate because =
they happen to
reside in the same directory. And it *won't* be able to specify filename en=
coding because
the filename format belongs to the kernel so it's the *kernel* job to provi=
de encoding=20
info somewhere so app authors can interpret it correctly.

Sorry, we won't do it is not a valid answer.

App writers have solved what they could - file contents (which are encoding=
-aware now=20
thanks to xml and friends). What they can not solve without kernel help is =
filename=20
encoding - because filenames are shared unlike files, and it requires a sys=
tem-level=20
decision.

--=20
Nicolas Mailhot

--=-3jBRGqohoRsJis1iDFJM
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAMgrDI2bVKDsp8g0RArLbAJ9XyVMUxsDRXsoCbx+ta2B+9TeWPgCdEu4l
1kBoocUz0ku04oLRb6vjvj0=
=LMIX
-----END PGP SIGNATURE-----

--=-3jBRGqohoRsJis1iDFJM--

