Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268260AbUI2IXN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268260AbUI2IXN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 04:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268263AbUI2IXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 04:23:13 -0400
Received: from alephnull.demon.nl ([212.238.201.82]:42423 "EHLO
	xi.wantstofly.org") by vger.kernel.org with ESMTP id S268260AbUI2IXJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 04:23:09 -0400
Date: Wed, 29 Sep 2004 10:23:07 +0200
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: dsaxena@plexity.net, linux-kernel@vger.kernel.org, herbertb@cs.vu.nl
Subject: strange NFS problems (ARM client, x86 server)
Message-ID: <20040929082307.GA19666@xi.wantstofly.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Trond,

I have an NFS server running 2.6.8-1.521smp (Fedora Core 2 kernel) on
an x86 host, and a client running 2.6.9-rc2 on a big-endian ARM on an
embedded card.  I'm using nfsroot because this card has no directly
attached storage.

>From time to time I see strange problems with files suddenly not being
there anymore but then reappearing, etc.  Today I saw this happening:

-/bin/bash-2.05b# ls -al aumix-2.8-8.armv4b.rpm 
-rw-r--r--  1 root root 72854 Sep 28 20:13 aumix-2.8-8.armv4b.rpm
-/bin/bash-2.05b# rpm -Uvh aumix-2.8-8.armv4b.rpm
/etc/security/selinux/file_contexts: No such file or directory
Preparing...                ########################################### [100%]
error: open of aumix-2.8-8.armv4b.rpm failed: No such file or directory
-/bin/bash-2.05b# strace rpm -Uvh aumix-2.8-8.armv4b.rpm
[...]
chdir("/")                              = 0
chroot("/")                             = 0
[...]
write(1, "Preparing...                ", 28Preparing...                ) = 28
[...]
chroot(".")                             = 0
chdir("")                               = -1 ENOENT (No such file or directory)
[...]
open("aumix-2.8-8.armv4b.rpm", O_RDONLY|O_LARGEFILE)     = -1 ENOENT (No such file or directory)
write(2, "error: ", 7error: )                  = 7
write(2, "open of aumix-2.8-8.armv4"..., 48open of aumix-2.8-8.armv4b.rpm failed: No such file or directory
[...]
-/bin/bash-2.05b# cat aumix-2.8-8.armv4b.rpm > /dev/null
-/bin/bash-2.05b# pwd
/usr/src/redhat/RPMS/armv4b
-/bin/bash-2.05b# cd /usr/src/redhat/RPMS/armv4b
-/bin/bash-2.05b# rpm -Uvh aumix-2.8-8.armv4b.rpm
/etc/security/selinux/file_contexts: No such file or directory
Preparing...                ########################################### [100%]
   1:aumix                  ########################################### [100%]
-/bin/bash-2.05b#


I tried rpm a few times in a row before I changed the directory to `pwd`,
but it failed every time, with every time a similar strace.

Also, my overnight native gcc compile bombed out with the following
message.  Normally it manages to build just fine.

gcc.o: No such file or directory
{standard input}: Assembler messages:
{standard input}:46857: FATAL: Can't write gcc.o: Illegal seek
make[2]: *** [gcc.o] Error 1


I guess you need tcpdumps, no?


thanks,
Lennert
