Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269950AbRHJQ5B>; Fri, 10 Aug 2001 12:57:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269951AbRHJQ4x>; Fri, 10 Aug 2001 12:56:53 -0400
Received: from mail.parknet.co.jp ([210.134.213.6]:41234 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S269950AbRHJQ4f>; Fri, 10 Aug 2001 12:56:35 -0400
To: Nerijus Baliunas <nerijus@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfat write wrong value into lcase flag
In-Reply-To: <87wv4er2kt.fsf@devron.myhome.or.jp>
	<200108082020.WAA1347968@mail.takas.lt>
	<874rrhf69p.fsf@devron.myhome.or.jp>
	<200108101425.QAA1285141@mail.takas.lt>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: 11 Aug 2001 01:56:26 +0900
In-Reply-To: <200108101425.QAA1285141@mail.takas.lt>
Message-ID: <87vgjvyhtx.fsf_-_@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.0.104
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Nerijus Baliunas <nerijus@users.sourceforge.net> writes:

> I don't know. Sorry, I didn't look at the code, but current (2.4.7) kernel still shows
> filenames as I wrote in 1999. I am talking about filenames _without_ long entries.
> Didn't test what current kernel writes, though.
> I'm attaching floppy image, ungzip and loop mount it.

Thanks for sending floppy image.

This floppy image contains following directory entry:
(this floppy image forgot testing extension name)

  name                   attribute                         used direntry
-----------------------------------------------------------------------------
LINUP    LONG_FILENAME, CASE_LOWER_BASE | CASE_LOWER_EXT         2
LINLOW                , CASE_LOWER_BASE | CASE_LOWER_EXT         1
DOSUP                 ,                                          1
DOSLOW                ,                                          1
98UP                  ,                                          1
98low    LONG_FILENAME,                                          2
W2KUP                 ,                                          1
W2KLOW                , CASE_LOWER_BASE                          1
NTUP                  ,                                          1
NTLOW                 , CASE_LOWER_BASE                          1

linux-2.4.8-pre8:
-----------------------------------------------------------------------------
LINUP                 , CASE_LOWER_BASE | CASE_LOWER_EXT         1
linlow   LONG_FILENAME, CASE_LOWER_BASE | CASE_LOWER_EXT         2

default, convert the shortname to lowercase:
  $ mount -t vfat fdd_vfat /mnt -o loop
  $ ls /mnt
  98low  98up  LINUP  doslow  dosup  linlow  ntlow  ntup  w2klow  w2kup

nocase option, use the win9x rule for display (doesn't support CASE_* flags):
  $ mount -t vfat fdd_vfat /mnt -o loop,nocase
  $ ls /mnt
  98UP  98low  DOSLOW  DOSUP  LINLOW  LINUP  NTLOW  NTUP  W2KLOW  W2KUP

2.4.8-pre8 is useing the win9x rule for create. But attribute must
change to 0.

Now, I writing the lower/win95/winnt/mixed rule on -ac tree.
Please help to test the following patch, if you interests.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

--=-=-=
Content-Type: application/octet-stream
Content-Disposition: attachment;
  filename=vfat_shortname-2.4.7-ac10.diff.gz
Content-Transfer-Encoding: base64

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
--=-=-=--

