Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314551AbSFDP5Z>; Tue, 4 Jun 2002 11:57:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314690AbSFDP5Y>; Tue, 4 Jun 2002 11:57:24 -0400
Received: from mailhub.fokus.gmd.de ([193.174.154.14]:43983 "EHLO
	mailhub.fokus.gmd.de") by vger.kernel.org with ESMTP
	id <S314551AbSFDP5V>; Tue, 4 Jun 2002 11:57:21 -0400
From: Matthias Welk <welk@fokus.gmd.de>
Organization: Fraunhofer Fokus
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: nfs slowdown since 2.5.4
Date: Tue, 4 Jun 2002 17:56:54 +0200
User-Agent: KMail/1.4.5
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200206041253.44446.welk@fokus.gmd.de> <shsg0032pxw.fsf@charged.uio.no>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_HNO/8Fsbgi0wyam"
Message-Id: <200206041756.55696.welk@fokus.gmd.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_HNO/8Fsbgi0wyam
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 04 June 2002 14:23, Trond Myklebust wrote:
> >>>>> " " =3D=3D Matthias Welk <welk@fokus.gmd.de> writes:
>      > Hi, since 2.5.4 I noticed a big slowdown in nfs.  It seems that
>      > this is related to the changes in the nfs-lookup code, because
>      > now most traffic via nfs is for lookup- and getattr-calls as
>      > you can see in the attached tcpdump log.  I'v also attached a
>      > log of nfsstat, which shows this problem too.
>
> Tough... Those extra checks are needed in order to ensure data cache
> correctness on file open().
>
> If you think you don't need them because the files that you are
> reading are known never to change on the server, you can try mounting
> with the 'nocto' mount option.
>

I tried again with the 'nocto' mount option, although I can't be sure that =
the=20
files will not change on the server, but the behaviour didn't change :-(

To get more info about this problem I compared the compile time and the nfs=
=20
traffic between 2.4.18-4 and 2.5.20 on a RedHat 7.3 system.
The sources (mosfet-liquid0.9.5.tar.gz - KDE style) were located on the loc=
al=20
disc and the libraries were linked over nfs.
The results attached to this mail show the big difference !

I hope you can do anything with it.

Greetings, Matthias.
=2D-=20
=2D--------------------------------------------------------------
=46rom: Matthias Welk                   office:  +49-30-3463-7272
      FHG Fokus                       mobile:  +49-179- 1144752
      Kaiserin-Augusta-Allee 31       fax   :  +49-30-3463-8672
      10589 Berlin		      email : welk@fokus.fhg.de
=2D---------------------------------------------------------------


--Boundary-00=_HNO/8Fsbgi0wyam
Content-Type: text/plain;
  charset="iso-8859-1";
  name="build_2.4.18.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="build_2.4.18.txt"

#time to build on a RedHat 7.3 system with 2.4.18-4

real	1m1.301s
user	0m50.920s
sys	0m8.390s

lookup:		2820
getattr:	22
readdir:	96
frag:		66
--Boundary-00=_HNO/8Fsbgi0wyam
Content-Type: text/plain;
  charset="iso-8859-1";
  name="build_2.5.20.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="build_2.5.20.txt"

#time to build on a RedHat 7.3 system with 2.5.20

real    1m48.509s
user    0m51.320s
sys     0m12.790s


lookup:		287582
getattr:	2546
readdir:	1958
frag:		8465
--Boundary-00=_HNO/8Fsbgi0wyam--
