Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964832AbWDMJYI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964832AbWDMJYI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 05:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751237AbWDMJYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 05:24:08 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:63890 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751227AbWDMJYH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 05:24:07 -0400
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.1-RC1
From: Keith Owens <kaos@sgi.com>
To: Nathan Scott <nathans@sgi.com>
cc: dgc@melbourne.sgi.com, Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linux-xfs@oss.sgi.com, xfs-masters@oss.sgi.com,
       stern@rowland.harvard.edu, sekharan@us.ibm.com
Subject: Re: 2.6.17-rc1 did break XFS 
In-reply-to: Your message of "Thu, 13 Apr 2006 15:35:33 +1000."
             <20060413153533.H1338954@wobbly.melbourne.sgi.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 13 Apr 2006 19:23:50 +1000
Message-ID: <9020.1144920230@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Scott (on Thu, 13 Apr 2006 15:35:33 +1000) wrote:
>On Thu, Apr 13, 2006 at 07:21:45AM +0200, Herbert Poetzl wrote:
>> [   39.585041] BUG: unable to handle kernel paging request at virtual address 7856c380
>> [   39.586688]  printing eip:
>> [   39.587040] 78129430
>> [   39.587354] *pde = 005bf027
>> [   39.587709] *pte = 0056c000
>> [   39.588201] Oops: 0000 [#1]
>> [   39.588536] SMP DEBUG_PAGEALLOC
>> [   39.589057] Modules linked in:
>> [   39.589639] CPU:    0
>> [   39.589670] EIP:    0060:[<78129430>]    Not tainted VLI
>> [   39.589710] EFLAGS: 00000206   (2.6.17-rc1 #1) 
>> [   39.591291] EIP is at notifier_chain_register+0x20/0x50
>> [   39.591890] eax: 7856c378   ebx: 878db3f8   ecx: 00000000   edx: 784bf9bc
>> [   39.592601] esi: 878db3f8   edi: 878e7c00   ebp: 878db800   esp: 878cad5c
>> [   39.593399] ds: 007b   es: 007b   ss: 0068
>> [   39.593896] Process mount (pid: 50, threadinfo=878ca000 task=87f7e570)
>> [   39.594530] Stack: <0>784bf9a0 781295f4 784bf9bc 878db3f8 878db000 878db000 78136997 784bf9a0 
>> [   39.595839]        878db3f8 782d43e6 878db3f8 00000404 878db000 87d1e6a0 878e7c00 782d1813 
>> [   39.597002]        878db000 00000001 782e5eaf 00000424 00000001 878e7c00 87d1e6a0 782f2150 
>> [   39.598164] Call Trace:
>> [   39.598592]  <781295f4> blocking_notifier_chain_register+0x54/0x90   <78136997> register_cpu_notifier+0x17/0x20
>> [   39.600024]  <782d43e6> xfs_icsb_init_counters+0x46/0xb0   <782d1813> xfs_mount_init+0x23/0x160
>> [   39.601199]  <782e5eaf> kmem_zalloc+0x1f/0x50   <782f2150> bhv_insert_all_vfsops+0x10/0x50
>> [   39.602315]  <782f1835> xfs_fs_fill_super+0x35/0x1f0   <78313607> snprintf+0x27/0x30
>> [   39.603437]  <781a2134> disk_name+0x64/0xc0   <78168fbf> sb_set_blocksize+0x1f/0x50
>> [   39.604524]  <78168909> get_sb_bdev+0x109/0x160   <781445ef> __alloc_pages+0x5f/0x370
>> [   39.605612]  <782f1a20> xfs_fs_get_sb+0x30/0x40   <782f1800> xfs_fs_fill_super+0x0/0x1f0
>> [   39.606698]  <78168bb0> do_kern_mount+0xa0/0x160   <78181467> do_new_mount+0x77/0xc0
>> [   39.607764]  <78181b2f> do_mount+0x1bf/0x220   <783f4178> iret_exc+0x3d4/0x6ab
>> [   39.608790]  <78181913> copy_mount_options+0x63/0xc0   <783f398f> lock_kernel+0x2f/0x50
>> [   39.609867]  <78181f2f> sys_mount+0x9f/0xe0   <78102b27> syscall_call+0x7/0xb
>> [   39.610923] Code: 90 90 90 90 90 90 90 90 90 90 90 53 8b 54 24 08 8b 5c 24 0c 8b 02 85 c0 74 31 8b 4b 08 8d b4 26 00 00 00 00 8d bc 27 00 00 00 00 <3b> 48 08 7f 1b 8d 50 04 8b 40 04 85 c0 75 f1 31 c0 eb 0d 90 90 

Ignoring the leading NOPs, that decodes to

   0:   53                      push   %ebx
   1:   8b 54 24 08             mov    0x8(%esp,1),%edx
   5:   8b 5c 24 0c             mov    0xc(%esp,1),%ebx
   9:   8b 02                   mov    (%edx),%eax
   b:   85 c0                   test   %eax,%eax
   d:   74 31                   je     0x40
   f:   8b 4b 08                mov    0x8(%ebx),%ecx
  12:   8d b4 26 00 00 00 00    lea    0x0(%esi,1),%esi
  19:   8d bc 27 00 00 00 00    lea    0x0(%edi,1),%edi
  20:   3b 48 08                cmp    0x8(%eax),%ecx		<==== oops
  23:   7f 1b                   jg     0x40
  25:   8d 50 04                lea    0x4(%eax),%edx
  28:   8b 40 04                mov    0x4(%eax),%eax
  2b:   85 c0                   test   %eax,%eax
  2d:   75 f1                   jne    0x20
  2f:   31 c0                   xor    %eax,%eax
  31:   eb 0d                   jmp    0x40

static int notifier_chain_register(struct notifier_block **nl,
                struct notifier_block *n)
{
        while ((*nl) != NULL) {
                if (n->priority > (*nl)->priority)		<=== oops
                        break;
                nl = &((*nl)->next);
        }
        n->next = *nl;
        rcu_assign_pointer(*nl, n);
        return 0;
}

notifier_chain_register() is running the existing chain to find the
place where XFS needs to be inserted, and the existing chain is
corrupt.  Probably not an XFS problem.

Any particular reason why this kernel is using VMSPLIT_2G?

