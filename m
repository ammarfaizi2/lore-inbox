Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317068AbSFFSRQ>; Thu, 6 Jun 2002 14:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317072AbSFFSRQ>; Thu, 6 Jun 2002 14:17:16 -0400
Received: from avscan1.sentex.ca ([199.212.134.11]:24024 "EHLO
	avscan1.sentex.ca") by vger.kernel.org with ESMTP
	id <S317068AbSFFSRP>; Thu, 6 Jun 2002 14:17:15 -0400
Message-ID: <02aa01c20d86$ae9e8bc0$294b82ce@connecttech.com>
From: "Stuart MacDonald" <stuartm@connecttech.com>
To: <linux-kernel@vger.kernel.org>
Subject: [BUG] dd, floppy, 2.5.18
Date: Thu, 6 Jun 2002 14:19:22 -0400
Organization: Connect Tech Inc.
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# uname -a
Linux moll 2.5.18 #1 SMP Wed May 29 15:18:20 EDT 2002 i686 unknown

[insert floppy]
# dd if=/dev/fd0 of=diskette.image
8+0 records in
8+0 records out
# ls -alF diskette.image
-rw-r--r--    1 root     root         4096 Jun  6 11:49 test

This is obviously wrong. But a second try at it:

# dd if=/dev/fd0 of=diskette.image
2880+0 records in
2880+0 records out
# ls -alF diskette.image
-rw-r--r--    1 root     root      1474560 Jun  6 11:49 test

However:

# tar xvf diskette.image
wget-1.8.1.tar.gz
# cmp wget-1.8.1.tar.gz wget-181.tar.gz
wget-1.8.1.tar.gz wget-181.tar.gz differ: char 7681, line 34

So that's wrong too. This works under RedHat's 2.4.7-10, and has
worked previously in various 2.4 and 2.2 kernels.

I'm willing to help with some testing to figure out the problem; I use
this dd method to make diskette images for customers all the time, and
I will need it fixed for 2.6.x.

Some things I've noticed:
- the 8 records attempt always happens after a new media insertion. To
say it another way, the "good" 2880 attempt only happens on the second
and subsequent attempts on an already inserted floppy.
- I though I'd noticed that this would corrupt the floppy itself, but
have been unable to reproduce. May have been two bad floppies in a row
coincidentally.

..Stu


