Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750750AbWC1HPj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750750AbWC1HPj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 02:15:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751114AbWC1HPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 02:15:39 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:26603 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1750750AbWC1HPi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 02:15:38 -0500
Subject: Re: [Ext2-devel] [PATCH 2/2] ext2/3: Support2^32-1blocks(e2fsprogs)
From: Laurent Vivier <Laurent.Vivier@bull.net>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: Andrew Morton <akpm@osdl.org>, Mingming Cao <cmm@us.ibm.com>,
       Takashi Sato <sho@tnes.nec.co.jp>,
       Badari Pulavarty <pbadari@us.ibm.com>, linux-kernel@vger.kernel.org,
       ext2-devel <ext2-devel@lists.sourceforge.net>
In-Reply-To: <20060327225847.GC3756@localhost.localdomain>
References: <20060325223358sho@rifu.tnes.nec.co.jp>
	 <1143485147.3970.23.camel@dyn9047017067.beaverton.ibm.com>
	 <20060327131049.2c6a5413.akpm@osdl.org>
	 <20060327225847.GC3756@localhost.localdomain>
Message-Id: <1143530126.11560.6.camel@openx2.frec.bull.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-14) 
Date: Tue, 28 Mar 2006 09:15:26 +0200
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 28/03/2006 09:17:38,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 28/03/2006 09:17:41,
	Serialize complete at 28/03/2006 09:17:41
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-rDAl80msYwzGb80xExnD"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-rDAl80msYwzGb80xExnD
Content-Type: multipart/mixed; boundary="=-32eS7SKTfeFb7t8eZRrB"


--=-32eS7SKTfeFb7t8eZRrB
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Le mar 28/03/2006 =C3=A0 00:58, Ravikiran G Thirumalai a =C3=A9crit :
> On Mon, Mar 27, 2006 at 01:10:49PM -0800, Andrew Morton wrote:
> > Mingming Cao <cmm@us.ibm.com> wrote:
> > >
> > > I am wondering if we have (or plan to have) "long long " type of perc=
pu
> > >  counters?  Andrew, Kiran, do you know? =20
> > >=20
> > >  It seems right now the percpu counters are used mostly by ext2/3 for
> > >  filesystem free blocks accounting. Right now the counter is "long" t=
ype,
> > >  which is not enough if we want to extend the filesystem limit from 2=
**31
> > >  to 2**32 on 32 bit machine.
> > >=20
> > >  The patch from Takashi copies the whole percpu_count.h  and create a=
 new
> > >  percpu_llcounter.h to support longlong type percpu counters. I am
> > >  wondering is there any better way for this?
> > >=20
> >=20
> > I can't immediately think of anything smarter.
> >=20
> > One could of course implement a 64-bit percpu counter by simply
> > concatenating two 32-bit counters.  That would be a little less efficie=
nt,
> > but would introduce less source code and would mean that we don't need =
to
> > keep two different implemetations in sync.  But one would need to do a =
bit
> > of implementation, see how bad it looks.
>=20
> Since long long is 64 bits on both 32bit and 64 bit arches, we can just
> change percpu_counter type to long long (or s64) and just have one
> implementation of percpu_counter? =20
> But reads and writes on 64 bit counters may not be atomic on all 32 bit a=
rches.
> So the implementation might have to be reviewed for that.

As 64bit per cpu counter is used only by ext3 and needed only on 64bit
architecture and when CONFIG_LBD is set, perhaps we can have only one
implementation, 32bit in the case of 32bit arch and 64bit in the case of
64bit arch + LBD, as I did in my 64bit patches for ext3 ?

Cheers,
Laurent
--=20
Laurent Vivier
Bull, Architect of an Open World (TM)
http://www.bullopensource.org/ext4

--=-32eS7SKTfeFb7t8eZRrB
Content-Disposition: attachment; filename=percpu.patch
Content-Type: text/x-patch; name=percpu.patch; charset=UTF-8
Content-Transfer-Encoding: base64

