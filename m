Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275424AbRJVKFd>; Mon, 22 Oct 2001 06:05:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278472AbRJVKFY>; Mon, 22 Oct 2001 06:05:24 -0400
Received: from [210.52.24.10] ([210.52.24.10]:55308 "HELO mx.linux.net.cn")
	by vger.kernel.org with SMTP id <S278469AbRJVKFN>;
	Mon, 22 Oct 2001 06:05:13 -0400
Date: Mon, 22 Oct 2001 18:08:29 +0800
From: Fang Han <dfbb@linux.net.cn>
To: linux-kernel@vger.kernel.org
Subject: [Bug] CONFIG_SCSI_MULTILUN cause XFS kernel oops
Message-ID: <20011022180829.D1621@dfbbb.cn.mvd>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My XFS version was 2.4.5-SGI_XFS_1.0.1, on an machine with
one PIII 750 on an dual processor motherboard
2x50G scsi disk on aic7899, It have an SCSI_MULTI_LUN
device, sda / sdb


When I create xfs over sdb.  and mount it.
the mount speed is real slow(about 10s ), some time 
it success, some times it tell me

 XFS: failed to read root inode

When I create xfs over it and mount it again, It will oops.

oops out put is here.

BTW:
1.  With the same kernel and same operation running on
other machine, ( 1 IDE machine, 1 SCSI+Raid+SMP machine)
It works fine, And the time of mount running very fast

2. When do same thing on sda with an new kernel without
CSI_MULTI_LUN , It works fine too.

3. When we use ext2/reiserfs in sdb , mount speed is still slow,
But kernel never oops.

Here is the oops output: 


>>EIP; d084daa2 <[xfs_support]mrupdatef+6/3c>   <=====
Trace; d089a2df <[xfs]xfs_iget+c3/110>
Trace; d089a745 <[xfs]xfs_ilock_ra+71/9c>
Trace; d089a783 <[xfs]xfs_ilock+13/18>
Trace; d089a2df <[xfs]xfs_iget+c3/110>
Trace; d089a2df <[xfs]xfs_iget+c3/110>
Trace; d08a9362 <[xfs]xfs_mountfs+d8e/11e8>
Trace; d082d9d7 <[aic7xxx]aic7xxx_queue+173/180>
Trace; d08856f0 <[xfs]xfs_dir2_mount+0/124>
Trace; c0105b99 <__down+a1/ac>
Trace; d08a822b <[xfs]xfs_readsb+b7/d0>
Trace; d08b1bee <[xfs]xfs_cmountfs+512/5bc>
Trace; d08c06c7 <[xfs]linvfs_read+a7/d4>
Trace; d08b1e09 <[xfs]xfs_mount+a9/b4>
Trace; d08d4500 <[xfs]__module_kernel_version+0/20>
Trace; d08d4500 <[xfs]__module_kernel_version+0/20>
Trace; d08b1e37 <[xfs]xfs_vfsmount+23/38>
Trace; d08d4500 <[xfs]__module_kernel_version+0/20>
Trace; d08cd1d9 <[xfs]linvfs_read_super+1b9/380>
Trace; d08d4500 <[xfs]__module_kernel_version+0/20>
Trace; d08d4280 <[xfs]xfs_fs_type+0/20>
Trace; d085ec7c <[xfs]xfs_acl_iaccess+2c/94>
Trace; d08ceb40 <[xfs].rodata.start+420/5c4>
Trace; d085ec7c <[xfs]xfs_acl_iaccess+2c/94>
Trace; d08ceb40 <[xfs].rodata.start+420/5c4>
Trace; c0143d8a <destroy_inode+1a/20>
Trace; c014532f <iput+14f/158>
Trace; c01385c4 <blkdev_get+108/128>
Trace; c013628b <read_super+63/a8>
Trace; c0136480 <get_sb_bdev+150/1a8>
Trace; d08d4280 <[xfs]xfs_fs_type+0/20>
Trace; c0136eca <do_mount+172/2f0>
Trace; d08d4280 <[xfs]xfs_fs_type+0/20>
Trace; d08d4280 <[xfs]xfs_fs_type+0/20>
Trace; c0136d0c <copy_mount_options+4c/98>
Trace; c01370cc <sys_mount+84/c8>
Trace; c0106d9b <system_call+33/38>
Code;  d084daa2 <[xfs_support]mrupdatef+6/3c>
00000000 <_EIP>:
Code;  d084daa2 <[xfs_support]mrupdatef+6/3c>   <=====
   0:   83 3b 00                  cmpl   $0x0,(%ebx)   <=====
Code;  d084daa5 <[xfs_support]mrupdatef+9/3c>
   3:   74 1d                     je     22 <_EIP+0x22> d084dac4
<[xfs_support]mrupdatef+28/3c>
Code;  d084daa7 <[xfs_support]mrupdatef+b/3c>
   5:   ff 43 08                  incl   0x8(%ebx)
Code;  d084daaa <[xfs_support]mrupdatef+e/3c>
   8:   6a 01                     push   $0x1
Code;  d084daac <[xfs_support]mrupdatef+10/3c>
   a:   8d 43 28                  lea    0x28(%ebx),%eax
Code;  d084daaf <[xfs_support]mrupdatef+13/3c>
   d:   50                        push   %eax
Code;  d084dab0 <[xfs_support]mrupdatef+14/3c>
   e:   8d 43 1c                  lea    0x1c(%ebx),%eax
Code;  d084dab3 <[xfs_support]mrupdatef+17/3c>
  11:   50                        push   %eax



