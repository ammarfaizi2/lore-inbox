Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130839AbQLPQkH>; Sat, 16 Dec 2000 11:40:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131633AbQLPQj6>; Sat, 16 Dec 2000 11:39:58 -0500
Received: from netsrvr.ami.com.au ([203.55.31.38]:13106 "EHLO
	netsrvr.ami.com.au") by vger.kernel.org with ESMTP
	id <S130839AbQLPQjm>; Sat, 16 Dec 2000 11:39:42 -0500
Message-Id: <200012160320.eBG3JQZ16646@emu.os2.ami.com.au>
X-Mailer: exmh version 2.1.1 10/15/1999
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: System lockup in 2.4.0-test12; loop dev & ext2 suspect
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 16 Dec 2000 11:19:37 +0800
From: John Summerfield <summer@OS2.ami.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I'm setting up a filesystem for user-mode linux, but uml is not directly 
involved.

I have a script (enhanced version of some supplied with uml) which is best run 
as root.

It creats a 100 Mbyte file (dd from /dev/zero) and makes a filesystem (mke2fs).

It then mounts the filesystem, and proceeds to populate it using rpm to pull 
packages from my CD (scsi cd writer, mounted via autofs); it puts a few 
essential ones first (filesystem, bash, setup and a couple of others) and then 
a great heap at once.

The system has locked up three times at this point; I was wondering about the 
SCSI for a while.

However, the fourth time it locked was during an "rpm --rebuild"

A common feature of each time is that the filesystem on the loop device was 
getting a hammering.

It's characteristic of this lockup that I can ping the box, it does I/O etc. I 
even found that it logged some information connected with my efforts with 
system-request. I could see nothing relevant to the problem.

I tried to ssh into the box from across the LAN; the effort was logged as 
successful.

What I cannot do is run programs. Although the log said ssh was successful, I 
couldn't see that from my terminal. I mostly can't run programs -  I found out 
that the script was stuck in "rpm --rebuilddb" using the ps command; maybe it 
was cached?

In the STAT column, it showd "D" and nothing I could do with the KILL command 
would get id of it.

I've had XFree lock solid (I use GNOME); the last time I created the problem 
from a VC. Well, nearly solid - I was able to get out of it with ctrl-alt-F1 
so I could do things from a VC.

I have on each occasion been able to reboot using the sysrq feature.

Software versions:

[summer@possum summer]$ rpm -q mount e2fsprogs losetup
mount-2.10f-1
e2fsprogs-1.19-0
losetup-2.9u-4
[summer@possum summer]$

I'm running Red Hat Linux 6.2.


-- 
Cheers
John Summerfield
http://www2.ami.com.au/ for OS/2 & linux information.
Configuration, networking, combined IBM ftpsites index.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