SW5kZXg6IGxpbnV4LTIuNi4xNi1sdi9pbmNsdWRlL2xpbnV4L3BlcmNwdV9jb3VudGVyLmgNCj09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT0NCi0tLSBsaW51eC0yLjYuMTYtbHYub3JpZy9pbmNsdWRlL2xpbnV4L3BlcmNwdV9j
b3VudGVyLmgJMjAwNi0wMy0yNyAxNTo0NzowMy4wMDAwMDAwMDAgKzAyMDANCisrKyBsaW51eC0y
LjYuMTYtbHYvaW5jbHVkZS9saW51eC9wZXJjcHVfY291bnRlci5oCTIwMDYtMDMtMjcgMTU6NDc6
MTQuMDAwMDAwMDAwICswMjAwDQpAQCAtMTYsOCArMTYsMTMgQEANCiANCiBzdHJ1Y3QgcGVyY3B1
X2NvdW50ZXIgew0KIAlzcGlubG9ja190IGxvY2s7DQorI2lmZGVmIENPTkZJR19MQkQNCisJbG9u
ZyBsb25nIGNvdW50Ow0KKwlsb25nIGxvbmcgKmNvdW50ZXJzOw0KKyNlbHNlDQogCWxvbmcgY291
bnQ7DQogCWxvbmcgKmNvdW50ZXJzOw0KKyNlbmRpZg0KIH07DQogDQogI2lmIE5SX0NQVVMgPj0g
MTYNCkBAIC0zMCw3ICszNSwxMSBAQCBzdGF0aWMgaW5saW5lIHZvaWQgcGVyY3B1X2NvdW50ZXJf
aW5pdChzDQogew0KIAlzcGluX2xvY2tfaW5pdCgmZmJjLT5sb2NrKTsNCiAJZmJjLT5jb3VudCA9
IDA7DQorI2lmZGVmIENPTkZJR19MQkQNCisJZmJjLT5jb3VudGVycyA9IGFsbG9jX3BlcmNwdShs
b25nIGxvbmcpOw0KKyNlbHNlDQogCWZiYy0+Y291bnRlcnMgPSBhbGxvY19wZXJjcHUobG9uZyk7
DQorI2VuZGlmDQogfQ0KIA0KIHN0YXRpYyBpbmxpbmUgdm9pZCBwZXJjcHVfY291bnRlcl9kZXN0
cm95KHN0cnVjdCBwZXJjcHVfY291bnRlciAqZmJjKQ0KQEAgLTM4LDEwICs0NywxNyBAQCBzdGF0
aWMgaW5saW5lIHZvaWQgcGVyY3B1X2NvdW50ZXJfZGVzdHJvDQogCWZyZWVfcGVyY3B1KGZiYy0+
Y291bnRlcnMpOw0KIH0NCiANCisjaWZkZWYgQ09ORklHX0xCRA0KK3ZvaWQgcGVyY3B1X2NvdW50
ZXJfbW9kKHN0cnVjdCBwZXJjcHVfY291bnRlciAqZmJjLCBsb25nIGxvbmcgYW1vdW50KTsNCits
b25nIGxvbmcgcGVyY3B1X2NvdW50ZXJfc3VtKHN0cnVjdCBwZXJjcHVfY291bnRlciAqZmJjKTsN
CisNCitzdGF0aWMgaW5saW5lIGxvbmcgbG9uZyBwZXJjcHVfY291bnRlcl9yZWFkKHN0cnVjdCBw
ZXJjcHVfY291bnRlciAqZmJjKQ0KKyNlbHNlDQogdm9pZCBwZXJjcHVfY291bnRlcl9tb2Qoc3Ry
dWN0IHBlcmNwdV9jb3VudGVyICpmYmMsIGxvbmcgYW1vdW50KTsNCiBsb25nIHBlcmNwdV9jb3Vu
dGVyX3N1bShzdHJ1Y3QgcGVyY3B1X2NvdW50ZXIgKmZiYyk7DQogDQogc3RhdGljIGlubGluZSBs
b25nIHBlcmNwdV9jb3VudGVyX3JlYWQoc3RydWN0IHBlcmNwdV9jb3VudGVyICpmYmMpDQorI2Vu
ZGlmDQogew0KIAlyZXR1cm4gZmJjLT5jb3VudDsNCiB9DQpAQCAtNTAsOSArNjYsMTUgQEAgc3Rh
dGljIGlubGluZSBsb25nIHBlcmNwdV9jb3VudGVyX3JlYWQocw0KICAqIEl0IGlzIHBvc3NpYmxl
IGZvciB0aGUgcGVyY3B1X2NvdW50ZXJfcmVhZCgpIHRvIHJldHVybiBhIHNtYWxsIG5lZ2F0aXZl
DQogICogbnVtYmVyIGZvciBzb21lIGNvdW50ZXIgd2hpY2ggc2hvdWxkIG5ldmVyIGJlIG5lZ2F0
aXZlLg0KICAqLw0KKyNpZmRlZiBDT05GSUdfTEJEDQorc3RhdGljIGlubGluZSBsb25nIGxvbmcg
cGVyY3B1X2NvdW50ZXJfcmVhZF9wb3NpdGl2ZShzdHJ1Y3QgcGVyY3B1X2NvdW50ZXIgKmZiYykN
Cit7DQorCWxvbmcgbG9uZyByZXQgPSBmYmMtPmNvdW50Ow0KKyNlbHNlDQogc3RhdGljIGlubGlu
ZSBsb25nIHBlcmNwdV9jb3VudGVyX3JlYWRfcG9zaXRpdmUoc3RydWN0IHBlcmNwdV9jb3VudGVy
ICpmYmMpDQogew0KIAlsb25nIHJldCA9IGZiYy0+Y291bnQ7DQorI2VuZGlmDQogDQogCWJhcnJp
ZXIoKTsJCS8qIFByZXZlbnQgcmVsb2FkcyBvZiBmYmMtPmNvdW50ICovDQogCWlmIChyZXQgPiAw
KQ0KQEAgLTYzLDcgKzg1LDExIEBAIHN0YXRpYyBpbmxpbmUgbG9uZyBwZXJjcHVfY291bnRlcl9y
ZWFkX3ANCiAjZWxzZQ0KIA0KIHN0cnVjdCBwZXJjcHVfY291bnRlciB7DQorI2lmZGVmIENPTkZJ
R19MQkQNCisJbG9uZyBsb25nIGNvdW50Ow0KKyNlbHNlDQogCWxvbmcgY291bnQ7DQorI2VuZGlm
DQogfTsNCiANCiBzdGF0aWMgaW5saW5lIHZvaWQgcGVyY3B1X2NvdW50ZXJfaW5pdChzdHJ1Y3Qg
cGVyY3B1X2NvdW50ZXIgKmZiYykNCkBAIC03NiwyNCArMTAyLDQwIEBAIHN0YXRpYyBpbmxpbmUg
dm9pZCBwZXJjcHVfY291bnRlcl9kZXN0cm8NCiB9DQogDQogc3RhdGljIGlubGluZSB2b2lkDQor
I2lmZGVmIENPTkZJR19MQkQNCitwZXJjcHVfY291bnRlcl9tb2Qoc3RydWN0IHBlcmNwdV9jb3Vu
dGVyICpmYmMsIGxvbmcgbG9uZyBhbW91bnQpDQorI2Vsc2UNCiBwZXJjcHVfY291bnRlcl9tb2Qo
c3RydWN0IHBlcmNwdV9jb3VudGVyICpmYmMsIGxvbmcgYW1vdW50KQ0KKyNlbmRpZg0KIHsNCiAJ
cHJlZW1wdF9kaXNhYmxlKCk7DQogCWZiYy0+Y291bnQgKz0gYW1vdW50Ow0KIAlwcmVlbXB0X2Vu
YWJsZSgpOw0KIH0NCiANCisjaWZkZWYgQ09ORklHX0xCRA0KK3N0YXRpYyBpbmxpbmUgbG9uZyBs
b25nIHBlcmNwdV9jb3VudGVyX3JlYWQoc3RydWN0IHBlcmNwdV9jb3VudGVyICpmYmMpDQorI2Vs
c2UNCiBzdGF0aWMgaW5saW5lIGxvbmcgcGVyY3B1X2NvdW50ZXJfcmVhZChzdHJ1Y3QgcGVyY3B1
X2NvdW50ZXIgKmZiYykNCisjZW5kaWYNCiB7DQogCXJldHVybiBmYmMtPmNvdW50Ow0KIH0NCiAN
CisjaWZkZWYgQ09ORklHX0xCRA0KK3N0YXRpYyBpbmxpbmUgbG9uZyBsb25nIHBlcmNwdV9jb3Vu
dGVyX3JlYWRfcG9zaXRpdmUoc3RydWN0IHBlcmNwdV9jb3VudGVyICpmYmMpDQorI2Vsc2UNCiBz
dGF0aWMgaW5saW5lIGxvbmcgcGVyY3B1X2NvdW50ZXJfcmVhZF9wb3NpdGl2ZShzdHJ1Y3QgcGVy
Y3B1X2NvdW50ZXIgKmZiYykNCisjZW5kaWYNCiB7DQogCXJldHVybiBmYmMtPmNvdW50Ow0KIH0N
CiANCisjaWZkZWYgQ09ORklHX0xCRA0KK3N0YXRpYyBpbmxpbmUgbG9uZyBsb25nIHBlcmNwdV9j
b3VudGVyX3N1bShzdHJ1Y3QgcGVyY3B1X2NvdW50ZXIgKmZiYykNCisjZWxzZQ0KIHN0YXRpYyBp
bmxpbmUgbG9uZyBwZXJjcHVfY291bnRlcl9zdW0oc3RydWN0IHBlcmNwdV9jb3VudGVyICpmYmMp
DQorI2VuZGlmDQogew0KIAlyZXR1cm4gcGVyY3B1X2NvdW50ZXJfcmVhZF9wb3NpdGl2ZShmYmMp
Ow0KIH0NCkluZGV4OiBsaW51eC0yLjYuMTYtbHYvbW0vc3dhcC5jDQo9PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQotLS0g
bGludXgtMi42LjE2LWx2Lm9yaWcvbW0vc3dhcC5jCTIwMDYtMDMtMjcgMTU6NDc6MDMuMDAwMDAw
MDAwICswMjAwDQorKysgbGludXgtMi42LjE2LWx2L21tL3N3YXAuYwkyMDA2LTAzLTI3IDE1OjQ3
OjE0LjAwMDAwMDAwMCArMDIwMA0KQEAgLTQ3OSwxMCArNDc5LDE3IEBAIHN0YXRpYyBpbnQgY3B1
X3N3YXBfY2FsbGJhY2soc3RydWN0IG5vdGkNCiAjZW5kaWYgLyogQ09ORklHX1NNUCAqLw0KIA0K
ICNpZmRlZiBDT05GSUdfU01QDQorI2lmZGVmIENPTkZJR19MQkQNCit2b2lkIHBlcmNwdV9jb3Vu
dGVyX21vZChzdHJ1Y3QgcGVyY3B1X2NvdW50ZXIgKmZiYywgbG9uZyBsb25nIGFtb3VudCkNCit7
DQorCWxvbmcgbG9uZyBjb3VudDsNCisJbG9uZyBsb25nICpwY291bnQ7DQorI2Vsc2UNCiB2b2lk
IHBlcmNwdV9jb3VudGVyX21vZChzdHJ1Y3QgcGVyY3B1X2NvdW50ZXIgKmZiYywgbG9uZyBhbW91
bnQpDQogew0KIAlsb25nIGNvdW50Ow0KIAlsb25nICpwY291bnQ7DQorI2VuZGlmDQogCWludCBj
cHUgPSBnZXRfY3B1KCk7DQogDQogCXBjb3VudCA9IHBlcl9jcHVfcHRyKGZiYy0+Y291bnRlcnMs
IGNwdSk7DQpAQCAtNTAzLDE1ICs1MTAsMjYgQEAgRVhQT1JUX1NZTUJPTChwZXJjcHVfY291bnRl
cl9tb2QpOw0KICAqIEFkZCB1cCBhbGwgdGhlIHBlci1jcHUgY291bnRzLCByZXR1cm4gdGhlIHJl
c3VsdC4gIFRoaXMgaXMgYSBtb3JlIGFjY3VyYXRlDQogICogYnV0IG11Y2ggc2xvd2VyIHZlcnNp
b24gb2YgcGVyY3B1X2NvdW50ZXJfcmVhZF9wb3NpdGl2ZSgpDQogICovDQorI2lmZGVmIENPTkZJ
R19MQkQNCitsb25nIGxvbmcgcGVyY3B1X2NvdW50ZXJfc3VtKHN0cnVjdCBwZXJjcHVfY291bnRl
ciAqZmJjKQ0KK3sNCisJbG9uZyBsb25nIHJldDsNCisjZWxzZQ0KIGxvbmcgcGVyY3B1X2NvdW50
ZXJfc3VtKHN0cnVjdCBwZXJjcHVfY291bnRlciAqZmJjKQ0KIHsNCiAJbG9uZyByZXQ7DQorI2Vu
ZGlmDQogCWludCBjcHU7DQogDQogCXNwaW5fbG9jaygmZmJjLT5sb2NrKTsNCiAJcmV0ID0gZmJj
LT5jb3VudDsNCiAJZm9yX2VhY2hfY3B1KGNwdSkgew0KLQkJbG9uZyAqcGNvdW50ID0gcGVyX2Nw
dV9wdHIoZmJjLT5jb3VudGVycywgY3B1KTsNCisjaWZkZWYgQ09ORklHX0xCRA0KKwkJbG9uZyBs
b25nICpwY291bnQ7DQorI2Vsc2UNCisJCWxvbmcgKnBjb3VudDsNCisjZW5kaWYNCisJCXBjb3Vu
dCA9IHBlcl9jcHVfcHRyKGZiYy0+Y291bnRlcnMsIGNwdSk7DQogCQlyZXQgKz0gKnBjb3VudDsN
CiAJfQ0KIAlzcGluX3VubG9jaygmZmJjLT5sb2NrKTsNCn==

--=-32eS7SKTfeFb7t8eZRrB--

--=-rDAl80msYwzGb80xExnD
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e=2E?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.7 (GNU/Linux)

iD8DBQBEKOKO9Kffa9pFVzwRAgs8AKDAv5hTlNnvmjqQHUoOadJqr/4JJwCeM73Y
Mf9czx1Qtx+ptqQRq0/KoEw=
=ynFw
-----END PGP SIGNATURE-----

--=-rDAl80msYwzGb80xExnD--

