Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267637AbTBVTbn>; Sat, 22 Feb 2003 14:31:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267610AbTBVTbM>; Sat, 22 Feb 2003 14:31:12 -0500
Received: from mailout06.sul.t-online.com ([194.25.134.19]:7853 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S267553AbTBVTbI> convert rfc822-to-8bit; Sat, 22 Feb 2003 14:31:08 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: linux-kernel@vger.kernel.org
Subject: oom killer and its superior braindamage in 2.4
Date: Sat, 22 Feb 2003 20:35:28 +0100
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200302222025.48129.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I just thought (ok it was yesterday) about stress testing my mysql db.
I used this:
- mystress.pl localhost mysql root test 600 300 60 "select * from user"

It worked like a charme. So I tried:
- mystress.pl localhost mysql root test 1800 900 60 "select * from user"

My machine has 512MB RAM and 512MB SWAP.

I expected that the 2nd run will OOM my machine but I did not expect this 
silly behaviour.

The following log entry appeared only _once_ (there were ~700 mysqld running)

- Feb 21 10:03:22 codeman kernel: Out of Memory: Killed process 1463 (mysqld).


Instead of really killing either mysqld or mystress.pl the OOM killer decided 
to kill apache (apache did nothing but had 5 threads sleeping)

- Feb 21 10:04:57 codeman kernel: Out of Memory: Killed process 2657 (apache).

The above log entry (apache) appeared for about 4 hours every some seconds 
(same PID) until I thought about sysrq-b to get out of this braindead 
behaviour. The machine was somewhat dead for me because I was not able to do 
anything but sysrq. The system itself was _not_ dead, there was massive disk 
i/o. This is 2.4.20 vanilla.

Is there any chance we can fix this up?

ciao, Marc


