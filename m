Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274449AbRITMYw>; Thu, 20 Sep 2001 08:24:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274455AbRITMYn>; Thu, 20 Sep 2001 08:24:43 -0400
Received: from res1.hostid.de ([62.146.35.65]:3851 "EHLO res1.hostid.de")
	by vger.kernel.org with ESMTP id <S274449AbRITMYe>;
	Thu, 20 Sep 2001 08:24:34 -0400
Date: Thu, 20 Sep 2001 14:24:57 +0200
From: Richard Mueller <mueller@teamix.net>
X-Mailer: The Bat! (v1.52f) Business
Reply-To: Richard Mueller <mueller@teamix.net>
Organization: Teamix GmbH
X-Priority: 3 (Normal)
Message-ID: <8414177426.20010920142457@teamix.net>
To: linux-kernel@vger.kernel.org
Subject: Strange SGID-Bit behavior with 2.2. and 2.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello almighty kernelgods...

a friend and I discovered some strange diffrence in the beahavior
of the 2.4, 2.2 Kernels.

Following Commands were done on both kernels:
---------------------------------------------
su -
cd /
mkdir test
chmod 2755 test
chown rdd test
su rdd
cd /test
touch a
chgrp users a
chmod 7777 a
cp a b
cp /bin/ls d
chgrp users d
chmod 7777 d
cp d e

These results are on 2.4.6
--------------------------
drwxr-sr-x    2 rdd      root          190 Sep 14 15:17 .
drwxr-xr-x   22 root     root          455 Sep 14 14:59 ..
-rwsrwsrwt    1 rdd      users           0 Sep 14 15:00 a
-rwsr-sr-t    1 rdd      root            0 Sep 14 15:02 b
   -->^<-- What's that?
-rwsrwsrwt    1 rdd      users       46568 Sep 14 15:07 d
-rwxr-xr-t    1 rdd      root        46568 Sep 14 15:08 e


And these on 2.2.16
-------------------
drwxr-sr-x   2 rdd      root          103 Sep 14 15:13 .
drwxr-xr-x  20 root     root          369 Sep 14 15:10 ..
-rwsrwsrwt   1 rdd      users           0 Sep 14 15:12 a
-rwsr-xr-t   1 rdd      root            0 Sep 14 15:12 b
-rwsrwsrwt   1 rdd      users       41552 Sep 14 15:12 d
-rwsr-xr-t   1 rdd      root        41552 Sep 14 15:13 e

It happens both with ext2 and reiserfs.


Can anyone explain this behavior? Would be great.

If this is a damn stupid question, please drop it and kill me. :|


Richard Mueller

