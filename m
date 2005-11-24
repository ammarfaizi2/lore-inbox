Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932616AbVKXCZH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932616AbVKXCZH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 21:25:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932617AbVKXCZH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 21:25:07 -0500
Received: from smtp.osdl.org ([65.172.181.4]:16084 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932616AbVKXCZF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 21:25:05 -0500
Date: Wed, 23 Nov 2005 18:24:43 -0800
From: Andrew Morton <akpm@osdl.org>
To: Bret Towe <magnade@gmail.com>
Cc: linux-kernel@vger.kernel.org, dm-devel@redhat.com
Subject: Re: lvm/nfs crash
Message-Id: <20051123182443.67e971cc.akpm@osdl.org>
In-Reply-To: <dda83e780511231808j64878ed0tc629db72cd94b164@mail.gmail.com>
References: <dda83e780511231808j64878ed0tc629db72cd94b164@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bret Towe <magnade@gmail.com> wrote:
>
> while doing a pvmove to get some data off of a drive that was starting to fail
> i did a refresh on a nfs mount from a client and the server
> doing this pvmove got the following crash in dmesg
> and it happened pvmove didnt make any progress any more
> after a reboot so i could try resuming pvmove it would crash on
> fsck of one of the lvm partitons i finally got it to boot correctly after
> running a livecd resuming the pvmove from there without even
> trying to fsck
> 
> the kernel that did this orignally i had named 2.6.14-git11.5
> which for me means i synced to the git tree before the -git12 snapshot
> had been made  i also booted back to 2.6.13.3 to see if it worked
> but it gave similiar crash i forgot to take a picture of ether of those
> crashs at boot but solving this other crash would prob prevent
> the other from happening
> 
> and no before you ask i do not intend to repeat it :)
> hopefully somethin can be made of this
> 

Are you using 4k stacks or 8k?

(Full context for dm-devel):

