Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269490AbRHCRlo>; Fri, 3 Aug 2001 13:41:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269517AbRHCRl2>; Fri, 3 Aug 2001 13:41:28 -0400
Received: from Huntington-Beach.blue-labs.org ([208.179.59.198]:20819 "EHLO
	Huntington-Beach.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S269490AbRHCRlI>; Fri, 3 Aug 2001 13:41:08 -0400
Message-ID: <3B6AE225.9070702@blue-labs.org>
Date: Fri, 03 Aug 2001 13:40:53 -0400
From: David Ford <david@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2+) Gecko/20010725
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Any known ext2 FS problems in 2.4.7?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm starting to go through a cycle every 2-3 days where I have to bring 
one particular machine down to init l1, kill any processes and remount 
RO, then run e2fsck on the e2fs partition.  Over that period of time, 
disk space is eaten without accouting. 'du' shows about 13 gigs used 
when I sum up all the directories.  Roughly 4.5 gigs is missing.  During 
e2fsck, there are many many pages of deleted inodes with zero dtime, ref 
count fixups, and free inode count fixups.  When I say many, I mean that 
this pIII 667 scrolls for about four minutes...

There is nothing special about this partition, it doesn't do it while 
running 2.4.5-ac15, but I can't use that kernel either because it OOPSes 
as I reported.  That OOPS was fixed for 2.4.7, but this disk space issue 
is rather frustrating.  Fortunately all my other systems are reiserfs 
and work fine.

/dev/ide/host0/bus0/target0/lun0/part2 on / type ext2 
(rw,usrquota=/usr/local/admin/system-info/quota-home)

I haven't mucked with any /proc settings other than "16384" 
 >/proc/sys/fs/file-max.  It's also worthy to note that this machine 
also likes to break and spontaneously reboot about once every day.  No 
klog, no console, no nothing, just bewm.  Again 2.4.5 didn't do this.

There is nothing unusual running on this machine, it's very similar to 
several other machines that stay running with much higher loads just fine.

-d



