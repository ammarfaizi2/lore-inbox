Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261344AbTJMCHs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 22:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261345AbTJMCHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 22:07:48 -0400
Received: from smtp802.mail.ukl.yahoo.com ([217.12.12.139]:3704 "HELO
	smtp802.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261344AbTJMCHm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 22:07:42 -0400
Message-ID: <3F8A0924.3090506@sbcglobal.net>
Date: Sun, 12 Oct 2003 21:08:36 -0500
From: Wes Janzen <superchkn@sbcglobal.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.5) Gecko/20031008
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: fire-eyes <sgtphou@fire-eyes.dynup.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test7: ide / reiserfs errors? (reiserfs_read_locked_inode)
References: <1066006220.2347.11.camel@localhost>
In-Reply-To: <1066006220.2347.11.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm seeing no such errors with IDE and reiserfs, I've been up 4 days now 
without any problems (well, some ppp/eth problems, but I digress).

I'd try leaving off the "idebus=66" for starters.  I looked in ide.txt 
and that data looks pretty old.  I'm not sure if you should need that 
except in unusual situations.  I've not used it both for my PDC20269 or 
the VIA MVP3 IDE and everything has worked fine, but then my board 
doesn't support PCI 2.2 hence I'm of course running the PCI bus at 33 
Mhz.  From that log, specifically:

Oct 12 20:19:49 localhost kernel: ide0: Drive 0 didn't accept speed
setting. Oh, well.

AND

i/o failure occurred trying to find stat data of [373169 373170 0x0 SD]

It looks to me like your drive isn't communicating correctly with the controller and IIRC the IDE timing is based off the bus speed.  So if it's sending data to your drive at the wrong speed, it won't recognize what you're trying to tell it to do.  Although I'm pretty much speaking out of my ass here and haven't recently viewed the source for your particular driver, it's still worth at least trying a ro mount without the idebus parameter to verify if this is the cause of the problem.

-Wes-



fire-eyes wrote:

