Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262138AbUH0Kzv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262138AbUH0Kzv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 06:55:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262932AbUH0Kzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 06:55:50 -0400
Received: from forte.mfa.kfki.hu ([148.6.72.11]:32660 "EHLO forte.mfa.kfki.hu")
	by vger.kernel.org with ESMTP id S261184AbUH0Kzq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 06:55:46 -0400
Date: Fri, 27 Aug 2004 12:55:43 +0200
From: Gergely Tamas <dice@mfa.kfki.hu>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: data loss in 2.6.9-rc1-mm1
Message-ID: <20040827105543.GA10563@mfa.kfki.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I've hit the following data loss problem under 2.6.9-rc1-mm1.

If I copy data from a file to another the target will be smaller then
the source file.

2.6.9-rc1 does not have this problem
2.6.8.1-mm4 does not have this problem
2.6.9-rc1-mm1 _does have_ this problem

I tried this with reiserfs and xfs and it happened with both of them.

See the testcase at the bottom of this mail.

Thanks in advance,
Gergely

--------------------------------------------------

$ uname -r
2.6.9-rc1

$ dd if=/dev/zero of=testfile bs=$((1024*1024)) count=10
10+0 records in
10+0 records out
10485760 bytes transferred in 0.028646 seconds (366045254 bytes/sec)

$ du -sb testfile
10485760        testfile

$ cat testfile > testfile.1

$ du -sb testfile.1
10485760        testfile.1

--------------------------------------------------

$ uname -r
2.6.8.1-mm4

$ dd if=/dev/zero of=testfile bs=$((1024*1024)) count=10
10+0 records in
10+0 records out
10485760 bytes transferred in 0.028632 seconds (366226397 bytes/sec)

$ du -sb testfile
10485760        testfile

$ cat testfile > testfile.1

$ du -sb testfile.1
10485760        testfile.1

--------------------------------------------------

$ uname -r
2.6.9-rc1-mm1

$ dd if=/dev/zero of=testfile bs=$((1024*1024)) count=10
10+0 records in
10+0 records out
10485760 bytes transferred in 0.028418 seconds (368981986 bytes/sec)

$ du -sb testfile
10485760        testfile

$ cat testfile > testfile.1

$ du -sb testfile.1
10481664        testfile.1
