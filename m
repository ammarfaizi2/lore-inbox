Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282200AbRKWSaS>; Fri, 23 Nov 2001 13:30:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282201AbRKWSaH>; Fri, 23 Nov 2001 13:30:07 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:4852 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S282200AbRKWS34>;
	Fri, 23 Nov 2001 13:29:56 -0500
Date: Fri, 23 Nov 2001 11:29:47 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Hartmut Holz <hartmut.holz@arcormail.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Input/output error
Message-ID: <20011123112947.W1308@lynx.no>
Mail-Followup-To: Hartmut Holz <hartmut.holz@arcormail.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0111221415490.1518-100000@grignard.amagerkollegiet.dk> <3BFE6E98.8090109@arcormail.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <3BFE6E98.8090109@arcormail.de>; from hartmut.holz@arcormail.de on Fri, Nov 23, 2001 at 04:43:20PM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 23, 2001  16:43 +0100, Hartmut Holz wrote:
> On my machine (2.4.15 final) it is the same behaviour.  After reboot
> the lock files (and only the lock files) are corrupt. With 2.4.14 and 
> 2.4.13 everything works fine. gcc 2.96, e2fsck 1.25, aic7896/97
> 
> e2fsck output:
> --------------
> Pass 1: Checking inodes, blocks, and sizes
> Pass 2: Checking directory structure
> Entry 'kudzu' in /lock/subsys (30001) has deleted/unused inode 30005. 
> Entry 'network' in /lock/subsys (30001) has deleted/unused inode 30006. 
> Entry 'syslog' in /lock/subsys (30001) has deleted/unused inode 30007. 
> Entry 'portmap' in /lock/subsys (30001) has deleted/unused inode 30008. 
> Entry 'nfslock' in /lock/subsys (30001) has deleted/unused inode 30009. 
> Entry 'syslogd.pid' in /run (38001) has deleted/unused inode 38009. 
> Entry 'klogd.pid' in /run (38001) has deleted/unused inode 38010. 

I take it that this is after a normal shutdown where you are sure that
the filesystem was unmounted cleanly?  It looks like a case where these
files are deleted, but held open by a process.

Could you please try the following:
- "telinit 1" to change into single user mode
- make sure all of the above processes are stopped (check via ps, and
  "/etc/rc.d/init.d/foo stop" for each one
- "lsof | grep /var" to see if any files are still open on /var
- umount /var
- e2fsck -f /dev/hdX

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