> 
> Unable to handle kernel paging request at virtual address fa0ed3b8
>  printing eip:
> f8823997
> *pde = 33948067
> *pte = 00000000
> Oops: 0000 [#1]
> Modules linked in: snd_pcm_oss snd_pcm snd_timer snd_page_alloc isofs
> r8169 snd_mixer_oss snd soundcore ipt_multiport ipt_TOS iptable_nat
> ipt_limit ipt_state ipt_LOG ipt_recent iptable_mangle ipt_ULOG
> iptable_filter ip_tables ip_nat_ftp ip_conntrack_ftp ip_nat_irc ip_nat
> ip_conntrack_irc ip_conntrack nfnetlink parport_pc lp parport w83627hf
> hwmon_vid i2c_isa i2c_viapro tun bridge ehci_hcd uhci_hcd ohci_hcd
> 8139too mii dm_snapshot dm_mirror dm_mod
> CPU:    0
> EIP:    0060:[<f8823997>]    Not tainted VLI
> EFLAGS: 00210246   (2.6.14-git11.5)
> EIP is at core_in_sync+0x7/0x20 [dm_mirror]
> eax: ecfb38a0   ebx: fa0e9000   ecx: 00000000   edx: 00021dd4
> esi: e6d3d480   edi: de0da500   ebp: 00000000   esp: f748a994
> ds: 007b   es: 007b   ss: 0068
> Process nfsd (pid: 4250, threadinfo=f748a000 task=f63f8af0)
> Stack: f8827580 f88255e1 00000000 0000000a 00021dd4 00000000 dfe540a4 ceaebfe0
>        dfcf05c0 ceaebfd8 e6d3d480 f8838078 f8815380 00000000 00000000 e6d3d780
>        ceaebfe8 f748aa34 f881563d 00000000 00000001 00000008 00200286 00011210
> Call Trace:
>  [<f88255e1>] mirror_map+0xa1/0x140 [dm_mirror]
>  [<f8815380>] __map_bio+0x40/0x110 [dm_mod]
>  [<f881563d>] __clone_and_map+0xcd/0x310 [dm_mod]
>  [<c01371ba>] mempool_alloc+0x2a/0xc0
>  [<f8815927>] __split_bio+0xa7/0x120 [dm_mod]
>  [<f88159f4>] dm_request+0x54/0x80 [dm_mod]
>  [<c0219cca>] generic_make_request+0xca/0x140
>  [<f8815380>] __map_bio+0x40/0x110 [dm_mod]
>  [<f881563d>] __clone_and_map+0xcd/0x310 [dm_mod]
>  [<c01371ba>] mempool_alloc+0x2a/0xc0
>  [<f8815927>] __split_bio+0xa7/0x120 [dm_mod]
>  [<f88159f4>] dm_request+0x54/0x80 [dm_mod]
>  [<c0219cca>] generic_make_request+0xca/0x140
>  [<c0138280>] buffered_rmqueue+0xe0/0x1a0
>  [<c0225250>] radix_tree_node_alloc+0x10/0x50
>  [<c02254a5>] radix_tree_insert+0xd5/0x130
>  [<c0219d94>] submit_bio+0x54/0xe0
>  [<c0152d2c>] bh_lru_install+0x8c/0xb0
>  [<c01554f5>] bio_alloc_bioset+0x155/0x1e0
>  [<c0154df3>] submit_bh+0x133/0x180
>  [<c0154ec9>] ll_rw_block+0x89/0xb0
>  [<c01a5273>] search_by_key+0xa3/0xc60
>  [<c0228396>] copy_to_user+0x36/0x60
>  [<c030b039>] memcpy_toiovec+0x29/0x50
>  [<c0168ce9>] iget5_locked+0x79/0xf0
>  [<c01690e1>] iput+0x31/0x70
>  [<c01b29d0>] reiserfs_permission+0x0/0x20
>  [<c01b29df>] reiserfs_permission+0xf/0x20
>  [<c01666cb>] dput+0x4b/0x1b0
>  [<c01e1ba9>] nfsd_acceptable+0x79/0xd0
>  [<c01df059>] find_exported_dentry+0x79/0x560
>  [<c018e39b>] search_by_entry_key+0x2b/0x220
>  [<c0190c4b>] make_cpu_key+0x4b/0x60
>  [<c0198bd5>] reiserfs_readdir+0xd5/0x470
>  [<c01f0c10>] nfs3svc_encode_entry_plus+0x0/0x50
>  [<c011556f>] activate_task+0x5f/0x70
>  [<c0115e77>] __wake_up_common+0x37/0x60
>  [<c01937ad>] reiserfs_decode_fh+0xad/0xf0
>  [<c01e1b30>] nfsd_acceptable+0x0/0xd0
>  [<c014fa4e>] __dentry_open+0xbe/0x210
>  [<c014fc03>] lookup_instantiate_filp+0x13/0x80
>  [<c0161dad>] vfs_readdir+0x6d/0x90
>  [<c01e66a6>] nfsd_readdir+0x66/0xe0
>  [<c01ed33c>] nfsd3_proc_readdirplus+0xbc/0x1e0
>  [<c01f0c10>] nfs3svc_encode_entry_plus+0x0/0x50
>  [<c01efaa0>] nfs3svc_decode_readdirplusargs+0x0/0x1a0
>  [<c01dfefa>] nfsd_dispatch+0x8a/0x210
>  [<c03a09df>] svc_authenticate+0x5f/0xa0
>  [<c039de02>] svc_process+0x272/0x660
>  [<c0115e30>] default_wake_function+0x0/0x10
>  [<c01dfd12>] nfsd+0x162/0x2c0
>  [<c01dfbb0>] nfsd+0x0/0x2c0
>  [<c0101365>] kernel_thread_helper+0x5/0x10
> Code: 00 00 00 00 53 8b 40 04 8b 58 1c 0f a3 13 19 c0 5b 85 c0 0f 95
> c0 0f b6 c0 c3 8d 76 00 8d bc 27 00 00 00 00 53 8b 40 04 8b 58 20 <0f>
> a3 13 19 c0 5b 85 c0 0f 95 c0 0f b6 c0 c3 8d 76 00 8d bc 27
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
