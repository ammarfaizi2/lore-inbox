Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265612AbTBXJDd>; Mon, 24 Feb 2003 04:03:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265687AbTBXJDd>; Mon, 24 Feb 2003 04:03:33 -0500
Received: from krynn.axis.se ([193.13.178.10]:19360 "EHLO krynn.axis.se")
	by vger.kernel.org with ESMTP id <S265612AbTBXJDa>;
	Mon, 24 Feb 2003 04:03:30 -0500
Message-ID: <3C6BEE8B5E1BAC42905A93F13004E8AB017DE83A@mailse01.axis.se>
From: Mikael Starvik <mikael.starvik@axis.com>
To: "'Marc-Christian Petersen'" <m.c.p@wolk-project.de>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Cc: Jonas Holmberg <jonas.holmberg@axis.com>,
       Sebastian Sjoberg <sebastian.sjoberg@axis.com>
Subject: RE: oom killer and its superior braindamage in 2.4
Date: Mon, 24 Feb 2003 10:13:37 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does everyone agree that killing a process is always the best approach
to resolve an OOM? If the OOM is caused by e.g. a growing tmpfs or 
memory leaks in the kernel it won't help much to kill processes that
may respawn. 

Would it be useful if it was possible to register another oom-handler?
Some architectures could then choose to e.g. reboot the system instead.

/Mikael

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Marc-Christian
Petersen
Sent: Saturday, February 22, 2003 8:35 PM
To: linux-kernel@vger.kernel.org
Subject: oom killer and its superior braindamage in 2.4


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


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
