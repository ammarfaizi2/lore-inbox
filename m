Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270188AbRHGLSz>; Tue, 7 Aug 2001 07:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270191AbRHGLSp>; Tue, 7 Aug 2001 07:18:45 -0400
Received: from [195.157.147.30] ([195.157.147.30]:12044 "HELO
	pookie.dev.sportingbet.com") by vger.kernel.org with SMTP
	id <S270188AbRHGLSd>; Tue, 7 Aug 2001 07:18:33 -0400
Date: Tue, 7 Aug 2001 12:08:50 +0100
From: Sean Hunter <sean@dev.sportingbet.com>
To: linux-kernel@vger.kernel.org
Subject: CAP_LINUX_IMMUTABLE question
Message-ID: <20010807120850.A18750@dev.sportingbet.com>
Mail-Followup-To: Sean Hunter <sean@dev.sportingbet.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there

I am currently trying to tie down the capability bounding set on one of my
servers.  CAP_SYS_RAWIO and CAP_SYS_MODULE have been a great success (although
dropping CAP_SYS_RAWIO seems to prevent reading /proc/sys/kernel/cap-bound).

I now want to drop CAP_LINUX_IMMUTABLE, and have (I think) done that.  However,
it seems to make no difference to my ability to set or clear the immutable
attribute.  I tried this on ext2 and ext3 filesystems just to be on the safe
side.

[root@henry /boot]# lcap CAP_LINUX_IMMUTABLE
[root@henry /boot]# lsattr ./vmlinux-2.4.2-2smp
---i--------- ./vmlinux-2.4.2-2smp
[root@henry /boot]# chattr -i ./vmlinux-2.4.2-2smp
[root@henry /boot]# lsattr ./vmlinux-2.4.2-2smp
------------- ./vmlinux-2.4.2-2smp
[root@henry /boot]# chattr +i ./vmlinux-2.4.2-2smp
[root@henry /boot]# lsattr ./vmlinux-2.4.2-2smp
---i--------- ./vmlinux-2.4.2-2smp

I thought that giving up CAP_SYS_RAWIO may have forfeited my ability to drop
any further caps, so I rebooted and dropped CAP_SYS_MODULE and
CAP_LINUX_IMMUTABLE first, just to be on the safe side.  This made no visible
difference.

Am I doing anything obviously dumb?

Sean
