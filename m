Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262554AbTCRTwj>; Tue, 18 Mar 2003 14:52:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262557AbTCRTwj>; Tue, 18 Mar 2003 14:52:39 -0500
Received: from rumms.uni-mannheim.de ([134.155.50.52]:65432 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id <S262554AbTCRTwh>; Tue, 18 Mar 2003 14:52:37 -0500
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: Linus Torvalds <torvalds@transmeta.com>,
       Brian Gerst <bgerst@didntduck.org>
Subject: Re: [Bug 350] New: i386 context switch very slow compared to 2.4 due to wrmsr (performance)
Date: Tue, 18 Mar 2003 21:03:23 +0100
User-Agent: KMail/1.5
Cc: Kevin Pedretti <ktpedre@sandia.gov>, <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0303181113590.13708-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0303181113590.13708-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_Mu3d+dqmGEEdqwK";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200303182103.24316.schlicht@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_Mu3d+dqmGEEdqwK
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Description: signed data
Content-Disposition: inline

Am Dienstag, 18. M=E4rz 2003 20:21 schrieb Linus Torvalds:
> On Tue, 18 Mar 2003, Brian Gerst wrote:
> > Here's a few more data points:
>
> Ok, this shows the behaviour I was trying to explain:
> > vendor_id       : AuthenticAMD
> > cpu family      : 5
> > model           : 8
> > model name      : AMD-K6(tm) 3D processor
> > stepping        : 12
> > cpu MHz         : 451.037
> > empty overhead=3D105 cycles
> > load overhead=3D-2 cycles
> > I$ load overhead=3D30 cycles
> > I$ load overhead=3D90 cycles
> > I$ store overhead=3D95 cycles
>
> ie loading from the same cacheline shows bad behaviour, most likely due to
> cache line exclusion. Does anybody have an original Pentium to see if I
> remember that one right?

Yes, you are right!
=46or an old Pentium-I with 133MHz (running FreeBSD, so I cannot provide=20
cpuinfo-data :-( ) I get following:

empty overhead=3D73 cycles
load overhead=3D0 cycles
I$ load overhead=3D88 cycles
I$ load overhead=3D96 cycles
I$ store overhead=3D72 cycles

And just to provide data for the AMD K6-III :

vendor_id       : AuthenticAMD
cpu family      : 5
model           : 9
model name      : AMD-K6(tm) 3D+ Processor
stepping        : 1
cpu MHz         : 450.791
cache size      : 256 KB

empty overhead=3D142 cycles
load overhead=3D89 cycles
I$ load overhead=3D95 cycles
I$ load overhead=3D99 cycles
I$ store overhead=3D91 cycles

       Thomas
--Boundary-02=_Mu3d+dqmGEEdqwK
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+d3uMYAiN+WRIZzQRAthOAKDwxj4nHLhiCUjyCz+QsKAuJidmpQCgoHnq
wbFQZLfikzL6W8YiLSDio/g=
=kxea
-----END PGP SIGNATURE-----

--Boundary-02=_Mu3d+dqmGEEdqwK--

