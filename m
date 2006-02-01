Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751322AbWBALwr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322AbWBALwr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 06:52:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbWBALwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 06:52:47 -0500
Received: from chen.mtu.ru ([195.34.34.232]:38919 "EHLO chen.mtu.ru")
	by vger.kernel.org with ESMTP id S1751322AbWBALwq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 06:52:46 -0500
Message-ID: <43E0A0F9.2090806@namesys.com>
Date: Wed, 01 Feb 2006 14:52:25 +0300
From: Edward Shishkin <edward@namesys.com>
Organization: Namesys
User-Agent: Mozilla/5.0 (X11; U; Linux i686; cs-CZ; rv:1.7.12) Gecko/20050921
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: Chris Mason <mason@suse.com>, Hans Reiser <reiser@namesys.com>,
       linux-kernel@vger.kernel.org,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>
Subject: Re: Recursive chmod/chown OOM kills box with 32MB RAM
References: <200601281613.16199.vda@ilport.com.ua> <200601300822.47821.mason@suse.com> <200602010942.36134.vda@ilport.com.ua> <200602011215.54637.vda@ilport.com.ua>
In-Reply-To: <200602011215.54637.vda@ilport.com.ua>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:

>On Wednesday 01 February 2006 09:42, Denis Vlasenko wrote:
>  
>
>>On Monday 30 January 2006 15:22, Chris Mason wrote:
>>    
>>
>>>You can shrink the log of an existing filesystem.  The minimum size is 513 
>>>blocks, you might try 1024 as a good starting poing.
>>>
>>>reiserfstune -s 1024 /dev/xxxx
>>>
>>>The filesystem must be unmounted first.
>>>      
>>>
>>It doesn't want to, for no obvious reason:
>>
>># mount
>>rootfs on / type rootfs (rw)
>>/dev/root on / type ext2 (ro,nogrpid)
>>none on /proc type proc (rw,nodiratime)
>>none on /sys type sysfs (rw)
>>none on /dev type ramfs (rw)
>>/dev/sda2 on /.share type ext2 (rw,noatime,nogrpid)
>>/dev/sdb2 on /.1 type reiserfs (rw,noatime)
>>/dev/sdc2 on /.2 type reiserfs (rw,noatime)
>>/dev/sdc3 on /.3 type reiserfs (rw,noatime)
>>/dev/sda2 on /.local type ext2 (rw,noatime,nogrpid)
>>none on /dev/pts type devpts (rw)
>>automount(pid1043) on /.local/mnt/auto type autofs (rw)
>># umount /.3
>>umount: /.3: device is busy
>># mount -o ro,remount /.3
>># umount /.3
>>umount: /.3: device is busy
>># reiserfstune /dev/sdc3
>>reiserfstune: Reiserfstune is not allowed to be run on mounted filesystem.
>># lsof -nP | grep -F '/.3'
>># lsof -nP | grep -F '/dev/sdc'
>>    
>>
>
>Removed it from /etc/fstab, after reboot:
>
># reiserfstune -s 1024 /dev/sdc3
>reiserfstune: Journal device has not been specified. Assuming journal is on the main device (/dev/sdc3).
>
>Current parameters:
>
>Filesystem state: consistent
>
>Reiserfs super block in block 16 on 0x823 of format 3.6 with standard journal
>Count of blocks on the device: 2094474
>Number of bitmaps: 64
>Blocksize: 4096
>Free blocks (count of blocks - used [journal, bitmaps, data, reserved] blocks): 1019710
>Root block: 32941
>Filesystem is cleanly umounted
>Tree height: 4
>Hash function used to sort names: "r5"
>Objectid map size 54, max 972
>Journal parameters:
>        Device [0x0]
>        Magic [0x2cac04df]
>        Size 8193 blocks (including 1 for journal header) (first block 18)
>        Max transaction length 1024 blocks
>        Max batch size 900 blocks
>        Max commit age 30
>Blocks reserved by journal: 0
>Fs state field: 0x0:
>sb_version: 2
>inode generation number: 293892
>UUID: 7b3aa1ab-40bd-44da-98dc-b37b21f7add0
>LABEL:
>Set flags in SB:
>        ATTRIBUTES CLEAN
>reiserfstune: Current journal parameters:
>        Device [0x0]
>        Magic [0x2cac04df]
>        Size 8193 blocks (including 1 for journal header) (first block 18)
>        Max transaction length 1024 blocks
>        Max batch size 900 blocks
>        Max commit age 30
>WARNING: wrong transaction max size (1024). Changed to 511
>reiserfstune: New journal parameters:
>        Device [0x0]
>        Magic [0x70dbc903]
>        Size 1024 blocks (including 1 for journal header) (first block 18)
>        Max transaction length 511 blocks
>        Max batch size 449 blocks
>        Max commit age 30
>Reiserfs super block in block 16 on 0x823 of format 3.6 with non-standard journal
>Count of blocks on the device: 2094474
>Number of bitmaps: 64
>Blocksize: 4096
>Free blocks (count of blocks - used [journal, bitmaps, data, reserved] blocks): 1019710
>Root block: 32941
>Filesystem is cleanly umounted
>Tree height: 4
>Hash function used to sort names: "r5"
>Objectid map size 54, max 972
>Journal parameters:
>        Device [0x0]
>        Magic [0x70dbc903]
>        Size 1024 blocks (including 1 for journal header) (first block 18)
>        Max transaction length 511 blocks
>        Max batch size 449 blocks
>        Max commit age 30
>Blocks reserved by journal: 8193
>Fs state field: 0x0:
>sb_version: 2
>inode generation number: 293892
>UUID: 7b3aa1ab-40bd-44da-98dc-b37b21f7add0
>LABEL:
>Set flags in SB:
>        ATTRIBUTES CLEAN
>reiserfstune: ATTENTION: YOU ARE ABOUT TO SETUP THE NEW JOURNAL FOR THE "/dev/sdc3"!
>AREA OF "/dev/sdc3" DEDICATED FOR JOURNAL WILL BE ZEROED!
>Continue (y/n):y
>Initializing journal - 0%....20%....40%....60%....80%....100%
>Syncing..ok
>
># mount /dev/sdc3 /.3 -o noatime
>mount: you must specify the filesystem type
>
># dmesg | tail -4
>br: topology change detected, propagating
>br: port 1(ifi) entering forwarding state
>FAT: bogus number of reserved sectors
>VFS: Can't find a valid FAT filesystem on dev sdc3.
>
># reiserfsck /dev/sdc3
>reiserfsck 3.6.11 (2003 www.namesys.com)
>
>*************************************************************
>** If you are using the latest reiserfsprogs and  it fails **
>** please  email bug reports to reiserfs-list@namesys.com, **
>** providing  as  much  information  as  possible --  your **
>** hardware,  kernel,  patches,  settings,  all reiserfsck **
>** messages  (including version),  the reiserfsck logfile, **
>** check  the  syslog file  for  any  related information. **
>** If you would like advice on using this program, support **
>** is available  for $25 at  www.namesys.com/support.html. **
>*************************************************************
>
>Will read-only check consistency of the filesystem on /dev/sdc3
>Will put log info to 'stdout'
>
>Do you want to run this program?[N/Yes] (note need to type Yes if you do):Yes
>Failed to open the journal device ((null)).
>
>	Wow... 8(
>--
>vda
>  
>

would you try
reiserfsck -j /dev/sdc3 /dev/sdc3

Thanks,
Edward.
