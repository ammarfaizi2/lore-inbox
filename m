Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933481AbWKNTIo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933481AbWKNTIo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 14:08:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933482AbWKNTIo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 14:08:44 -0500
Received: from dvhart.com ([64.146.134.43]:23685 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S933481AbWKNTIn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 14:08:43 -0500
Message-ID: <455A143A.50202@mbligh.org>
Date: Tue, 14 Nov 2006 11:08:42 -0800
From: Martin Bligh <mbligh@mbligh.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: Mel Gorman <mel@skynet.ie>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       val_henson@linux.intel.com, cmm@us.ibm.com
Subject: Re: Boot failure with ext2 and initrds
References: <20061114014125.dd315fff.akpm@osdl.org> <20061114184919.GA16020@skynet.ie>
In-Reply-To: <20061114184919.GA16020@skynet.ie>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mel Gorman wrote:
> On (14/11/06 01:41), Andrew Morton didst pronounce:
>> Presently at
>>
>> http://userweb.kernel.org/~akpm/2.6.19-rc5-mm2/
>>
>> and will appear later at
>>
>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc5/2.6.19-rc5-mm2/
>>
> 
> Am seeing errors with systems using ext2. First machine is a plan old x86
> using initramfs. Console output looks like;

Probably from the ext2 reservations stuff. Any chance you could back out:

ext2-reservations.patch
ext2-reservations-fix.patch
ext2-reservations-sequential-read-regression-fix.patch
ext2-reservations-filesystem-bogus-ENOSPC-with-reservation-fix.patch
ext2-reservations-ext3_clear_inode-avoid-kfree-null.patch
ext2-reservations-multile-block-allocate-little-endian-fixes.patch
ext2-reservations-mark-group-descriptors-dirty-during-allocation.patch
ext2-reservations-nuke-noisy-printk.patch
ext2-reservations-bring-ext2-reservations-code-in-line-with-latest-ext3.patch

and see if it goes away?

Else I shall pray that Val or Mingming is smarter than I am and can
see what went wrong ;-)

Thanks,

M.

