Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932473AbWIZTG7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932473AbWIZTG7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 15:06:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932468AbWIZTG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 15:06:59 -0400
Received: from smtp102.mail.mud.yahoo.com ([209.191.85.212]:4691 "HELO
	smtp102.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932472AbWIZTG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 15:06:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=j1fLWVX6ofPKx1wOUSFV2orGEx6WhmBMLz5Ja2vLECyHfSCdwbykuXTpvUphfou92MwRVlTPtXwJWR5b3ZLFFhTELCNgGJ3WkCS4IT9HC1NBDvV1xErx1Rml86xRUeKPqvcyNeCGMdQh5pEYJbEHBHud4/KemNnajxtTiktXiPs=  ;
Message-ID: <4519200A.4000109@yahoo.com.au>
Date: Tue, 26 Sep 2006 22:41:46 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andreas Block <andreas.block@esd-electronics.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Bad page state with x86_64
References: <op.tghdlool8n9ctc@pc-block.esd>
In-Reply-To: <op.tghdlool8n9ctc@pc-block.esd>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Block wrote:
> Hi,
> 
> the following problem occurs with a driver "pa_drv" written by myself  
> under x84_64. Code works fine under x86_32 and with small modifications  
> also under ppc. Problem also occurs under 2.6.15-1.2054_FC5.
> 
> 
> Bad page state in process 'pa_test'
> page:ffff810000869000 flags:0x0100000000000414 mapping:0000000000000000  
> mapcount:0 count:0
> Trying to fix it up, but a reboot is needed
> Backtrace:
> 
> Call Trace:
>  [<ffffffff802642a4>] bad_page+0x4e/0x78
>  [<ffffffff80264591>] free_hot_cold_page+0x73/0xff
>  [<ffffffff8026c24e>] unmap_vmas+0x440/0x756
>  [<ffffffff8026f8f7>] unmap_region+0xb9/0x12c
>  [<ffffffff802705eb>] do_munmap+0x1fd/0x27a
>  [<ffffffff8043ed3d>] __down_write_nested+0x34/0x9e
>  [<ffffffff802706a8>] sys_munmap+0x40/0x5a
>  [<ffffffff80222508>] cstar_do_call+0x1b/0x65
> 
> ----------- [cut here ] --------- [please bite here ] ---------
> Kernel BUG at include/linux/mm.h:300
> invalid opcode: 0000 [1] SMP
> CPU 0
> Modules linked in: pa_drv_k26 radeon drm autofs4 hidp nfs lockd nfs_acl  
> rfcomm l2cap bluetooth sunrpc dm_mirror dm_mod video button battery  
> asus_acpi ac ipv6 lp parport_pc parport floppy nvram snd_intel8x0  
> snd_ac97_codec snd_ac97_bus snd_seq_dummy snd_seq_oss 
> snd_seq_midi_event  snd_seq snd_seq_device snd_pcm_oss snd_mixer_oss 
> snd_pcm ehci_hcd ohci1394  ieee1394 ohci_hcd snd_timer snd soundcore 
> i2c_nforce2 forcedeth i2c_core  pcspkr snd_page_alloc ext3 jbd sata_nv 
> libata sd_mod scsi_mod
> Pid: 2722, comm: pa_test Tainted: G    B 2.6.18 #1
> RIP: 0010:[<ffffffff802647e7>]  [<ffffffff802647e7>] __free_pages+0x7/0x2b
> RSP: 0018:ffff8100064cfea0  EFLAGS: 00010246
> RAX: 0000000000000000 RBX: ffff810012729ac0 RCX: 000000000000003f
> RDX: 000000000001fff0 RSI: 0000000000000005 RDI: ffff810000869000
> RBP: 0000000000005001 R08: 000000000804b02c R09: 00000000fff5a218
> R10: 0000000000005001 R11: 0000000000005001 R12: 0000000000000000
> R13: 0000000000005001 R14: ffff81001f534320 R15: ffff810012729ac0
> FS:  00002acba44ea340(0000) GS:ffffffff8061f000(0063)  
> knlGS:00000000f7faf6b0
> CS:  0010 DS: 002b ES: 002b CR0: 000000008005003b
> CR2: 00000000f7fb1000 CR3: 000000000714e000 CR4: 00000000000006e0
> Process pa_test (pid: 2722, threadinfo ffff8100064ce000, task  
> ffff81000aaaa100)
> Stack:  ffffffff885071b2 ffff810012729ac0 ffffffff885071e5 0000000000000000
>  ffffffff88507373 0000000000000000 0000000000000000 0000000000000000
>  0000000000000000 0000000000000000 0000000000000000 0000000000005001
> Call Trace:
>  [<ffffffff885071b2>] :pa_drv_k26:pa_free_local_buffer+0x1b/0x3b
>  [<ffffffff885071e5>] :pa_drv_k26:pa_destroy_local+0x13/0x17
>  [<ffffffff88507373>] :pa_drv_k26:pa_ioctl_unlocked+0x166/0x272
>  [<ffffffff802ad503>] compat_sys_ioctl+0xc5/0x2b2
>  [<ffffffff80222508>] cstar_do_call+0x1b/0x65
> 
> 
> Code: 0f 0b 68 8e f5 46 80 c2 2c 01 90 ff 4f 08 0f 94 c0 84 c0 74
> RIP  [<ffffffff802647e7>] __free_pages+0x7/0x2b
>  RSP <ffff8100064cfea0>
> 
> 
> I've a stripped down example, which reproduces the problem shown below.  
> I'll happily sent an archive containing, code of driver, library and 
> test  application to anybody, who likes to spend a look at it or attach 
> it to a  mail to this list, if I'm allowed to do so.
> 
> Note: I'm not blaming the kernel to be buggy. It may well be, that the  
> source of the problem sits between my keyboard and my chair, but I'd be  
> very grateful for any advice on what I'm doing wrong, if so.

It is freeing a PageReserved page. You should ensure to balance your
reference counting on *each* page (or allocate a compound page and
treat it as a single one). When you map pages into userspace via
nopage or remap_pfn_range, you need to increment their count, which
gets decremented by the VM when they are unmapped.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