>This is my first real post to the list. If I can better provide
>information, please let me know, so I can give the best possible data.
>Thanks for any hand-holding, and keep up the great work.
>
>I am seeing ide/reiserfs errors in 2.6.0-test7. I did not stick around
>long enough to investigate futher than what you see below:
>
>
>System
>Asus A7M266-D motherboard
>Two AMD XP+ 1800 CPUs
>512MB DDR RAM
>Disk drive: hda: ST3120023A, ATA DISK drive
>
>
>
>Paramaters passed to kernel via grub: root=/dev/hda6 idebus=66
>ide0=ata66 ide1=ata66
>
>I may be confused as to how the bus speed is set in 2.6, but I did not
>have these problems in 2.6.0-test6 or earlier.
>
>/var/log/syslog (hopefully this comes out sane):
>
>Oct 12 20:19:49 localhost kernel: blk: queue dfd93c00, I/O limit 4095Mb
>(mask 0xffffffff)
>Oct 12 20:19:49 localhost kernel: hda: dma_intr: status=0x58 {
>DriveReady SeekComplete DataRequest }
>Oct 12 20:19:49 localhost kernel: 
>Oct 12 20:19:49 localhost kernel: hda: set_drive_speed_status:
>status=0x58 { DriveReady SeekComplete DataRequest }
>Oct 12 20:19:49 localhost kernel: ide0: Drive 0 didn't accept speed
>setting. Oh, well.
>Oct 12 20:19:49 localhost kernel: is_leaf: nr_item seems wrong: level=1,
>nr_items=0, free_space=0 rdkey 
>Oct 12 20:19:49 localhost kernel: vs-5150: search_by_key: invalid format
>found in block 1033191. Fsck?
>Oct 12 20:19:49 localhost kernel: vs-13070: reiserfs_read_locked_inode:
>i/o failure occurred trying to find stat data of [373169 373170 0x0 SD]
>Oct 12 20:19:49 localhost kernel: blk: queue dfd93800, I/O limit 4095Mb
>(mask 0xffffffff)
>Oct 12 20:19:49 localhost xinetd[3940]: Reading included configuration
>file: /etc/xinetd.d/telnetd [file=/etc/xinetd.d/telnetd] [line=15]
>Oct 12 20:19:49 localhost kernel: is_tree_node: node level 28530 does
>not match to the expected one 1
>Oct 12 20:19:49 localhost kernel: vs-5150: search_by_key: invalid format
>found in block 23404. Fsck?
>Oct 12 20:19:49 localhost kernel: vs-13070: reiserfs_read_locked_inode:
>i/o failure occurred trying to find stat data of [6549 497433 0x0 SD]
>
>[later]
>
>Oct 12 20:20:12 localhost kernel: is_tree_node: node level 28530 does
>not match to the expected one 1
>Oct 12 20:20:12 localhost kernel: vs-5150: search_by_key: invalid format
>found in block 23404. Fsck?
>Oct 12 20:20:12 localhost kernel: vs-13070: reiserfs_read_locked_inode:
>i/o failure occurred trying to find stat data of [6572 6611 0x0 SD]
>Oct 12 20:20:12 localhost kernel: is_tree_node: node level 28530 does
>not match to the expected one 1
>Oct 12 20:20:12 localhost kernel: vs-5150: search_by_key: invalid format
>found in block 23404. Fsck?
>Oct 12 20:20:12 localhost kernel: vs-13070: reiserfs_read_locked_inode:
>i/o failure occurred trying to find stat data of [6572 6611 0x0 SD]
>Oct 12 20:20:12 localhost kernel: is_tree_node: node level 28530 does
>not match to the expected one 1
>Oct 12 20:20:12 localhost kernel: vs-5150: search_by_key: invalid format
>found in block 23404. Fsck?
>Oct 12 20:20:12 localhost kernel: vs-13070: reiserfs_read_locked_inode:
>i/o failure occurred trying to find stat data of [6572 6611 0x0 SD]
>Oct 12 20:20:12 localhost kernel: is_tree_node: node level 28530 does
>not match to the expected one 1
>Oct 12 20:20:12 localhost kernel: vs-5150: search_by_key: invalid format
>found in block 23404. Fsck?
>Oct 12 20:20:12 localhost kernel: vs-13070: reiserfs_read_locked_inode:
>i/o failure occurred trying to find stat data of [6572 6611 0x0 SD]
>Oct 12 20:20:12 localhost kernel: is_tree_node: node level 28530 does
>not match to the expected one 1
>Oct 12 20:20:12 localhost kernel: vs-5150: search_by_key: invalid format
>found in block 23404. Fsck?
>Oct 12 20:20:12 localhost kernel: vs-13070: reiserfs_read_locked_inode:
>i/o failure occurred trying to find stat data of [6572 6611 0x0 SD]
>Oct 12 20:20:41 localhost kernel: is_tree_node: node level 28530 does
>not match to the expected one 1
>Oct 12 20:20:41 localhost kernel: vs-5150: search_by_key: invalid format
>found in block 23404. Fsck?
>Oct 12 20:20:41 localhost kernel: vs-13070: reiserfs_read_locked_inode:
>i/o failure occurred trying to find stat data of [6572 6611 0x0 SD]
>Oct 12 20:21:15 localhost kernel: is_tree_node: node level 28530 does
>not match to the expected one 1
>Oct 12 20:21:15 localhost kernel: vs-5150: search_by_key: invalid format
>found in block 23404. Fsck?
>Oct 12 20:21:15 localhost kernel: vs-13070: reiserfs_read_locked_inode:
>i/o failure occurred trying to find stat data of [6572 6611 0x0 SD]
>Oct 12 20:21:22 localhost kernel: is_tree_node: node level 28530 does
>not match to the expected one 1
>Oct 12 20:21:22 localhost kernel: vs-5150: search_by_key: invalid format
>found in block 23404. Fsck?
>Oct 12 20:21:22 localhost kernel: vs-13070: reiserfs_read_locked_inode:
>i/o failure occurred trying to find stat data of [6572 6611 0x0 SD]
>Oct 12 20:21:22 localhost kernel: is_tree_node: node level 28530 does
>not match to the expected one 1
>Oct 12 20:21:22 localhost kernel: vs-5150: search_by_key: invalid format
>found in block 23404. Fsck?
>Oct 12 20:21:22 localhost kernel: vs-13070: reiserfs_read_locked_inode:
>i/o failure occurred trying to find stat data of [6572 6611 0x0 SD]
>Oct 12 20:22:49 localhost kernel: is_tree_node: node level 28530 does
>not match to the expected one 1
>Oct 12 20:22:49 localhost kernel: vs-5150: search_by_key: invalid format
>found in block 23404. Fsck?
>Oct 12 20:22:49 localhost kernel: vs-13070: reiserfs_read_locked_inode:
>i/o failure occurred trying to find stat data of [6572 6611 0x0 SD]
>Oct 12 20:23:07 localhost kernel: is_tree_node: node level 28530 does
>not match to the expected one 1
>Oct 12 20:23:07 localhost kernel: vs-5150: search_by_key: invalid format
>found in block 23404. Fsck?
>Oct 12 20:23:07 localhost kernel: vs-13070: reiserfs_read_locked_inode:
>i/o failure occurred trying to find stat data of [6572 6611 0x0 SD]
>Oct 12 20:23:07 localhost kernel: is_tree_node: node level 28530 does
>not match to the expected one 1
>Oct 12 20:23:07 localhost kernel: vs-5150: search_by_key: invalid format
>found in block 23404. Fsck?
>Oct 12 20:23:07 localhost kernel: vs-13070: reiserfs_read_locked_inode:
>i/o failure occurred trying to find stat data of [6572 6611 0x0 SD]
>Oct 12 20:23:07 localhost kernel: is_tree_node: node level 28530 does
>not match to the expected one 1
>Oct 12 20:23:07 localhost kernel: vs-5150: search_by_key: invalid format
>found in block 23404. Fsck?
>Oct 12 20:28:13 localhost kernel: is_tree_node: node level 28530 does
>not match to the expected one 1
>Oct 12 20:28:13 localhost kernel: vs-5150: search_by_key: invalid format
>found in block 23404. Fsck?
>Oct 12 20:28:13 localhost kernel: vs-13070: reiserfs_read_locked_inode:
>i/o failure occurred trying to find stat data of [6549 123379 0x0 SD]
>Oct 12 20:28:13 localhost kernel: is_tree_node: node level 28530 does
>not match to the expected one 1
>Oct 12 20:28:13 localhost kernel: vs-5150: search_by_key: invalid format
>found in block 23404. Fsck?
>Oct 12 20:28:13 localhost kernel: vs-13070: reiserfs_read_locked_inode:
>i/o failure occurred trying to find stat data of [6549 118884 0x0 SD]
>Oct 12 20:28:13 localhost kernel: is_tree_node: node level 28530 does
>not match to the expected one 1
>Oct 12 20:28:13 localhost kernel: vs-5150: search_by_key: invalid format
>found in block 23404. Fsck?
>Oct 12 20:28:13 localhost kernel: vs-13070: reiserfs_read_locked_inode:
>i/o failure occurred trying to find stat data of [6549 496832 0x0 SD]
>Oct 12 20:28:13 localhost kernel: is_tree_node: node level 28530 does
>not match to the expected one 1
>Oct 12 20:28:13 localhost kernel: vs-5150: search_by_key: invalid format
>found in block 23404. Fsck?
>
>This goes on for quite a while.
>  
>

