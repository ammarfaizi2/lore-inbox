Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267438AbUIWVgp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267438AbUIWVgp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 17:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267417AbUIWVdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 17:33:39 -0400
Received: from mxfep02.bredband.com ([195.54.107.73]:62707 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S267380AbUIWVaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 17:30:19 -0400
Subject: Bad RIP on x86-64
From: Alexander Nyberg <alexn@dsv.su.se>
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de
Content-Type: text/plain
Message-Id: <1095975016.674.14.camel@boxen>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 23 Sep 2004 23:30:16 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just got this using 2.6.9-rc2-mm1 patched with staircase scheduler. I don't think
this has anything to do with staircase though.

What boggles me is the complete lack of backtrace. CR2 & RIP look weird. 
Debian pure 64-bit user space, 2-way cpu. Hmm?



<1>Unable to handle kernel NULL pointer dereference at 0000000000000286 RIP: 
[<0000000000000286>]
PML4 3b551067 PGD 3b553067 PMD 0 
Oops: 0010 [1] PREEMPT SMP 
CPU 1 
Modules linked in: snd_intel8x0 snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore snd_page_alloc 8139too mii crc32 e1000
Pid: 596, comm: xfce-mcs-manage Not tainted 2.6.9-rc2-mm1
RIP: 0010:[<0000000000000286>] [<0000000000000286>]
RSP: 0018:000001003bedf4c0  EFLAGS: 2000000040
RAX: 0000000000000020 RBX: 00000000000003e8 RCX: 0000007fbffff790
RDX: 0000000000000020 RSI: 0000007fbffff790 RDI: 0000000000000020
RBP: 000003e800000238 R08: 000001003b5b1e18 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 7fffffffffffffff
R13: 0000000000000004 R14: 0000000000000000 R15: 0000000000000008
FS:  0000002a98f82380(0000) GS:ffffffff803ba040(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000286 CR3: 000000003ffb8000 CR4: 00000000000006e0
Process xfce-mcs-manage (pid: 596, threadinfo 000001003b5b0000, task 000001003f9557e0)
Stack: 0000000000000003 0000000000000000 ffffffff803480e0 0000000000000000 
       000001003baa7dc0 000001003bb11c80 0000000100000001 000001003bedf4f8 
       000001003bedf4f8 0000000000000001 
Call Trace:

Code:  Bad RIP value.
RIP [<0000000000000286>] RSP <000001003bedf4c0>
CR2: 0000000000000286
 NMI Watchdog detected LOCKUP on CPU1, registers:
CPU 1 
Modules linked in: snd_intel8x0 snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore snd_page_alloc 8139too mii crc32 e1000
Pid: 596, comm: xfce-mcs-manage Not tainted 2.6.9-rc2-mm1
RIP: 0010:[<ffffffff802962d9>] <ffffffff802962d9>{_spin_lock+41}
RSP: 0018:000001003b5b17d8  EFLAGS: 00201046
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000001
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff8031b288
RBP: ffffffff8031b288 R08: 0000000000000000 R09: 000001003b5b1898
R10: 0000000000000001 R11: 0000000000000000 R12: 000001003b5b1938
R13: 0000000000000000 R14: 000001003b5b1898 R15: 0000000000000006
FS:  0000002a98f82380(0000) GS:ffffffff803ba040(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000286 CR3: 000000003ffb8000 CR4: 00000000000006e0
Process xfce-mcs-manage (pid: 596, threadinfo 000001003b5b0000, task 000001003f9557e0)
Stack: 0000000000201046 0000000000000001 0000000000000000 ffffffff80110c25 
       ffffffff802a78c1 ffffffff80110da0 000001003b5b1938 0000000000000000 
       0000000000000004 ffffffff80110f1e 
Call Trace:<ffffffff80110c25>{oops_begin+101} <ffffffff80110da0>{die+32} 
       <ffffffff80110f1e>{do_trap+334} <ffffffff80111201>{do_invalid_op+145} 
       <ffffffff8012eed4>{resched_task+36} <ffffffff802138ef>{serial8250_console_write+415} 
       <ffffffff8010feb1>{error_exit+0} <ffffffff8012eed4>{resched_task+36} 
       <ffffffff8012f262>{try_to_wake_up+514} <ffffffff80149e19>{autoremove_wake_function+9} 
       <ffffffff80130680>{__wake_up_common+64} <ffffffff801306f3>{__wake_up+67} 
       <ffffffff80134c10>{vprintk+432} <ffffffff80134cbd>{printk+141} 
       <ffffffff80134cbd>{printk+141} <ffffffff80110ae1>{show_registers+273} 
       <ffffffff80206987>{do_unblank_screen+119} <ffffffff8011f88e>{bust_spinlocks+62} 
       <ffffffff80110c65>{oops_end+21} <ffffffff80120086>{do_page_fault+1158} 
       <ffffffff80248ff7>{memcpy_toiovec+55} <ffffffff802474da>{__kfree_skb+154} 
       <ffffffff802920c9>{unix_stream_recvmsg+1081} <ffffffff8010feb1>{error_exit+0} 
       <ffffffff802430b6>{sock_aio_read+278} <ffffffff80184413>{poll_freewait+67} 
       <ffffffff8018491e>{do_select+1038} <ffffffff8017076d>{do_sync_read+173} 
       <ffffffff80184420>{__pollwait+0} <ffffffff80149e10>{autoremove_wake_function+0} 
       <ffffffff80184e38>{sys_select+1256} <ffffffff80170881>{vfs_read+225} 
       <ffffffff80170b13>{sys_read+83} <ffffffff8010f3c6>{system_call+126} 
       

Code: 7f 48 65 48 8b 04 25 18 00 00 00 ff 88 44 e0 ff ff 65 48 8b 
console shuts up ...
 

