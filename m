Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131830AbRDABV3>; Sat, 31 Mar 2001 20:21:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131832AbRDABVT>; Sat, 31 Mar 2001 20:21:19 -0500
Received: from mailout05.sul.t-online.com ([194.25.134.82]:17167 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S131830AbRDABVD> convert rfc822-to-8bit; Sat, 31 Mar 2001 20:21:03 -0500
Message-ID: <3AC68228.E9D8161B@baldauf.org>
Date: Sun, 01 Apr 2001 03:19:37 +0200
From: Xuan Baldauf <xuan--lkml@baldauf.org>
X-Mailer: Mozilla 4.76 [en] (Win98; U)
X-Accept-Language: de-DE,en
MIME-Version: 1.0
To: Urban Widmark <urban@teststation.com>
CC: linux-kernel@vger.kernel.org
Subject: [BUG] smbfs: caching problems
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

there is something wrong with smbfs caching which makes my
applications fail. The behaviour happens with
linux-2.4.3-pre4 and linux-2.4.3-final.

Consider following shell script: (where /mnt/n is a
smbmounted smb share from a Win98SE box)

router|/mnt/n/temp/smbfs> I=0; while test $I -lt 127; do
echo "abc" >>/tmp/test.abc; I=$((I+1)); done # create a 508
bytes file
router|/mnt/n/temp/smbfs> I=0; while test $I -lt 129; do
echo "xyz" >>/tmp/test.xyz; I=$((I+1)); done # create a 516
bytes file
router|/mnt/n/temp/smbfs> while true; do cp /tmp/test.abc
testfile; tail -1 testfile; cp /tmp/test.xyz testfile; tail
-1 testfile; done # copy the files alternatingly and read
the destination file after it has bean overwritten
abc
abc
abc
abc
abc
abc
abc
abc
abc
abc
abc
abc
abc
abc
abc
abc
abc
abc
abc
abc
abc
[...Ctrl-C...]
router|/mnt/n/temp/smbfs> cd /tmp # the same on reiserfs
router|/tmp> while true; do cp /tmp/test.abc testfile; tail
-1 testfile; cp /tmp/test.xyz testfile; tail -1 testfile;
done # here it works
abc
xyz
abc
xyz
abc
xyz
abc
xyz
abc
xyz
abc
xyz
abc
xyz
abc
xyz
abc
xyz
abc
xyz
abc
xyz
abc
xyz
abc
xyz
abc
[...Ctrl-C...]
router|/tmp> uname -a
Linux router 2.4.3 #5 Fri Mar 30 14:02:24 CEST 2001 i586
unknown
router|/tmp>

Obviously, the smbfs behaviour is wrong. Interstingly, the
change in the filesize of the file overwritten seems to need
to cross a 512-block-boundary in order to show the bug.

Contact me if you need more info.

Xuân.


