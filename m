Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265768AbUBGViv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 16:38:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265842AbUBGViv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 16:38:51 -0500
Received: from lakemtao02.cox.net ([68.1.17.243]:49064 "EHLO
	lakemtao02.cox.net") by vger.kernel.org with ESMTP id S265768AbUBGViq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 16:38:46 -0500
Message-ID: <40255AE4.6010007@netmentor.com>
Date: Sat, 07 Feb 2004 16:38:44 -0500
From: "-rb (Robert T. Brown)" <rbrown@netmentor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: getcwd() returning -ENOENT???
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings.
I have 2 clients and a server.  On one client, every 24-72 hours
I get into a situation where the shells cd'ed into
my [automounted] home directory report:

gretchen@falcon{11}pwd
pwd: cannot get current directory: No such file or directory

On the other client, it happens approximately once every 3 weeks.

(These are the same symptoms as described in 12/2000, here):
http://www.ussg.iu.edu/hypermail/linux/kernel/0012.0/0821.html
There did not appear to be any resolution, and my searches turned
up no similar problems since then.


Like the original poster, a "vdir /proc/self/." indicates:
lrwxrwxrwx    1 gretchen gretchen        0 Feb  7 15:25 cwd -> /net/home/gretchen\ (deleted)

While a "vdir" returns the full contents of /net/home/gretchen.

Also, "mount" shows the filesystem mounted via NFS:
gretchen@falcon{17}/bin/mount
/dev/hda2 on / type ext3 (rw)
     (snip)
automount(pid4490) on /net type autofs (rw,fd=5,pgrp=4490,minproto=2,maxproto=3)
ds:/u4/public/home on /net/home type nfs (rw,soft,intr,addr=192.168.3.5)

Note that /net/home is the mount point.  Originally, I suspected a problem
with the mount itself, or even the NFS server.  But, then I discovered,
interestingly enough, another shell which is cd'ed into /net/home/rbrown
actually *works* still!

The original poster indicated he rebooted to "fix" it.  Sure that
works, but I have also noticed that merely typing "cd" works too.

gretchen@falcon{23}pwd
pwd: cannot get current directory: No such file or directory
Exit 1
gretchen@falcon{24}echo $cwd
/home/gretchen
gretchen@falcon{25}cd $cwd
gretchen@falcon{26}pwd
/net/home/gretchen


(The shell is tcsh, not bash; I'm sure that's not relevant).
The client machines are running 2.4.20-8 (yea, this is the Redhat 9.0 kernel).
The server machine is running 2.4.20 (which I built).

Once every day or two, the client machine's syslog shows messages like:
Feb  4 23:16:52 falcon ntpd[4550]: synchronisation lost
Feb  5 11:04:28 falcon kernel: nfs: server ds not responding, timed out
("ds" is the nfs server and the ntp server).

The server machine's syslog shows no errors (just normal informative
messages for each NFS mount and umount request).

I've had the server and clients for years without problems.  Recent changes
include: upgraded clients to redhat 9.0, upgraded server kernel to 2.4.20,
and implemented software raid-1 on the server side's /u4 directory (the
partition which the client mounts as /net/home).

I see from the Changelog's that there are some NFS-related fixes between
2.4.20 and 2.4.24.  Not being a kernel hacker, I can't tell if any of the
fixes would address this problem.  Should I upgrade the client, the server,
or do I have to do both?

I would appreciate a CC: to my email address on any reply.
Thank you for your time.

		-rb
