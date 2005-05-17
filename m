Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261327AbVEQIg5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261327AbVEQIg5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 04:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261339AbVEQIg5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 04:36:57 -0400
Received: from mta-fs-be-04.sunrise.ch ([194.158.229.33]:13787 "EHLO
	mail-fs.sunrise.ch") by vger.kernel.org with ESMTP id S261327AbVEQIgv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 04:36:51 -0400
Message-ID: <4289AC27.900@email.it>
Date: Tue, 17 May 2005 10:32:39 +0200
From: Fabio Rosciano <malmostoso@email.it>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vladimir Saveliev <vs@namesys.com>
CC: "reiserfs-dev@namesys.com" <reiserfs-dev@namesys.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6.12-rc4] Oops in reiserfs_panic [please CC]
References: <42879F6F.6040008@email.it> <1116311376.13500.52.camel@tribesman.namesys.com>
In-Reply-To: <1116311376.13500.52.camel@tribesman.namesys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vladimir Saveliev wrote:
> yes, please provide more information:
> does 2.6.9 still work corectly?

Absolutely wonderful, as it has ever done.

> does the oops come up every time  you boot with 2.6.12-rc4?

Yes.

> please ksymoops the oops output

I have never used this tool, but from the man page looks like it needs 
the syslogd stuff, and the oops occurs right before syslogd is started, 
so I have to copy it by hand :(
Ok let's go:

Checking internal tree... finished

REISERFS: panic (device NULL superblock): reiserfs [1795]: assertion !( 
comp_keys( &MAX_KEY, p_s_key ) && ! key_in_buffer(p_s_search_path, 
p_s_key, p_s_sb) ) failed at fs/reiserfs/stree.c:685:search_by_key: 
PAP-5130: key is not in the buffer

kernel BUG in reiserfs_panic at fs/reiserfs/prints.c:362!
Oops: Exception in kernel mode, sig: 5 [#1]
PREEMPT
NIP: C00C6C18 LR: C00C6C18 SP:E7BD7B80 REGS: e7bd7ad0 TRAP: 0700 Not tainted
MSR: 00029032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = e77f86f0[1795] 'mount' THREAD: e7bd6000
Last syscall: 21
GPR00: C00C6C18 E7BD7B80 E77F86F0 000000FB 00002798 FFFFFFFF E7C6B4D0 
00000008
GPR08: 0000000B C04D0000 00000008 E7BD6000 88000424 1002A544 00000000 
E7BD7D28
GPR16: 100241F8 00000004 00000001 E7BD7D60 00000000 E7BD7D10 E7D6A200 
10024218
GPR24: 7F927F3E E7D6A200 E7BD7D60 E7BD7D60 E7BD7D60 C0371850 E7BD7D10 
00000000
NIP [c00c6c18] reiserfs_panic+0x70/0x9c
LR [c00c6c18] reiserfs_panic+0x70/0x9c
Call Trace:
[c00d3f98] search_by_key+0x2898/0x3200
[c00c2b84] finish_unfinished+0x70/0x428
[c00c4128] reiserfs_remount+0x2b8/0x2e0
[c006c6c8] do_remount_sb+0xbc/0x14c
[c0087398] do_remount+oxac/0x108
[c0087fe4] do_mount+0x184/0x190
[c0088474] sys_mount+0xa8/0xfc
[c0004680] ret_from_syscall+0x0/0xfc
/etc/rcS.d/S10checkroot.sh: line 290: 1795 trace/breakpoint trap  mount 
-n -o remount,$rootopts,$rootmode $fstabroot / 2>/dev/null

> send all output which might be related to this oops

This is my partition table:

/dev/hda
         #                    type name                 length   base 
   ( size )  system
/dev/hda1     Apple_partition_map Apple                    63 @ 1 
  ( 31.5k)  Partition map
/dev/hda2         Apple_Bootstrap untitled               2048 @ 64 
  (  1.0M)  NewWorld bootblock
/dev/hda3         Apple_Bootstrap /                  10240000 @ 2112 
  (  4.9G)  NewWorld bootblock
/dev/hda4               Apple_HFS Apple_HFS_Untitled_3 20709296 @ 
57430848 (  9.9G)  HFS
/dev/hda5         Apple_UNIX_SVR2 swap                 524288 @ 10242112 
(256.0M)  Linux swap
/dev/hda6         Apple_UNIX_SVR2 untitled           46664448 @ 10766400 
( 22.3G)  Linux native
/dev/hda7              Apple_Free Extra                    16 @ 78140144 
(  8.0k)  Free space

Block size=512, Number of Blocks=78140160
DeviceType=0x0, DeviceId=0x0

This is the relevant kernel config:

CONFIG_REISERFS_FS=y
CONFIG_REISERFS_CHECK=y
CONFIG_REISERFS_PROC_INFO=y
CONFIG_REISERFS_FS_XATTR=y
CONFIG_REISERFS_FS_POSIX_ACL=y
CONFIG_REISERFS_FS_SECURITY=y

And the checkroot.sh script works good with 2.6.9, so I don't think this 
is related.

Hope this helps, please ask if you need anything else! Thank you!

-- 
Best Regards, Jack
Debian Sid PPC
