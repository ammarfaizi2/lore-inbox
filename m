Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279689AbRJYGyD>; Thu, 25 Oct 2001 02:54:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279694AbRJYGxx>; Thu, 25 Oct 2001 02:53:53 -0400
Received: from [211.219.11.89] ([211.219.11.89]:45580 "EHLO bgis.dyndns.org")
	by vger.kernel.org with ESMTP id <S279689AbRJYGxe>;
	Thu, 25 Oct 2001 02:53:34 -0400
Date: Thu, 25 Oct 2001 15:52:59 +0900 (KST)
From: User <csoh@bgis.dyndns.org>
To: chaffee@cs.berkeley.edu
cc: linux-kernel@vger.kernel.org
Subject: [PATCH]fs/vfat/namei.c dbcs fix,kernel 2.2.19
Message-ID: <Pine.LNX.4.21.0110251419530.25538-101000@bgis.dyndns.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-606906101-1508793988-1003990016=:25538"
Content-ID: <Pine.LNX.4.21.0110251520590.25564@bgis.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---606906101-1508793988-1003990016=:25538
Content-Type: TEXT/PLAIN; CHARSET=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <Pine.LNX.4.21.0110251520591.25564@bgis.dyndns.org>

0. Which version the attached patch applies to

  2.2.19

1. What this patch supposed to fix

 1-1. Wrong case manipulation in namei.c
  From 2.2.18 namei.c uses toupper(), islower() to make uppercase
  shortname, and since it assumes the character range of 0xe0-0xff as
  lowercase, it broke the DBCS(double byte character set) character.
  This patch tries to acknowledge the codepage charset it currently uses
  and if the charset is one of DBCS charset, it uses (if (c>=3D'a' ||
  c<=3D'z') c =3D c - 32) instead. Non-DBCS charsets are not affected.

 1-2. Spliced doublebyte character shortname
  If filename longer than 8 byte base has doublebyte character in 6th and
  7th place, like

        'a' 'b' 'c' 'XY' 'XY' 'XY' '.' 'b' 'm' 'p'
  (X and Y means first and latter half of double byte character)

  Current implementation makes shortname like

        'A' 'B' 'C' 'XY' 'X' '~' '1' '.' 'B' 'M' 'P'

  which is different from DBCS windows implementation

        'A' 'B' 'C' 'XY' '~' '1' '.' 'B' 'M' 'P'

2. Tests

  Copy entire korean win95,98,Me fresh-installed partition to samba share
  to make original file set and make other computer that has both ext2
  linux partition and vfat partition. Boot this computer in linux, mount
  vfat partition and nfs partition (for original filesets) and copy these
  to vfat partition. Finally reboot to windows and run dir, scandisk,
  etc..

  without patch, scandisk complains at several spots and dir shows like
  this.

dir c:\windows\*.bmp

=B9=B0=B9=C6=BF=CF   BMP           190  96-10-30   1:00 =B9=B0=B9=E6=BF=EF.=
bmp
(notice the difference in shortname and longname)
WIN95_1  BMP           240  96-10-30   1:00 WIN95_1.bmp
(correct name of this file is WIN95 =BC=B3=C4=A1 =C8=AD=B8=E9.bmp)

  with patch applied scandisk doesn't complain anymore.

3. Feedback

  I welcome feedback from anyone interested, especially those from other
  DBCS country. If you have comments, feedback please mail me.

---606906101-1508793988-1003990016=:25538
Content-Type: APPLICATION/OCTET-STREAM; NAME="vfat-namei-dbcs-patch.tar.gz"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.21.0110251506560.25538@bgis.dyndns.org>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="vfat-namei-dbcs-patch.tar.gz"

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
+D+qFb9LACgAAA==
---606906101-1508793988-1003990016=:25538--
