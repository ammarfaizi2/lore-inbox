Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751380AbWACLmR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751380AbWACLmR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 06:42:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751381AbWACLmR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 06:42:17 -0500
Received: from smtp110.plus.mail.mud.yahoo.com ([68.142.206.243]:7538 "HELO
	smtp110.plus.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751380AbWACLmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 06:42:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=DqPo+x57fMKb4RI9HxUgHxL8pB8pZRDP5lb98Y+ICVt7rHhXyHd4JDBGc6GJELaiTGsrF5dc03tB7Rkgh78CvXNPpvCHGvcmsqBlk9eZW19wMDlOcq9cbUFmsrqTlrWZjGCe4cklkTogqeGtSCWfVRIl34kv5z8oh+DJ4tL78t0=  ;
Message-ID: <43BA630F.1020805@yahoo.com.au>
Date: Tue, 03 Jan 2006 22:42:07 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: mm/rmap.c negative page map count BUG.
References: <20060103082609.GB11738@redhat.com>
In-Reply-To: <20060103082609.GB11738@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> This has cropped up from time to time in the last few Fedora
> kernels, by several users. I just got another report that it's
> still a problem on 2.6.15rc7 based kernels (so likely .15 final too).
> 
>  kernel: kernel BUG at mm/rmap.c:486!
>  kernel: invalid operand: 0000 [#1]
>  kernel: Modules linked in: parport_pc lp parport nfs lockd nfs_acl autofs4 sunrpc dm_mod ipv6 uhci_hcd shpchp i2c_piix4 i2c_core snd_es18xx snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss snd_pcm snd_page_alloc snd_opl3_lib snd_timer snd_hwdep snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore tlan floppy ext3 jbd aic7xxx scsi_transport_spi sd_mod scsi_mod
>  kernel: CPU:    0
>  kernel: EIP:    0060:[<c01502b2>]    Not tainted VLI
>  kernel: EFLAGS: 00010286   (2.6.14-1.1769_FC4) 
>  kernel: EIP is at page_remove_rmap+0x25/0x2f
>  kernel: eax: ffffffff   ebx: c8331e30   ecx: c1152360   edx: c1152360
>  kernel: esi: 08f8c000   edi: c1152360   ebp: 00000000   esp: c2114d78
>  kernel: ds: 007b   es: 007b   ss: 0068
>  kernel: Process udevd (pid: 11892, threadinfo=c2114000 task=c54af030)
>  kernel: Stack: c0149a90 c3d70e34 c0419b20 c349d440 ffffffff ffffff3f c349d490 c2e6b08c 
>  kernel:        09000000 c2114dfc c2e6b08c c0149ccb 08ecb000 09000000 c2114dfc 00000000 
>  kernel:        c3d70e34 c0419b20 c2e6b08c 0913dfff 08ecb000 c3d70e34 0913e000 c2114e24 
>  kernel: Call Trace:
>  kernel:  [<c0149a90>] zap_pte_range+0x105/0x25a  [<c0149ccb>] unmap_page_range+0xe6/0x110
>  kernel:  [<c0149dc7>] unmap_vmas+0xd2/0x1f1     [<c014e5f2>] exit_mmap+0x5f/0xda
>  kernel:  [<c0119669>] mmput+0x1f/0x95     [<c0162f1f>] exec_mmap+0xc7/0x149
>  kernel:  [<c0163084>] flush_old_exec+0x7b/0x8b7     [<c01595ff>] vfs_read+0xf6/0x158
>  kernel:  [<c0162e4e>] kernel_read+0x37/0x41     [<c0182e30>] load_elf_binary+0x2b9/0xd8e
>  kernel:  [<c01408b0>] __alloc_pages+0x57/0x2ed     [<c01df430>] copy_from_user+0x42/0x82
>  kernel:  [<c0182b77>] load_elf_binary+0x0/0xd8e     [<c0163b32>] search_binary_handler+0x7a/0x243
>  kernel:  [<c0163ee3>] do_execve+0x1e8/0x210     [<c0101b3f>] sys_execve+0x30/0x72
>  kernel:  [<c0102ec5>] syscall_call+0x7/0xb    
>  kernel: Code: 2e 0d 33 c0 eb bf 89 c2 83 40 08 ff 0f 98 c0 84 c0 75 01 c3 8b 42 08 83 c0 01 78 0f ba ff ff ff ff b8 10 00 00 00 e9 32 0b ff ff <0f> 0b e6 01 2e 0d 33 c0 eb e7 55 57 56 53 83 ec 0c 89 c7 89 d3 
> 
> The BUG it's hitting is the BUG_ON(page_mapcount(page) < 0); in page_remove_rmap()
> 
> anyone with any ideas wtf happened here ?
> 
> shortly after hitting this, the users usually report thing likes like ...
> 
> kernel: Bad page state at free_hot_cold_page (in process 'kswapd0', page c1152360)
> kernel: flags:0x80000010 mapping:00000000 mapcount:-1 count:0
> 

Well it isn't PG_reserved, so it is unlikely to be something like ZERO_PAGE.
That kswapd eventually frees it indicates it is a regular pagecache page on
the LRU... so it is unusual that nobody has reported it here.

Can you reproduce it? On a kernel.org kernel? Can you print ->flags, ->count,
->mapping, etc instead of going BUG?

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
