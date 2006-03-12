Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751819AbWCLXHj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751819AbWCLXHj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 18:07:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751883AbWCLXHi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 18:07:38 -0500
Received: from smtp.osdl.org ([65.172.181.4]:10719 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751819AbWCLXHi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 18:07:38 -0500
Date: Sun, 12 Mar 2006 15:01:58 -0800
From: Andrew Morton <akpm@osdl.org>
To: Laurent Riffard <laurent.riffard@free.fr>
Cc: linux-kernel@vger.kernel.org, Alasdair G Kergon <agk@redhat.com>,
       "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>, Greg KH <greg@kroah.com>
Subject: Re: 2.6.16-rc6-mm1: BUG at fs/sysfs/inode.c:180
Message-Id: <20060312150158.3c7be5c3.akpm@osdl.org>
In-Reply-To: <44146C31.3010905@free.fr>
References: <20060312031036.3a382581.akpm@osdl.org>
	<44146C31.3010905@free.fr>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Laurent Riffard <laurent.riffard@free.fr> wrote:
>
> Le 12.03.2006 12:10, Andrew Morton a écrit :
>  > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc6/2.6.16-rc6-mm1/
> 
>  Hello,
> 
>  This kernel hangs on boot while trying to activate logical 
>  volumes from initrd: 
> 
>  ------------[ cut here ]------------
>  kernel BUG at fs/sysfs/inode.c:180!
>  invalid opcode: 0000 [#1]
>  last sysfs file: /block/ram0/dev
>  Modules linked in: dm_mirror dm_mod
>  CPU:    0
>  EIP:    0060:[<c0172e71>]    Not tainted VLI
>  EFLAGS: 00010246   (2.6.16-rc6-mm1 #123) 
>  EIP is at sysfs_get_name+0xd/0x46
>  eax: c15a49c8   ebx: dfe2b988   ecx: dff254d8   edx: c15a49cc
>  esi: dfe87b05   edi: dfe2b988   ebp: dfe67d28   esp: dfe67d28
>  ds: 007b   es: 007b   ss: 0068
>  Process vgchange (pid: 242, threadinfo=dfe67000 task=dfe175d0)
>  Stack: <0>dfe67d44 c01738c3 dffdc4b4 c15a49c8 dfe2b988 ffffffef dfe2b98d dfe67d60 
>         c0173dcd dff2a804 dfe2b984 dfe2b984 00000001 fffffffe dfe67d74 c0173f3b 
>         dfe67d6c c15a84d4 dfe2b984 dfe67d90 c01a33fd c03242d0 00000004 dfe2b8f8 
>  Call Trace:
>   [<c0103a31>] show_stack_log_lvl+0x8b/0x95
>   [<c0103b69>] show_registers+0x12e/0x194
>   [<c0103e62>] die+0x14e/0x1db
>   [<c01040ba>] do_trap+0x7c/0x96
>   [<c0104319>] do_invalid_op+0x89/0x93
>   [<c01034db>] error_code+0x4f/0x54
>   [<c01738c3>] sysfs_dirent_exist+0x1c/0x65
>   [<c0173dcd>] create_dir+0x55/0x17d
>   [<c0173f3b>] sysfs_create_dir+0x46/0x61
>   [<c01a33fd>] kobject_add+0xa4/0x14c
>   [<c017267e>] register_disk+0x4b/0xe9
>   [<c019c28c>] add_disk+0x2e/0x3d
>   [<e08198a5>] create_aux+0x27e/0x2d7 [dm_mod]
>   [<e081991d>] dm_create+0xe/0x10 [dm_mod]
>   [<e081c317>] dev_create+0x4a/0x239 [dm_mod]
>   [<e081c18c>] ctl_ioctl+0x203/0x238 [dm_mod]
>   [<c0156648>] do_ioctl+0x3c/0x4f
>   [<c0156851>] vfs_ioctl+0x1f6/0x20d
>   [<c0156892>] sys_ioctl+0x2a/0x44
>   [<c01029bb>] sysenter_past_esp+0x54/0x75
>  Code: 0b 30 01 72 85 28 c0 ff 06 31 db eb 07 89 f8 e8 d1 8d fe ff 83 c4 10 89 d8 5b 5e 5f c9 c3 55 85 c0 89 e5 74 06 83 78 14 00 75 08 <0f> 0b b4 00 73 d3 28 c0 8b 50 18 83 fa 08 74 22 7f 0a 83 fa 02 

Thanks.

Greg, can you please interpret this?  What does this BUG:

const unsigned char * sysfs_get_name(struct sysfs_dirent *sd)
{
	struct attribute * attr;
	struct bin_attribute * bin_attr;
	struct relay_attribute * rel_attr;
	struct sysfs_symlink  * sl;

	if (!sd || !sd->s_element)
		BUG();

tell us?

I assume the bug was introduced by one of the device mapper patches:

device-mapper-snapshot-fix-origin_write-pending_exception-submission.patch
device-mapper-snapshot-replace-sibling-list.patch
device-mapper-snapshot-fix-invalidation.patch
drivers-md-dm-raid1c-fix-inconsistent-mirroring-after-interrupted.patch
dm-remove-sector_format.patch
dm-make-sure-queue_flag_cluster-is-set-properly.patch
md-make-sure-queue_flag_cluster-is-set-properly-for-md.patch


