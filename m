Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262192AbVCUX7M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262192AbVCUX7M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 18:59:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262233AbVCUX5B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 18:57:01 -0500
Received: from fire.osdl.org ([65.172.181.4]:8925 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262192AbVCUXfi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 18:35:38 -0500
Date: Mon, 21 Mar 2005 15:35:37 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andrew Taylor <taylor@array.ca>
Cc: linux-kernel@vger.kernel.org, taylor@array.ca, biswa@array.ca
Subject: Re: [Oops] 2.6.10: PREEMPT SMP
Message-Id: <20050321153537.1612b671.akpm@osdl.org>
In-Reply-To: <20050308205048.GC1546@monk>
References: <20050308205048.GC1546@monk>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Taylor <taylor@array.ca> wrote:
>
> Hello,
> 
> We have been experiencing a very similar oops on a Dell poweredge 2600, running Fedora Core 3 (FC3). This host is mainly used as a samba fileserver. The problem has been seen on 2 different machines (both Dell-pe-2600s).

Could you pleae confirm that 2.6.12-rc1 fixes this?

Thanks.

> The problem is only ever seen when running the SMP kernel in conjunction with samba.
> 
> We have been experiencing problems since early January when the samba/nfs/io load was increased considerably. Since then a number of 2.4 kernels have been used:
> 2.4.22.2115nptlsmp (FC1)
> 2.4.22-1.2199smp (FC1)
> 2.4.29 (vanilla kernel)
> 2.6.10-1.741_FC3smp (FC3)
> 2.6.10-1.766_FC3smp (FC3)
> 
> All 2.4 kernels produced the same result: full system lock-up, with no messages on the console or the log files.
> 
> The 2.6.10 kernel is giving an oops which has been seen 3 time in the last 3 days. A very similar one was seen pointing to eip: c01b2d98 on the 2.6.10-1.741 kernel.
>   
> I have included the kallsyms and System.map relevant to the instruction pointed to by the EIP. I can include the full files if required. 
> 
> printing eip:
> c01b387c
> *pde = 2fcdd001
> Oops: 0000 [#1]
> SMP
> Modules linked in: nfsd exportfs md5 ipv6 parport_pc lp parport autofs4 nfs lockd sunrpc video button battery ac uhci_hcd hw_random e1000 floppy sg dm_snapshot dm_zero dm_mirror ext3 jbd dm_mod mptscsih mptbase sd_mod scsi_mod
> CPU:    1
> EIP:    0060:[<c01b387c>]    Not tainted VLI
> EFLAGS: 00010203   (2.6.10-1.766_FC3smp)
> EIP is at __rb_rotate_left+0x8/0x36
> eax: f57be640   ebx: c041e5e4   ecx: f57be640   edx: 00000000
> esi: f57be640   edi: f5f39c80   ebp: c041e5e4   esp: efa2eed0
> ds: 007b   es: 007b   ss: 0068
> Process smbd (pid: 8536, threadinfo=efa2e000 task=f7612a60)
> Stack: f5ac1980 c01b3988 f5f39c80 f5f39c80 f5ac1988 00000267 c01965d7 f5ac1980
> 0000000d efa2ef54 efa2ef61 ffffffea c019668b 00000015 00000000 00000267
> c03191e0 efa2ef54 00000000 f599ed80 00000267 c01977df ffffffff 001f0000
> Call Trace:
> [<c01b3988>] rb_insert_color+0xa8/0xc1
> [<c01965d7>] key_user_lookup+0xcf/0xfc
> [<c019668b>] key_alloc+0x53/0x2b6
> [<c01977df>] keyring_alloc+0x1a/0x48
> [<c0198d43>] alloc_uid_keyring+0x2b/0x7c
> [<c0125d2e>] alloc_uid+0xae/0x133
> [<c01291d4>] set_user+0xb/0x8b
> [<c01295f2>] sys_setresuid+0x11a/0x1b9
> [<c0103c97>] syscall_call+0x7/0xb
> Code: 82 04 01 00 00 00 75 ea 41 83 f9 01 76 ed 31 c0 5b c3 57 b9 45 00 00 00 89 c7 31 c0 f3 ab 5f c3 90 90 90 53 89 d3 8b 50 08 89 c1 <8b> 42 0c 85 c0 89 41 08 74 02 89 08 89 4a 0c 8b 01 85 c0 89 02
> 
> 
> /proc/kallsyms grepped on c01b3.
> 
> c01b3024 t newary
> c01b313c T sys_semget
> c01b325a t try_atomic_semop
> c01b336b t update_queue
> c01b33de t count_semncnt
> c01b342c t count_semzcnt
> c01b347a t freeary
> c01b34f6 t copy_semid_to_user
> c01b354b t semctl_nolock
> c01b3731 t semctl_main
> c01b3ad6 t semctl_down
> c01b3c39 T sys_semctl
> c01b3ce9 t lookup_undo
> c01b3d19 t find_undo
> 
> 
> root@msh2-c boot]# grep -i c01b3 /boot/System.map-2.6.10-1.766_FC3smp 
> c01b304b T match_int
> c01b3052 T match_octal
> c01b305c T match_hex
> c01b3066 T match_strcpy
> c01b3098 T match_strdup
> c01b30c0 t radix_tree_node_alloc
> c01b3109 T radix_tree_preload
> c01b317d t radix_tree_extend
> c01b321c T radix_tree_insert
> c01b3303 T radix_tree_lookup
> c01b3349 T radix_tree_tag_set
> c01b33b8 T radix_tree_tag_clear
> c01b347a t __lookup
> c01b3547 T radix_tree_gang_lookup
> c01b3595 t __lookup_tag
> c01b369d T radix_tree_gang_lookup_tag
> c01b36f0 T radix_tree_delete
> c01b3835 T radix_tree_tagged
> c01b3863 t radix_tree_node_ctor
> c01b3874 t __rb_rotate_left
> c01b38aa t __rb_rotate_right
> c01b38e0 T rb_insert_color
> c01b39a1 t __rb_erase_color
> c01b3b0c T rb_erase
> c01b3bcd T rb_first
> c01b3be5 T rb_last
> c01b3bfd T rb_next
> c01b3c26 T rb_prev
> c01b3c4f T rb_replace_node
> c01b3c94 T rwsem_wake
> c01b3d89 T rwsem_downgrade_wake
> c01b3e14 T strnicmp
> c01b3e75 T strcpy
> c01b3e89 T strncpy
> c01b3ea8 T strlcpy
> c01b3eeb T strcat
> c01b3f0a T strncat
> c01b3f35 T strlcat
> c01b3f97 T strcmp
> c01b3fae T strncmp
> c01b3fe0 T strchr
> c01b3ff0 T strrchr
> 
> Cheers,
> 
> Andrew Taylor 
> 
> Systems Engineer
> Array Systems Computing Inc.  
> email: taylor@array.ca
> http:  www.array.ca
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
