Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266297AbTBCNOK>; Mon, 3 Feb 2003 08:14:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266298AbTBCNOK>; Mon, 3 Feb 2003 08:14:10 -0500
Received: from [202.149.212.34] ([202.149.212.34]:7188 "EHLO cmie.com")
	by vger.kernel.org with ESMTP id <S266297AbTBCNOI>;
	Mon, 3 Feb 2003 08:14:08 -0500
Date: Mon, 3 Feb 2003 18:52:14 +0530 (IST)
From: Nohez <nohez@cmie.com>
X-X-Sender: <nohez@venus.cmie.ernet.in>
To: <linux-kernel@vger.kernel.org>
cc: <bgana@cmie.com>
Subject: Re: timer interrupts on HP machines
In-Reply-To: <Pine.LNX.4.33.0301291003220.19934-100000@mars.cmie.ernet.in>
Message-ID: <Pine.LNX.4.33.0302031706090.28669-100000@venus.cmie.ernet.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We have a similar problem with our HP servers. We are facing this problem
for more than a year. We have reported this problem to HP support.

We have five HP Netserver LH6000 running k_smp-2.4.18-47 (SuSE7.1).
We are sure that MP spec is v1.4 in the BIOS.  But we have not
checked /proc/interrupts. Will check the next time this problem occurs.

Problem:
--------

System Time behaved erratically but servers do not hang. We noticed that
all time related apps (sendmail, ping, top, cron etc) stopped. We
noticed that time goes forward & backward in seconds only.

server: # date
Mon Feb  3 17:38:26 IST 2003
server: # date
Mon Feb  3 17:38:30 IST 2003
server: # date
Mon Feb  3 17:38:20 IST 2003
server: # date
Mon Feb  3 17:38:25 IST 2003
server: # date
Mon Feb  3 17:38:28 IST 2003
server: # date
Mon Feb  3 17:38:21 IST 2003

The above is just an example. We could not find any pattern.

We could not access the server remotely. But we could login from console.
All programs using system time failed - like sendmail, top, cron etc.

We could umount filesystems. But the server had to be forcibly shut (power
reset). After system reboot everything was ok.

We have xntpd daemon running on all our servers.

Four servers are file/print servers (samba/nfs/cups) and one is database
server. The above problem has NEVER occured on the database server.
The only difference between the file-server and database server is:
   1. DB server has a external HP Ultrium & HP DDS4 tape drive
      connected to Adaptec 29160N Ultra160 SCSI adapter.
   2. DB server has a Intel PRO/1000 Network (gigabit ethernet card)

Hardware details :
----------------
HP Netserver LH6000
6 * 550Mhz Xeon CPUs
1GB RAM
Integrated Megaraid Ultra-2 SCSI Raid Controller
BIOS MP spec is v1.4

Software:
---------
SuSE Linux 7.1
kernel 2.4.18 (k_smp-2.4.18-47)
glibc-2.2-7
samba-2.0.10-0
xntp-4.0.99f-6
"Unsynced TSC support" is enabled in default SuSE kernel k_smp-2.4.18-47
Kernel debugging is set


Nohez.

------------------------------------------------------------------------
List:     linux-kernel
Subject:  Re: timer interrupts on HP machines
From:     Matt C <wago () phlinux ! com>
Date:     2003-01-30 17:01:50
[Download message RAW]

Hi Praveen-

We have a few LT6000r servers as well, and have the same problem on all
2.4 kernels -- this happens when your MP spec is set to 1.1 in the BIOS.
Change it to 1.4 and you should be okay.

The other common problem on these guys is the CPU speed misdetect, which
causes the kernel to think your CPU is roughly 2x as fast as it really is.
The solution to that one is to unplug and replug the power cords (even a
power-off doesn't fix it, go figure).

Hope that helps.

-Matt

On Thu, 30 Jan 2003, Praveen Ray wrote:

> We have few HP (LPR NetServers and LT6000) which run 2.4.18  (from RedHat 8.0)
> . The problem is that sometimes the time interrupts stop coming - i.e. the
> (time) counts in /proc/interrupts stop getting incremented! When this
> happens, the date on the system falls behind, 'sleep' calls stop working and
> basically machine becomes unusable.Has anyone else encountered this problem?

> Is it an HP issue?

> Thanks.


