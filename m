Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264254AbUAGXnJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 18:43:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264289AbUAGXnJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 18:43:09 -0500
Received: from twin.jikos.cz ([213.151.79.26]:12203 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id S264254AbUAGXmh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 18:42:37 -0500
Date: Thu, 8 Jan 2004 00:42:01 +0100 (CET)
From: Jirka Kosina <jikos@jikos.cz>
To: Eric Sandeen <sandeen@sgi.com>
cc: LKML <linux-kernel@vger.kernel.org>, linux-xfs@oss.sgi.com
Subject: Re: XFS over 7.7TB LVM partition through NFS
In-Reply-To: <1073501867.23356.5.camel@stout.americas.sgi.com>
Message-ID: <Pine.LNX.4.58.0401080009500.18348@twin.jikos.cz>
References: <Pine.LNX.4.58.0401071824120.31032@twin.jikos.cz>
 <1073501867.23356.5.camel@stout.americas.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On Wed, 7 Jan 2004, Eric Sandeen wrote:

> Just to get this out of the way, I assume CONFIG_LBD is turned on?
> I think so, otherwise it should not mount.

CONFIG_LBD is of course turned on - otherwise it won't be even possible to 
create such large LVM partition.

> Also, is below an oops, or an xfs corruption message, or...?  What came
> before the call trace.

This is really all I have in log (and syslog is logging kern.*). Here you
can see a few previous lines: (so from my point of view this seems like
XFS internal error, but I must admit that I am not familiar with XFS code
and design at all)

Jan  8 00:39:25 storage2 kernel: eth0: driver changed get_stats after 
register
Jan  8 00:39:25 storage2 kernel: eth0: link now 1000 mbps, full duplex and 
up.
Jan  8 00:39:25 storage2 kernel: XFS mounting filesystem dm-0
Jan  8 00:39:25 storage2 kernel: Ending clean XFS mount for filesystem: dm-0
Jan  8 01:38:35 storage2 kernel: 0x0: 94 38 73 54 cc 8c c9 be 0c 3e 6b 30 4c 9f 54 c5
Jan  8 01:38:35 storage2 kernel: Filesystem "dm-0": XFS internal error 
xfs_alloc_r ead_agf at line 2208 of file fs/xfs/xfs_alloc.c.  Caller 0xc01fab06
Jan  8 01:38:35 storage2 kernel: Call Trace:
Jan  8 01:38:35 storage2 kernel:  [xfs_alloc_read_agf+321/582] xfs_alloc_read_agf+0x141/0x246

> You could run xfs_repair over the fs to see what it finds.

storage2:~# xfs_repair /dev/mapper/lvol1-lv1
Phase 1 - find and verify superblock...
Phase 2 - using internal log
        - zero log...
        - scan filesystem freespace and inode maps...
bad on-disk superblock 6 - bad magic number
primary/secondary superblock 6 conflict - AG superblock geometry info 
conflicts with filesystem geometry
bad magic # 0x94387354 for agf 6
bad version # -863188546 for agf 6
bad sequence # 205417264 for agf 6
bad length 1285510341 for agf 6, should be 60176384
flfirst -573275643 in agf 6 too large (max = 128)
fllast 1287837829 in agf 6 too large (max = 128)
bad magic # 0x43758d0d for agi 6
bad version # -985298009 for agi 6
bad sequence # -810919876 for agi 6
bad length # 1866908477 for agi 6, should be 60176384
reset bad sb for ag 6
reset bad agf for ag 6
reset bad agi for ag 6
bad agbno 2423917045 in agfl, agno 6
freeblk count 1 != flcount 1928110601 in ag 6
bad agbno 2083432091 for btbno root, agno 6
bad agbno 2649075945 for btbcnt root, agno 6
bad agbno 2607557273 for inobt root, agno 6
bad on-disk superblock 7 - bad magic number
primary/secondary superblock 7 conflict - AG superblock geometry info 
conflicts with filesystem geometry
bad magic # 0x0 for agf 7
bad version # 0 for agf 7
bad sequence # 0 for agf 7
bad length 0 for agf 7, should be 60176384
bad magic # 0x0 for agi 7
bad version # 0 for agi 7
bad sequence # 0 for agi 7
bad length # 0 for agi 7, should be 60176384
reset bad sb for ag 7
reset bad agf for ag 7
reset bad agi for ag 7
bad agbno 0 for btbno root, agno 7
bad agbno 0 for btbcnt root, agno 7
bad agbno 0 for inobt root, agno 7
bad on-disk superblock 8 - bad magic number
primary/secondary superblock 8 conflict - AG superblock geometry info 
conflicts with filesystem geometry
bad magic # 0x0 for agf 8
bad version # 0 for agf 8
bad sequence # 0 for agf 8
bad length 0 for agf 8, should be 60176384
bad magic # 0x0 for agi 8
bad version # 0 for agi 8
bad sequence # 0 for agi 8
bad length # 0 for agi 8, should be 60176384
reset bad sb for ag 8
reset bad agf for ag 8
reset bad agi for ag 8
bad agbno 0 for btbno root, agno 8
bad agbno 0 for btbcnt root, agno 8
bad agbno 0 for inobt root, agno 8
bad on-disk superblock 15 - bad magic number
primary/secondary superblock 15 conflict - AG superblock geometry info 
conflicts with filesystem geometry
bad magic # 0x0 for agf 15
bad version # 0 for agf 15
bad sequence # 0 for agf 15
bad length 0 for agf 15, should be 60176384
bad magic # 0x0 for agi 15
bad version # 0 for agi 15
bad sequence # 0 for agi 15
bad length # 0 for agi 15, should be 60176384
reset bad sb for ag 15
reset bad agf for ag 15
reset bad agi for ag 15
bad agbno 0 for btbno root, agno 15
bad agbno 0 for btbcnt root, agno 15
bad agbno 0 for inobt root, agno 15
bad on-disk superblock 16 - bad magic number
primary/secondary superblock 16 conflict - AG superblock geometry info 
conflicts with filesystem geometry
bad magic # 0x0 for agf 16
bad version # 0 for agf 16
bad sequence # 0 for agf 16
bad length 0 for agf 16, should be 60176384
bad magic # 0x0 for agi 16
bad version # 0 for agi 16
bad sequence # 0 for agi 16
bad length # 0 for agi 16, should be 60176384
reset bad sb for ag 16
reset bad agf for ag 16
reset bad agi for ag 16
bad agbno 0 for btbno root, agno 16
bad agbno 0 for btbcnt root, agno 16
bad agbno 0 for inobt root, agno 16
bad on-disk superblock 17 - bad magic number
primary/secondary superblock 17 conflict - AG superblock geometry info 
conflicts with filesystem geometry
bad magic # 0x0 for agf 17
bad version # 0 for agf 17
bad sequence # 0 for agf 17
bad length 0 for agf 17, should be 60176384
bad magic # 0x0 for agi 17
bad version # 0 for agi 17
bad sequence # 0 for agi 17
bad length # 0 for agi 17, should be 60176384
reset bad sb for ag 17
reset bad agf for ag 17
reset bad agi for ag 17
bad agbno 0 for btbno root, agno 17
bad agbno 0 for btbcnt root, agno 17
bad agbno 0 for inobt root, agno 17
bad on-disk superblock 24 - bad magic number
primary/secondary superblock 24 conflict - AG superblock geometry info 
conflicts with filesystem geometry
bad magic # 0x0 for agf 24
bad version # 0 for agf 24
bad sequence # 0 for agf 24
bad length 0 for agf 24, should be 60176384
bad magic # 0x0 for agi 24
bad version # 0 for agi 24
bad sequence # 0 for agi 24
bad length # 0 for agi 24, should be 60176384
reset bad sb for ag 24
reset bad agf for ag 24
reset bad agi for ag 24
bad agbno 0 for btbno root, agno 24
bad agbno 0 for btbcnt root, agno 24
bad agbno 0 for inobt root, agno 24
bad on-disk superblock 25 - bad magic number
primary/secondary superblock 25 conflict - AG superblock geometry info 
conflicts with filesystem geometry
bad magic # 0x0 for agf 25
bad version # 0 for agf 25
bad sequence # 0 for agf 25
bad length 0 for agf 25, should be 60176384
bad magic # 0x0 for agi 25
bad version # 0 for agi 25
bad sequence # 0 for agi 25
bad length # 0 for agi 25, should be 60176384
reset bad sb for ag 25
reset bad agf for ag 25
reset bad agi for ag 25
bad agbno 0 for btbno root, agno 25
bad agbno 0 for btbcnt root, agno 25
bad agbno 0 for inobt root, agno 25
bad on-disk superblock 26 - bad magic number
primary/secondary superblock 26 conflict - AG superblock geometry info 
conflicts with filesystem geometry
bad magic # 0x0 for agf 26
bad version # 0 for agf 26
bad sequence # 0 for agf 26
bad length 0 for agf 26, should be 60176384
bad magic # 0x0 for agi 26
bad version # 0 for agi 26
bad sequence # 0 for agi 26
bad length # 0 for agi 26, should be 60176384
reset bad sb for ag 26
reset bad agf for ag 26
reset bad agi for ag 26
bad agbno 0 for btbno root, agno 26
bad agbno 0 for btbcnt root, agno 26
bad agbno 0 for inobt root, agno 26
        - found root inode chunk
Phase 3 - for each AG...
        - scan and clear agi unlinked lists...
error following ag 6 unlinked list
error following ag 7 unlinked list
error following ag 8 unlinked list
error following ag 15 unlinked list
error following ag 16 unlinked list
error following ag 17 unlinked list
error following ag 24 unlinked list
error following ag 25 unlinked list
error following ag 26 unlinked list
        - process known inodes and perform inode discovery...
        - agno = 0
        - agno = 1
        - agno = 2
        - agno = 3
        - agno = 4
        - agno = 5
        - agno = 6
        - agno = 7
        - agno = 8
        - agno = 9
        - agno = 10
        - agno = 11
        - agno = 12
        - agno = 13
        - agno = 14
        - agno = 15
        - agno = 16
        - agno = 17
        - agno = 18
        - agno = 19
        - agno = 20
        - agno = 21
        - agno = 22
        - agno = 23
        - agno = 24
        - agno = 25
        - agno = 26
        - agno = 27
        - agno = 28
        - agno = 29
        - agno = 30
        - agno = 31
        - process newly discovered inodes...
Phase 4 - check for duplicate blocks...
        - setting up duplicate extent list...
        - clear lost+found (if it exists) ...
        - check for inodes claiming duplicate blocks...
        - agno = 0
        - agno = 1
        - agno = 2
        - agno = 3
        - agno = 4
        - agno = 5
        - agno = 6
        - agno = 7
        - agno = 8
        - agno = 9
        - agno = 10
        - agno = 11
        - agno = 12
        - agno = 13
        - agno = 14
        - agno = 15
        - agno = 16
        - agno = 17
        - agno = 18
        - agno = 19
        - agno = 20
        - agno = 21
        - agno = 22
        - agno = 23
        - agno = 24
        - agno = 25
        - agno = 26
        - agno = 27
        - agno = 28
        - agno = 29
        - agno = 30
        - agno = 31
Phase 5 - rebuild AG headers and trees...
        - reset superblock...
Phase 6 - check inode connectivity...
        - resetting contents of realtime bitmap and summary inodes
        - ensuring existence of lost+found directory
        - traversing filesystem starting at / ...
        - traversal finished ...
        - traversing all unattached subtrees ...
        - traversals finished ...
        - moving disconnected inodes to lost+found ...
Phase 7 - verify and correct link counts...
done

(this is the same filesystem on which crash happened, I haven't done mkfs 
in between).

> Also please include xfs_info output for the filesystem, and whether you
> expect that any clients are writing files > 4G...

Having ability for clients to write files larger than > 4G would be nice, 
but this bug occured even when clients wrote file approximately 700MB 
large.

Here is xfs_info output:

storage2:~# mount /raid3
storage2:~# xfs_info /dev/mapper/lvol1-lv1
meta-data=/raid3                 isize=256    agcount=32, agsize=60176384 
blks
         =                       sectsz=512
data     =                       bsize=4096   blocks=1925644288, 
imaxpct=25
         =                       sunit=0      swidth=0 blks, unwritten=1
naming   =version 2              bsize=4096
log      =internal               bsize=4096   blocks=32768, version=1
         =                       sectsz=512   sunit=0 blks
realtime =none                   extsz=65536  blocks=0, rtextents=0

> And, that stack looks awfully long if it's real, turning on the stack
> overflow check in the kernel might be interesting.

I will do it as soon as I get physically to the server, and will send you 
output, if it shows anything interesting (stack overflow).

Thanks, kind regards,

-- 
JiKos.
