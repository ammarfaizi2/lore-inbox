Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316576AbSGLQii>; Fri, 12 Jul 2002 12:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316659AbSGLQih>; Fri, 12 Jul 2002 12:38:37 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:47347 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S316576AbSGLQig>; Fri, 12 Jul 2002 12:38:36 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Fri, 12 Jul 2002 10:39:28 -0600
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: ext2 'remount' problem
Message-ID: <20020712163928.GH8738@clusterfs.com>
Mail-Followup-To: "Richard B. Johnson" <root@chaos.analogic.com>,
	Linux kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.3.95.1020712085149.271A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.95.1020712085149.271A-100000@chaos.analogic.com>
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 12, 2002  08:53 -0400, Richard B. Johnson wrote:
> If file-systems are mounted upon boot with 'defaults' as options
> 
> like /etc/fstab...
> /dev/sdc1			/alt		ext2	defaults  0   2
> 
> mount -o remount,rw,noatime /alt
> 
> The result is (correctly)
> /dev/sdc1 /alt ext2 rw,noatime 0 0
> 
> Now, if I shut down the system, properly dismounting all the drives,
> then I reboot, the drives that were re-mounted end up being fscked
> due to 'was not cleanly unmounted' inference. Nothing wrong is found.
> 
> Now, if I mount the drives "noatime" from the start, i.e., from
> /etc/fstab upon startup, there are no such errors upon re-boot.

There was once a problem that if you mounted a filesystem and crashed
shortly thereafter the filesystem would mistakenly be marked clean and
not checked when it should be, but I haven't heard the opposite problem.

I did a quick check (just mounting an ext2 filesystem on 2.4.18 from bash,
remounting, then unmounting) and everything worked as expected.  Could
you try doing your test and running "dumpe2fs -h /dev/foo" between each
step to check the filesystem state.  It should be "not clean" until the
filesystem is unmounted, at which point it should be "clean".

Also try doing the unmount steps manually before shutdown to see if it
is a timing issue.  If you have writeback cache enabled on your disks
and this is not being flushed to the oxide before power is lost you may
not just be having an fsck problem, but also a data loss/corruption
problem.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

