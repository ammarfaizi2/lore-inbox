Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161064AbWBAO0n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161064AbWBAO0n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 09:26:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161066AbWBAO0n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 09:26:43 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:6865 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S1161064AbWBAO0m
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 09:26:42 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: Edward Shishkin <edward@namesys.com>
Subject: Re: Recursive chmod/chown OOM kills box with 32MB RAM
Date: Wed, 1 Feb 2006 16:26:17 +0200
User-Agent: KMail/1.8.2
Cc: Chris Mason <mason@suse.com>, Hans Reiser <reiser@namesys.com>,
       linux-kernel@vger.kernel.org,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>
References: <200601281613.16199.vda@ilport.com.ua> <200602011215.54637.vda@ilport.com.ua> <43E0A0F9.2090806@namesys.com>
In-Reply-To: <43E0A0F9.2090806@namesys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602011626.17697.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 01 February 2006 13:52, Edward Shishkin wrote:
> ># reiserfstune -s 1024 /dev/sdc3
> >reiserfstune: Journal device has not been specified. Assuming journal is on the main device (/dev/sdc3).
> >
> >Current parameters:
> >
> >Filesystem state: consistent
> >
> >Reiserfs super block in block 16 on 0x823 of format 3.6 with standard journal
> >Count of blocks on the device: 2094474
> >Number of bitmaps: 64
> >Blocksize: 4096
> >Free blocks (count of blocks - used [journal, bitmaps, data, reserved] blocks): 1019710
> >Root block: 32941
> >Filesystem is cleanly umounted
> >Tree height: 4
> >Hash function used to sort names: "r5"
> >Objectid map size 54, max 972
> >Journal parameters:
> >        Device [0x0]
> >        Magic [0x2cac04df]
> >        Size 8193 blocks (including 1 for journal header) (first block 18)
> >        Max transaction length 1024 blocks
> >        Max batch size 900 blocks
> >        Max commit age 30
> >Blocks reserved by journal: 0
> >Fs state field: 0x0:
> >sb_version: 2
> >inode generation number: 293892
> >UUID: 7b3aa1ab-40bd-44da-98dc-b37b21f7add0
> >LABEL:
> >Set flags in SB:
> >        ATTRIBUTES CLEAN
> >reiserfstune: Current journal parameters:
> >        Device [0x0]
> >        Magic [0x2cac04df]
> >        Size 8193 blocks (including 1 for journal header) (first block 18)
> >        Max transaction length 1024 blocks
> >        Max batch size 900 blocks
> >        Max commit age 30
> >WARNING: wrong transaction max size (1024). Changed to 511
> >reiserfstune: New journal parameters:
> >        Device [0x0]
> >        Magic [0x70dbc903]
> >        Size 1024 blocks (including 1 for journal header) (first block 18)
> >        Max transaction length 511 blocks
> >        Max batch size 449 blocks
> >        Max commit age 30
> >Reiserfs super block in block 16 on 0x823 of format 3.6 with non-standard journal
> >Count of blocks on the device: 2094474
> >Number of bitmaps: 64
> >Blocksize: 4096
> >Free blocks (count of blocks - used [journal, bitmaps, data, reserved] blocks): 1019710
> >Root block: 32941
> >Filesystem is cleanly umounted
> >Tree height: 4
> >Hash function used to sort names: "r5"
> >Objectid map size 54, max 972
> >Journal parameters:
> >        Device [0x0]
> >        Magic [0x70dbc903]
> >        Size 1024 blocks (including 1 for journal header) (first block 18)
> >        Max transaction length 511 blocks
> >        Max batch size 449 blocks
> >        Max commit age 30
> >Blocks reserved by journal: 8193
> >Fs state field: 0x0:
> >sb_version: 2
> >inode generation number: 293892
> >UUID: 7b3aa1ab-40bd-44da-98dc-b37b21f7add0
> >LABEL:
> >Set flags in SB:
> >        ATTRIBUTES CLEAN
> >reiserfstune: ATTENTION: YOU ARE ABOUT TO SETUP THE NEW JOURNAL FOR THE "/dev/sdc3"!
> >AREA OF "/dev/sdc3" DEDICATED FOR JOURNAL WILL BE ZEROED!
> >Continue (y/n):y
> >Initializing journal - 0%....20%....40%....60%....80%....100%
> >Syncing..ok
> >
> ># mount /dev/sdc3 /.3 -o noatime
> >mount: you must specify the filesystem type
> >
> ># dmesg | tail -4
> >br: topology change detected, propagating
> >br: port 1(ifi) entering forwarding state
> >FAT: bogus number of reserved sectors
> >VFS: Can't find a valid FAT filesystem on dev sdc3.
> >
> ># reiserfsck /dev/sdc3
> >reiserfsck 3.6.11 (2003 www.namesys.com)
> >
> >*************************************************************
> >** If you are using the latest reiserfsprogs and  it fails **
> >** please  email bug reports to reiserfs-list@namesys.com, **
> >** providing  as  much  information  as  possible --  your **
> >** hardware,  kernel,  patches,  settings,  all reiserfsck **
> >** messages  (including version),  the reiserfsck logfile, **
> >** check  the  syslog file  for  any  related information. **
> >** If you would like advice on using this program, support **
> >** is available  for $25 at  www.namesys.com/support.html. **
> >*************************************************************
> >
> >Will read-only check consistency of the filesystem on /dev/sdc3
> >Will put log info to 'stdout'
> >
> >Do you want to run this program?[N/Yes] (note need to type Yes if you do):Yes
> >Failed to open the journal device ((null)).
> >
> >	Wow... 8(
> >--
> >vda
> >  
> >
> 
> would you try
> reiserfsck -j /dev/sdc3 /dev/sdc3

Updated tools to reiserfsprogs-3.6.19, then:

# reiserfsck -j /dev/sdc3 /dev/sdc3
reiserfsck 3.6.19 (2003 www.namesys.com)

*************************************************************
** If you are using the latest reiserfsprogs and  it fails **
** please  email bug reports to reiserfs-list@namesys.com, **
** providing  as  much  information  as  possible --  your **
** hardware,  kernel,  patches,  settings,  all reiserfsck **
** messages  (including version),  the reiserfsck logfile, **
** check  the  syslog file  for  any  related information. **
** If you would like advice on using this program, support **
** is available  for $25 at  www.namesys.com/support.html. **
*************************************************************

Will read-only check consistency of the filesystem on /dev/sdc3
Will put log info to 'stdout'

Do you want to run this program?[N/Yes] (note need to type Yes if you do):Yes
###########
reiserfsck --check started at Wed Feb  1 16:24:20 2006
###########
Replaying journal..
No transactions found
Checking internal tree..finished
Comparing bitmaps..finished
Checking Semantic tree:
finished
No corruptions found
There are on the filesystem:
        Leaves 8075
        Internal nodes 52
        Directories 1792
        Other files 31865
        Data block pointers 1058363 (0 of them are zero)
        Safe links 0
###########
reiserfsck finished at Wed Feb  1 16:26:33 2006
###########

--
vda
