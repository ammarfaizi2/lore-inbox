Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262798AbVA1Wz5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262798AbVA1Wz5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 17:55:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262811AbVA1Wz5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 17:55:57 -0500
Received: from gateway.ottawa.transgaming.com ([209.217.80.34]:45795 "HELO
	ottawa.transgaming.com") by vger.kernel.org with SMTP
	id S262798AbVA1Wzv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 17:55:51 -0500
Subject: PROBLEM: SysV semaphore race vs SIGSTOP
From: Ove Kaaven <ovek@transgaming.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: TransGaming Technologies Inc
Date: Fri, 28 Jan 2005 17:55:50 -0500
Message-Id: <1106952950.15901.47.camel@renegade>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There seem to be a race when SIGSTOP-ing a process waiting for a SysV
semaphore. Even if it could not possibly have owned the semaphore when
the signal was sent (because the sender of the signal owned it at the
time), it still occasionally happens that it both stops execution *and*
acquires the semaphore, with a deadlocked application as the result.
This is a problem for some of the high-performance stuff I'm working on.

A sample test program exhibiting the problem is available at
http://www.ping.uio.no/~ovehk/sembug.c

For me, it will show "ACQUIRE FAILED!! DEADLOCK!!" almost every time I
run it. Occasionally it will run fine; if it does for you, just try
again a couple of times.

The kernel I currently use is:

Linux version 2.4.27-1-k7 (horms@tabatha.lab.ultramonkey.org) (gcc
version 3.3.5 (Debian 1:3.3.5-2)) #1 Wed Dec 1 20:12:01 JST 2004

and I run it on a uniprocessor system (AMD Athlon, 1.9GHz) with Debian
"sid" installed.

I'm not a kernel hacker, but from a quick peruse of the 2.4 code, it
didn't seem to me like the semaphore code in the kernel (ipc/sem.c) even
try to handle suspended threads (though I wouldn't know how to do so).
The 2.6 semaphore code looked almost the same to me, too, so it might be
a problem there as well.

Please Cc me on any questions or comments, since I am too wimpy to
subscribe yet.

