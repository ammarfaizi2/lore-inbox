Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269221AbRHGQue>; Tue, 7 Aug 2001 12:50:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269001AbRHGQuZ>; Tue, 7 Aug 2001 12:50:25 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:39165 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S269234AbRHGQuP>; Tue, 7 Aug 2001 12:50:15 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200108071650.f77Go9Qj015650@webber.adilger.int>
Subject: Re: CAP_LINUX_IMMUTABLE question
In-Reply-To: <20010807120850.A18750@dev.sportingbet.com> "from Sean Hunter at
 Aug 7, 2001 12:08:50 pm"
To: Sean Hunter <sean@dev.sportingbet.com>
Date: Tue, 7 Aug 2001 10:50:09 -0600 (MDT)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Hunter writes:
> I now want to drop CAP_LINUX_IMMUTABLE, and have (I think) done that.
> However, it seems to make no difference to my ability to set or clear
> the immutable attribute.  I tried this on ext2 and ext3 filesystems
> just to be on the safe side.
> 
> [root@henry /boot]# lcap CAP_LINUX_IMMUTABLE
> [root@henry /boot]# lsattr ./vmlinux-2.4.2-2smp
> ---i--------- ./vmlinux-2.4.2-2smp
> [root@henry /boot]# chattr -i ./vmlinux-2.4.2-2smp
> [root@henry /boot]# lsattr ./vmlinux-2.4.2-2smp
> ------------- ./vmlinux-2.4.2-2smp
> [root@henry /boot]# chattr +i ./vmlinux-2.4.2-2smp
> [root@henry /boot]# lsattr ./vmlinux-2.4.2-2smp
> ---i--------- ./vmlinux-2.4.2-2smp

The code that _should_ check this is fs/ext[23]/ioctl.c:EXT[23]_IOC_SETFLAGS,
so you may want to add some debugging there, to see:
1) if you really have dropped CAP_LINUX_IMMUTABLE
2) the logic of the checking is correct

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

