Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264875AbUAJQOf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 11:14:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264961AbUAJQOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 11:14:35 -0500
Received: from pcp05127596pcs.sanarb01.mi.comcast.net ([68.42.103.198]:13190
	"EHLO nidelv.trondhjem.org") by vger.kernel.org with ESMTP
	id S264875AbUAJQOd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 11:14:33 -0500
Subject: Re: 2.6.1-mm2: compilation error
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Milan Jurik <M.Jurik@sh.cvut.cz>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0401101644010.1196@bobek.sh.cvut.cz>
References: <Pine.LNX.4.58.0401101644010.1196@bobek.sh.cvut.cz>
Content-Type: multipart/mixed; boundary="=-2y6b2ySb+e6Lzzzjg9TD"
Message-Id: <1073751266.1146.41.camel@nidelv.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 10 Jan 2004 11:14:27 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-2y6b2ySb+e6Lzzzjg9TD
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

P=E5 lau , 10/01/2004 klokka 10:46, skreiv Milan Jurik:
> Hi,
>=20
>     CC      fs/nfs/nfs4proc.o
> fs/nfs/nfs4proc.c: In function `nfs4_lck_type':
> fs/nfs/nfs4proc.c:2042: warning: control reaches end of non-void function
> fs/nfs/nfs4proc.c: In function `nfs4_proc_setlk':
> fs/nfs/nfs4proc.c:2189: unknown field `clientid' specified in initializer
> fs/nfs/nfs4proc.c:2189: warning: missing braces around initializer
> fs/nfs/nfs4proc.c:2189: warning: (near initialization for
> `otl.lock_owner')
> make[3]: *** [fs/nfs/nfs4proc.o] Error 1
> make[2]: *** [fs/nfs] Error 2
> make[1]: *** [fs] Error 2
> make[1]: Leaving directory `/usr/src/linux-2.6.1'
> make: *** [stamp-build] Error 2

No need. I'm surprised I don't see that first warning in my own
compiles.

The second one, however appears to be a compiler bug: AFAICS
concatenating C99 designated intializers in that manner is supported by
the spec (and indeed my version of gcc is quite happy with it). No
matter, though, as we can work around it.

Does the following patch work for you?

Cheers,
  Trond


--=-2y6b2ySb+e6Lzzzjg9TD
Content-Description: 
Content-Disposition: attachment; filename=gnurr.dif
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: base64

LS0tIGxpbnV4LTIuNi4xLW1tMi9mcy9uZnMvbmZzNHByb2MuYy5vcmlnCTIwMDQtMDEtMTAgMTA6
NTY6MTcuMDAwMDAwMDAwIC0wNTAwDQorKysgbGludXgtMi42LjEtbW0yL2ZzL25mcy9uZnM0cHJv
Yy5jCTIwMDQtMDEtMTAgMTE6MTA6MTEuMDAwMDAwMDAwIC0wNTAwDQpAQCAtMjAzOSw2ICsyMDM5
LDcgQEAgbmZzNF9sY2tfdHlwZShpbnQgY21kLCBzdHJ1Y3QgZmlsZV9sb2NrIA0KIAkJCXJldHVy
biBORlM0X1dSSVRFX0xUOyANCiAJfQ0KIAlCVUcoKTsNCisJcmV0dXJuIDA7DQogfQ0KIA0KIHN0
YXRpYyBpbmxpbmUgdWludDY0X3QNCkBAIC0yMTg2LDcgKzIxODcsOSBAQCBuZnM0X3Byb2Nfc2V0
bGsoc3RydWN0IG5mczRfc3RhdGUgKnN0YXRlDQogCWlmIChsc3AgPT0gTlVMTCkgew0KIAkJc3Ry
dWN0IG5mczRfc3RhdGVfb3duZXIgKm93bmVyID0gc3RhdGUtPm93bmVyOw0KIAkJc3RydWN0IG5m
c19vcGVuX3RvX2xvY2sgb3RsID0gew0KLQkJCS5sb2NrX293bmVyLmNsaWVudGlkID0gc2VydmVy
LT5uZnM0X3N0YXRlLT5jbF9jbGllbnRpZCwNCisJCQkubG9ja19vd25lciA9IHsNCisJCQkJLmNs
aWVudGlkID0gc2VydmVyLT5uZnM0X3N0YXRlLT5jbF9jbGllbnRpZCwNCisJCQl9LA0KIAkJfTsN
CiAJCXN0YXR1cyA9IC1FTk9NRU07DQogCQlsc3AgPSBuZnM0X2FsbG9jX2xvY2tfc3RhdGUoc3Rh
dGUsIHJlcXVlc3QtPmZsX293bmVyKTsNCg==

--=-2y6b2ySb+e6Lzzzjg9TD--