> RAMDISK: Compressed image found at block 0
> VFS: Mounted root (ext2 filesystem).
> Starting udev
> Creating devices
> EXT2-fs error (device ram0): ext2_new_blocks: Allocating block in system zone - blocks from 0, length 0
> EXT2-fs error (device ram0): ext2_new_blocks: block(0) >= blocks count(5164) - block_group = 0, es == dff00400 
> EXT2-fs error (device ram0): ext2_new_blocks: Allocating block in system zone - blocks from 0, length 0
> EXT2-fs error (device ram0): ext2_new_blocks: block(0) >= blocks count(5164) - block_group = 0, es == dff00400 
> EXT2-fs error (device ram0): ext2_new_blocks: Allocating block in system zone - blocks from 0, length 0
> EXT2-fs error (device ram0): ext2_new_blocks: block(0) >= blocks count(5164) - block_group = 0, es == dff00400 
> EXT2-fs error (device ram0): ext2_new_blocks: Allocating block in system zone - blocks from 0, length 0
> EXT2-fs error (device ram0): ext2_new_blocks: block(0) >= blocks count(5164) - block_group = 0, es == dff00400 
> EXT2-fs error (device ram0): ext2_new_blocks: Allocating block in system zone - blocks from 0, length 0
> EXT2-fs error (device ram0): ext2_new_blocks: block(0) >= blocks count(5164) - block_group = 0, es == dff00400 
> 
> Second machine is a numaq with an ext2 root filesystem
> 
> hecking root file system...
> fsck 1.37 (21-Mar-2005)
> e2fsck 1.37 (21-Mar-2005)
> /dev/sda1: clean, 310908/2240224 files, 2189096/4480119 blocks (check in
> 3 mounts)
> System time was Tue Nov 14 17:06:21 UTC 2006.
> Setting the System Clock using the Hardware Clock as reference...
> System Clock set. System local time is now Tue Nov 14 17:06:23 UTC 2006.
> Cleaning up ifupdown...done.
> Calculating module dependencies... done.
> Loading modules...
> All modules loaded.
> Creating device-mapper devices...done.
> Checking all file systems...
> fsck 1.37 (21-Mar-2005)
> Setting kernel variables ...
> ... done.
> Mounting local filesystems...
> Unable to find swap-space signature
> Cleaning /tmp /var/run /var/lock.
> Running 0dns-down to make sure resolv.conf is ok...done.
> Setting up networking...done.
> Setting up IP spoofing protection: rp_filter.
> Configuring network interfaces...BUG: soft lockup detected on CPU#3!
>  [<c0139233>] softlockup_tick+0x9e/0xac
>  [<c0124a16>] update_process_times+0x4b/0x77
>  [<c0132438>] handle_update_profile+0x1c/0x2a
>  [<c010d45a>] local_apic_timer_interrupt+0x43/0x48
>  [<c010d486>] smp_apic_timer_interrupt+0x27/0x36
>  [<c0103598>] apic_timer_interrupt+0x28/0x30
>  [<c01b3b80>] ext2_try_to_allocate+0xdb/0x152
>  [<c01b3e72>] ext2_try_to_allocate_with_rsv+0x4b/0x1b2
>  [<c01b42c6>] ext2_new_blocks+0x28d/0x4b3
>  [<c01b667a>] ext2_alloc_blocks+0x4b/0xcd
>  [<c01b674a>] ext2_alloc_branch+0x4e/0x1ae
>  [<c01b36a8>] ext2_init_block_alloc_info+0x26/0x6d
>  [<c01b6b9b>] ext2_get_blocks+0x23c/0x31d
>  [<c0181c89>] alloc_buffer_head+0x38/0x3e
>  [<c017f2ef>] alloc_page_buffers+0x6f/0xb2
>  [<c01b6cb9>] ext2_get_block+0x3d/0x51
>  [<c0180162>] __block_prepare_write+0x186/0x41b
>  [<c0180c3c>] block_prepare_write+0x31/0x3f
>  [<c01b6c7c>] ext2_get_block+0x0/0x51
>  [<c013d470>] generic_file_buffered_write+0x227/0x62a
>  [<c01b6c7c>] ext2_get_block+0x0/0x51
>  [<c0173936>] file_update_time+0x3e/0xbc
>  [<c013e08e>] __generic_file_aio_write_nolock+0x538/0x563
>  [<c013b957>] find_get_page+0x22/0x43
>  [<c013e1d2>] generic_file_aio_write+0x69/0xd1
>  [<c01616a9>] do_sync_write+0xda/0x117
>  [<c012e45d>] autoremove_wake_function+0x0/0x4b
>  [<c011201c>] do_page_fault+0x394/0x6c8
>  [<c0161787>] vfs_write+0xa1/0x167
>  [<c0161909>] sys_write+0x4b/0x71
>  [<c0102b40>] syscall_call+0x7/0xb
>  [<c0330033>] __mutex_lock_interruptible_slowpath+0x7f/0x94
>  =======================
> BUG: soft lockup detected on CPU#3!
>  [<c0139233>] softlockup_tick+0x9e/0xac
>  [<c0124a16>] update_process_times+0x4b/0x77
>  [<c0132438>] handle_update_profile+0x1c/0x2a
>  [<c010d45a>] local_apic_timer_interrupt+0x43/0x48
>  [<c010d486>] smp_apic_timer_interrupt+0x27/0x36
>  [<c0103598>] apic_timer_interrupt+0x28/0x30
>  [<c01b3b79>] ext2_try_to_allocate+0xd4/0x152
>  [<c01b3e72>] ext2_try_to_allocate_with_rsv+0x4b/0x1b2
>  [<c01b42c6>] ext2_new_blocks+0x28d/0x4b3
>  [<c01b667a>] ext2_alloc_blocks+0x4b/0xcd
>  [<c01b674a>] ext2_alloc_branch+0x4e/0x1ae
>  [<c01b36a8>] ext2_init_block_alloc_info+0x26/0x6d
>  [<c01b6b9b>] ext2_get_blocks+0x23c/0x31d
>  [<c0181c89>] alloc_buffer_head+0x38/0x3e
>  [<c017f2ef>] alloc_page_buffers+0x6f/0xb2
>  [<c01b6cb9>] ext2_get_block+0x3d/0x51
>  [<c0180162>] __block_prepare_write+0x186/0x41b
>  [<c0180c3c>] block_prepare_write+0x31/0x3f
>  [<c01b6c7c>] ext2_get_block+0x0/0x51
>  [<c013d470>] generic_file_buffered_write+0x227/0x62a
>  [<c01b6c7c>] ext2_get_block+0x0/0x51
>  [<c0173936>] file_update_time+0x3e/0xbc
>  [<c013e08e>] __generic_file_aio_write_nolock+0x538/0x563
>  [<c013b957>] find_get_page+0x22/0x43
>  [<c013e1d2>] generic_file_aio_write+0x69/0xd1
>  [<c01616a9>] do_sync_write+0xda/0x117
>  [<c012e45d>] autoremove_wake_function+0x0/0x4b
>  [<c011201c>] do_page_fault+0x394/0x6c8
>  [<c0161787>] vfs_write+0xa1/0x167
>  [<c0161909>] sys_write+0x4b/0x71
>  [<c0102b40>] syscall_call+0x7/0xb
>  [<c0330033>] __mutex_lock_interruptible_slowpath+0x7f/0x94
> (message repeats a lot)
> 
> I've not investigated yet what patches might be at fault.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 

