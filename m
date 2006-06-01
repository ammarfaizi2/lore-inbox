Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030201AbWFAPfa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030201AbWFAPfa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 11:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030203AbWFAPfa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 11:35:30 -0400
Received: from nz-out-0102.google.com ([64.233.162.200]:29741 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1030201AbWFAPf3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 11:35:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=k0TzWxFsh7FYjhJKZT+W5HHh/sCdOmgjM1wbLFqeh5UHqA5+oKx28uEDpLhVfjWtfwwycobzaV/qlLKbUnpBW1NhHPZSalljJj49GWq2yUaip6mSRyYlla9GwNFFf5w4NzGQoVixd/DdqqpF2z6KqBC/I8YQJIQf3+6cM2dnHgw=
Message-ID: <20f65d530606010835h76356757k3d3714203d5e4c6@mail.gmail.com>
Date: Fri, 2 Jun 2006 03:35:28 +1200
From: "Keith Chew" <keith.chew@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: IO APIC IRQ assignment
In-Reply-To: <20f65d530606010338h23dbd152u2670000ba6130fc6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20f65d530605300521q1d56c3a3t84be3d92f1df0c14@mail.gmail.com>
	 <20060530135017.GD5151@harddisk-recovery.com>
	 <20f65d530605300705l60bfcca7k47a41c95bf42a0ef@mail.gmail.com>
	 <Pine.LNX.4.61.0606010002200.30170@yvahk01.tjqt.qr>
	 <20f65d530605311612n15820847sca559d0c443fc230@mail.gmail.com>
	 <20060601094214.GA14431@harddisk-recovery.com>
	 <20f65d530606010338h23dbd152u2670000ba6130fc6@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Looks like our workaround (ie setting PCI latency, etc) did not help.
The system freezed this morning, with a spinlock lockup. Any help in
tracking down the problem will be much appreciated. Since this is not
related to the original topic "IO APIC", I can resubmit this post as a
new thread:

===================================
Unable to handle kernel paging request at virtual address 23232327
 printing eip:
c014b569
*pde = 00000000
Oops: 0002 [#1]
Modules linked in: ipt_LOG ipt_state iptable_filter ip_tables ip_conntrack_tf
ip_conntrack_proto_sctp ip_conntrack_irc ip_conntrack_ftp ip_conntrack_amanda
_conntrack rt2570 zd1211 autofs4 video button battery ac uhci_hcd bt878 tuner
audio bttv video_buf i2c_algo_bit v4l2_common btcx_risc tveeprom videodev i2c
01 i2c_core snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm_oss snd_mixer_os
nd_pcm snd_timer snd soundcore snd_page_alloc e100 mii dm_snapshot dm_zero dm
rror ext3 jbd dm_mod
CPU:    0
EIP:    0060:[<c014b569>]    Not tainted VLI
EFLAGS: 00010046   (2.6.14.2)
EIP is at activate_page+0x59/0xd0
eax: 23232323   ebx: c1400160   ecx: c1400178   edx: 23232323
esi: c03b7300   edi: c03b73e0   ebp: 00000001   esp: d3769ae4
ds: 007b   es: 007b   ss: 0068
Process mencoder (pid: 23017, threadinfo=d3768000 task=d615d030)
Stack: d3769b7c 00000000 c1400160 00000040 c1000000 c014b613 c1400160 c0150b1
       c7fe9d68 0000000f 00000001 b771d000 00000001 00000000 00000001 e5d26ee
       f724124c f7241200 c0150cbe f7241200 b775a000 00000000 00000001 0000000
Call Trace:
 [<c014b613>] mark_page_accessed+0x33/0x40
 [<c0150b13>] __follow_page+0x153/0x160
 [<c0150cbe>] get_user_pages+0x11e/0x380
 [<f896e348>] videobuf_dma_init_user+0x118/0x190 [video_buf]
 [<f896eac7>] videobuf_iolock+0x77/0x110 [video_buf]
 [<f89a0909>] bttv_prepare_buffer+0x179/0x1c0 [bttv]
 [<f89a2b9c>] bttv_do_ioctl+0xbdc/0x1850 [bttv]
 [<c035d2eb>] _read_unlock+0xb/0x10
 [<f8a553c4>] zd1205_xmit_frame+0x94/0x4a0 [zd1211]
 [<c035d2ab>] _spin_lock+0xb/0x10
 [<c0300c73>] qdisc_restart+0x23/0x200
 [<c035d2cb>] _spin_unlock+0xb/0x10
 [<c02f0312>] dev_queue_xmit+0x2a2/0x330
 [<f8cae3c3>] tcp_in_window+0x303/0x510 [ip_conntrack]
 [<c035d1bf>] _spin_lock_irqsave+0xf/0x20
 [<c0124d28>] __mod_timer+0xa8/0xd0
 [<c035d3cb>] _write_unlock_bh+0xb/0x20
 [<f8cad773>] __ip_ct_refresh_acct+0x73/0xc0 [ip_conntrack]
 [<f8caeaa3>] tcp_packet+0x1a3/0x580 [ip_conntrack]
 [<c02ea2e1>] __alloc_skb+0x61/0x150
 [<c026b0e8>] dma_pool_alloc+0x98/0x180
 [<c0117597>] activate_task+0x67/0x80
 [<c0117688>] try_to_wake_up+0x88/0xd0
 [<c01176ed>] wake_up_process+0x1d/0x20
 [<c035d31b>] _spin_unlock_irq+0xb/0x10
 [<f8a466f3>] uhci_alloc_qh+0x23/0x60 [uhci_hcd]
 [<c0117597>] activate_task+0x67/0x80
 [<c0117688>] try_to_wake_up+0x88/0xd0
 [<c0131b7f>] autoremove_wake_function+0x2f/0x60
 [<c0118021>] __wake_up_common+0x41/0x80
 [<c01e4756>] copy_from_user+0x66/0xa0
 [<f897b427>] video_usercopy+0xf7/0x180 [videodev]
 [<c0117688>] try_to_wake_up+0x88/0xd0
 [<c0118021>] __wake_up_common+0x41/0x80
 [<c011809e>] __wake_up+0x3e/0x60
 [<f89a384f>] bttv_ioctl+0x3f/0x70 [bttv]
 [<f89a1fc0>] bttv_do_ioctl+0x0/0x1850 [bttv]
 [<c0177b48>] do_ioctl+0x58/0x80
 [<c0177cd5>] vfs_ioctl+0x65/0x1f0
 [<c01e46d6>] copy_to_user+0x66/0x80
 [<c0177ee8>] sys_ioctl+0x88/0xa0
 [<c01031af>] sysenter_past_esp+0x54/0x75
Code: 74 06 8b 03 a8 40 74 1a 89 f8 8b 5c 24 08 8b 74 24 0c 8b 7c 24 10 83 c4
 e9 b4 1d 21 00 8d 74 26 00 8d 4b 18 8b 43 18 8b 51 04 <89> 50 04 89 02 c7 41
 00 02 20 00 c7 43 18 00 01 10 00 ff 8e
 <6>bttv2: timeout: drop=79382 irq=27663181/27663182, risc=063fd218, bits:
bttv1: timeout: drop=79789 irq=27657488/37569186, risc=11efc8c0, bits:
BUG: spinlock cpu recursion on CPU#0, mencoder/23014
 lock: f724124c, .magic: dead4ead, .owner: mencoder/23017, .owner_cpu: 0
 [<c01e52b3>] _raw_spin_lock+0x83/0xa0
 [<c035d2ab>] _spin_lock+0xb/0x10
 [<c0152432>] __handle_mm_fault+0x72/0x240
 [<c0129b15>] notifier_call_chain+0x25/0x50
 [<c035e3d3>] do_page_fault+0x1e3/0x600
 [<c035e1f0>] do_page_fault+0x0/0x600
 [<c0103433>] error_code+0x4f/0x54
BUG: soft lockup detected on CPU#0!

Pid: 23014, comm:             mencoder
EIP: 0060:[<c01e5192>] CPU: 0
EIP is at __spin_lock_debug+0x42/0xe0
 EFLAGS: 00000212    Not tainted  (2.6.14.2)
EAX: 6b541ad0 EBX: 00000000 ECX: 3af5ead5 EDX: 00000000
ESI: 001b79e2 EDI: f724124c EBP: e59d8000 DS: 007b ES: 007b
CR0: 80050033 CR2: b6213000 CR3: 1791d000 CR4: 000006d0
 [<c010368b>] show_trace+0x3b/0x90
 [<c0103433>] error_code+0x4f/0x54
 [<c01e529c>] _raw_spin_lock+0x6c/0xa0
 [<c035d2ab>] _spin_lock+0xb/0x10
 [<c0152432>] __handle_mm_fault+0x72/0x240
 [<c0129b15>] notifier_call_chain+0x25/0x50
 [<c035e3d3>] do_page_fault+0x1e3/0x600
 [<c035e1f0>] do_page_fault+0x0/0x600
 [<c0103433>] error_code+0x4f/0x54
BUG: spinlock lockup on CPU#0, mencoder/23014, f724124c
 [<c01e51fc>] __spin_lock_debug+0xac/0xe0
 [<c01e529c>] _raw_spin_lock+0x6c/0xa0
 [<c035d2ab>] _spin_lock+0xb/0x10
 [<c0152432>] __handle_mm_fault+0x72/0x240
 [<c0129b15>] notifier_call_chain+0x25/0x50
 [<c035e3d3>] do_page_fault+0x1e3/0x600
 [<c035e1f0>] do_page_fault+0x0/0x600
 [<c0103433>] error_code+0x4f/0x54

===================================

Regards
Keith
