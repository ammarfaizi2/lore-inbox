Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132290AbRCMVt5>; Tue, 13 Mar 2001 16:49:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132176AbRCMVss>; Tue, 13 Mar 2001 16:48:48 -0500
Received: from h24-65-192-120.cg.shawcable.net ([24.65.192.120]:39673 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S132133AbRCMVsZ>; Tue, 13 Mar 2001 16:48:25 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200103132147.f2DLlGb05518@webber.adilger.int>
Subject: Re: ln -l says symlink has size 281474976710666
In-Reply-To: <20010313033526.A633@grulic.org.ar> from John R Lenton at "Mar 13,
 2001 03:35:26 am"
To: John R Lenton <john@grulic.org.ar>
Date: Tue, 13 Mar 2001 14:47:16 -0700 (MST)
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Lenton writes:
> as the subject says:
> 
>   lrwxrwxrwx    1 root     root     281474976710666 Jan 27 20:50 imlib1 -> imlib-base
> 
> it isn't the only one, for example
> 
>   lrwxrwxrwx    1 root     root     281474976710669 Jan 27 14:43 fd -> /proc/self/fd
> 
> i.e. 2**48 + what it should be.

Can you do the following:

ls -i (path)/imlib1; ls -i (path)/fd         # record inode numbers
debugfs /dev/hdX
stat <inode_number>                          # '<' and '>' are required

send output.  This should tell us if the badness is stored on disk or in
memory.  Of course e2fsck would help as well.  Were these newly created
inodes, or existing ones?  If you shutdown and restart, does it go away?
Anything in syslog about ext2 warnings or errors?

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
