Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136705AbREGXFd>; Mon, 7 May 2001 19:05:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136704AbREGXFX>; Mon, 7 May 2001 19:05:23 -0400
Received: from pobox.sibyte.com ([208.12.96.20]:63749 "HELO pobox.sibyte.com")
	by vger.kernel.org with SMTP id <S136705AbREGXFP>;
	Mon, 7 May 2001 19:05:15 -0400
From: Justin Carlson <carlson@sibyte.com>
Reply-To: carlson@sibyte.com
Organization: Sibyte
To: linux-kernel@vger.kernel.org
Subject: SMP bug revealed by networking?
Date: Mon, 7 May 2001 15:54:14 -0700
X-Mailer: KMail [version 1.0.29]
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Message-Id: <0105071604481H.00781@plugh.sibyte.com>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm working on a new SMP mips port, and tripped over a strange
bug.  Am not quite sure how to attack it.

I'm running 2.4.2 from oss.sgi.com's cvs repositry, booting with
the root filesystem being over NFS with two cores active in
the system.  The port is actually fairly stable at the moment, but
just once, while trying to exec init during a boot, it locked up.

Since I'm running in simulation (fun consequence of not porting to something
for which silicon doesn't yet exist), I took a peek and
saw this:

CPU0 was in ip_defrag() trying to aquire the ipq spinlock
CPU1 was idle.

ip_defrag() being an exceedingly unlikely source of bugs at this moment,
especially in terms of that simple locking, I'm thinking I must have a bug
in the SMP handling; however, I don't see any likely candidates there either.
I can't reproduce this bug, either; it seems to have been dependent on
timing from the network.

Has anyone run into anything remotely like this before?  Any suggestions
on where to look for bug or how to make this reproducable in order to track it
down?

Thanks,
  Justin
