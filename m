Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261237AbVFTNXR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261237AbVFTNXR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 09:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261217AbVFTNXR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 09:23:17 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:17596 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261242AbVFTNV3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 09:21:29 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.12-mm1: Kernel BUG at "fs/open.c":935
Date: Mon, 20 Jun 2005 15:21:11 +0200
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org
References: <20050619233029.45dd66b8.akpm@osdl.org>
In-Reply-To: <20050619233029.45dd66b8.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506201521.12274.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 20 of June 2005 08:30, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12/2.6.12-mm1/
> 
> 
> - Someone broke /proc/device-tree on ppc64.  It's being looked into.
> 
> - Nothing particularly special here - various fixes and updates.

Unfortunately, it's broken with preempt on x86-64 (Athlon 64):

Kernel BUG at "fs/open.c":935
invalid operand: 0000 [1] PREEMPT 
CPU 0 
Modules linked in: usbserial thermal processor fan button battery ac snd_pcm_oss snd_mixer_oss snd_intel8x0 snd_ac97_codec snd_pcm snd_timer snd soundcore snd_page_alloc ipt_LOG ipt_limit ipt_pkttype ipt_state ipt_REJECT iptable_mangle iptable_filter ip6table_mangle ip_nat_ftp iptable_nat ip_conntrack_ftp ip_conntrack ip_tables ip6table_filter ip6_tables ipv6 af_packet pcmcia firmware_class yenta_socket rsrc_nonstatic pcmcia_core usbhid ehci_hcd ohci_hcd sk98lin evdev joydev sg st sr_mod sd_mod scsi_mod ide_cd cdrom dm_mod parport_pc lp parport
Pid: 4269, comm: kded Not tainted 2.6.12-mm1
RIP: 0010:[<ffffffff801a14fb>] <ffffffff801a14fb>{fd_install+187}
RSP: 0018:ffff81002196bed8  EFLAGS: 00010286
RAX: ffff81002c8d3668 RBX: ffff81002fd627b8 RCX: 0000000000000080
RDX: ffff81002846e490 RSI: ffff810022549a88 RDI: 0000000000000001
RBP: 0000000000000080 R08: 0000000000000000 R09: 0000000000000000
R10: ffff81002f16a000 R11: 0000000000000246 R12: ffff810022549a88
R13: 0000000000000080 R14: 0000000000000080 R15: ffff81002846e490
FS:  00002aaaae576d20(0000) GS:ffffffff80588840(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00002aaaaae75b88 CR3: 0000000021fd6000 CR4: 00000000000006e0
Process kded (pid: 4269, threadinfo ffff81002196a000, task ffff81002d750070)
Stack: 0000000000000080 ffff81002fd627b8 0000000000000080 0000000000000080 
       ffff81002fd627b8 ffffffff801beb4d ffff81002d98d000 000000000000000c 
       ffff810022549a88 0000000000000000 
Call Trace:<ffffffff801beb4d>{dupfd+589} <ffffffff801bed75>{sys_fcntl+309}
       <ffffffff8010f442>{system_call+126} 

Code: 0f 0b 9f d9 3e 80 ff ff ff ff a7 03 48 8b 42 10 4c 89 24 c8 
RIP <ffffffff801a14fb>{fd_install+187} RSP <ffff81002196bed8>
 <6>note: kded[4269] exited with preempt_count 1
scheduling while atomic: kded/0x10000001/4269

Call Trace:<ffffffff803c82ea>{schedule+122} <ffffffff8013a875>{release_console_sem+693}
       <ffffffff8013a94d>{release_console_sem+909} <ffffffff803c8c3f>{cond_resched+47}
       <ffffffff80189c01>{unmap_vmas+1841} <ffffffff8018e98a>{exit_mmap+298}
       <ffffffff80137203>{mmput+51} <ffffffff8013fe55>{do_exit+437}
       <ffffffff80111125>{die+69} <ffffffff80111ac1>{do_invalid_op+145}
       <ffffffff801a14fb>{fd_install+187} <ffffffff801bc43f>{link_path_walk+367}
       <ffffffff80153383>{in_group_p+67} <ffffffff8017d800>{check_poison_obj+48}
       <ffffffff8017e1a6>{poison_obj+70} <ffffffff8010fd39>{error_exit+0}
       <ffffffff801a14fb>{fd_install+187} <ffffffff801a1467>{fd_install+39}
       <ffffffff801beb4d>{dupfd+589} <ffffffff801bed75>{sys_fcntl+309}
       <ffffffff8010f442>{system_call+126} 

Please let me know if you need more information.

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
