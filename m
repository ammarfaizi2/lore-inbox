Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293493AbSCOXPp>; Fri, 15 Mar 2002 18:15:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293489AbSCOXP2>; Fri, 15 Mar 2002 18:15:28 -0500
Received: from web13608.mail.yahoo.com ([216.136.175.119]:34059 "HELO
	web13608.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S293495AbSCOXPT>; Fri, 15 Mar 2002 18:15:19 -0500
Message-ID: <20020315231518.91030.qmail@web13608.mail.yahoo.com>
Date: Fri, 15 Mar 2002 15:15:18 -0800 (PST)
From: Balbir Singh <balbir_soni@yahoo.com>
Subject: readv() return and errno
To: Jim Hollenback <jholly@cup.hp.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-314769703-1016234118=:90843"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-314769703-1016234118=:90843
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

You are right, the latest POSIX spec says

ERRORS
....
The readv() function may fail if:

[EINVAL]
The iovcnt argument was less than or equal to 0, or
greater than {IOV_MAX}

Apply this trivial patch, if you want the required
behaviour (see attached)

Balbir







List:     linux-kernel
Subject:  readv() return and errno
From:     "Jim Hollenback" <jholly@cup.hp.com>
Date:     2002-03-15 21:54:26
[Download message RAW]

In doing some testing on the project I'm working on I 
came across something that is causing a bit of 
confusion on my part.

According to readv(2) EINVAL is returned for an 
invalid  argument.  The examples given were count
might 
be greater than MAX_IOVEC or zero. The test case I am 
working with has count = 0 and I get return of 0 and 
errno 0 instead of the expected -1 and errno EINVAL.

Am I missing something?

Thanks!

Jim Hollenback

__________________________________________________
Do You Yahoo!?
Yahoo! Sports - live college hoops coverage
http://sports.yahoo.com/
--0-314769703-1016234118=:90843
Content-Type: text/plain; name="rw.patch.txt"
Content-Description: rw.patch.txt
Content-Disposition: inline; filename="rw.patch.txt"

--- read_write.c.org	Fri Mar 15 16:10:05 2002
+++ read_write.c	Fri Mar 15 16:10:13 2002
@@ -241,10 +241,9 @@
 	 * First get the "struct iovec" from user memory and
 	 * verify all the pointers
 	 */
-	ret = 0;
+	ret = -EINVAL;
 	if (!count)
 		goto out_nofree;
-	ret = -EINVAL;
 	if (count > UIO_MAXIOV)
 		goto out_nofree;
 	if (!file->f_op)

--0-314769703-1016234118=:90843--
