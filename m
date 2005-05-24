Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261421AbVEXWsc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261421AbVEXWsc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 18:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262099AbVEXWsc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 18:48:32 -0400
Received: from rubis.org ([82.230.33.161]:687 "EHLO rubis.org")
	by vger.kernel.org with ESMTP id S261421AbVEXWsJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 18:48:09 -0400
Date: Wed, 25 May 2005 00:48:02 +0200
From: Stephane Jourdois <kwisatz@rubis.org>
To: LKML <linux-kernel@vger.kernel.org>, reiserfs-list@namesys.com
Message-ID: <20050524224802.GA11957@diamant.rubis.org>
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>,
	reiserfs-list@namesys.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.6.11-1-686
X-Send-From: diamant.rubis.org
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: 192.168.0.15
X-SA-Exim-Mail-From: kwisatz@rubis.org
Subject: BUG() in radix-tree.c, 2.6.11, reiserfs ?
X-SA-Exim-Version: 4.2 (built Fri, 04 Mar 2005 01:30:41 +0100)
X-SA-Exim-Scanned: Yes (on rubis.org)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I was burning a DVD-R at 16x speed on IDE, the .iso was on /dev/sda1,
which is a reiserfs part on a SATA disk.  I was at the same time
building another .iso on /dev/sda1, with files from an lvm spawned on
/dev/sd{b,c,d}.

dvdrecord and mkisofs both finished, and the system froze hard
2 minutes later.


A similar problem has already been reported as seen in :
http://marc.theaimsgroup.com/?l=linux-kernel&m=111514360829643&w=4
This makes me feel it's a reiserfs problem, and as the other report
was on a p4 it is not specific to amd64...


The kernel comes with debian port for amd64, dunno much more.
It's a 2.6.11-9-amd64-k8.

I'll provide any information if requested (and if I can :-).


Thanks for reading,

Stephane.


----------- [cut here ] --------- [please bite here ] --------- 
Kernel BUG at radix_tree:344
invalid operand: 0000 [1] 
CPU 0 
Modules linked in: isofs md5 ipv6 af_packet ipt_MASQUERADE iptable_nat ipt_LOG ipt_state ip_conntrack iptable_filter iptable_mangle ip_tables emu10k1_gp gameport snd_emu10k1 snd_rawmidi snd_seq_device snd_util_mem snd_hwdep tulip tuner bttv video_buf firmware_class i2c_algo_bit v4l2_common btcx_risc tveeprom videodev shpchp pci_hotplug amd74xx snd_intel8x0 snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore snd_page_alloc ohci_hcd i2c_nforce2 usblp eth1394 ehci_hcd natsemi de4x5 forcedeth ohci1394 dm_mod evdev powernow_k8 freq_table processor cpufreq_userspace it87 eeprom tsdev i2c_sensor i2c_isa i2c_core rtc nvidia psmouse sbp2 ieee1394 ide_generic ide_cd ide_disk ide_core reiserfs sr_mod cdrom sd_mod sata_nv unix fbcon font bitblit vesafb cfbcopyarea cfbimgblt cfbfillrect sata_sil libata scsi_mod
Pid: 173, comm: kswapd0 Tainted: P      2.6.11-9-amd64-k8
RIP: 0010:[radix_tree_tag_set+121/160] <ffffffff801cd5f9>{radix_tree_tag_set+121}
RSP: 0018:ffff81003f4b3950  EFLAGS: 00010046
RAX: ffff810010e99e00 RBX: ffff810001db7b40 RCX: ffff810010e99d10
RDX: 0000000000000008 RSI: 00000000000cbfdf RDI: ffff810010e99e08
RBP: 0000000000000000 R08: 000000000000001f R09: ffff810010e99d08
R10: 0000000000000000 R11: 0000000000000001 R12: ffff81003e250c08
R13: ffff81003f4b3e48 R14: ffff810013c95ce8 R15: ffff81003e250af0
FS:  00002aaaaae006d0(0000) GS:ffffffff803f6a80(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 00002aaaaaac1000 CR3: 0000000018496000 CR4: 00000000000006e0
Process kswapd0 (pid: 173, threadinfo ffff81003f4b2000, task ffff81003f49c780)
Stack: ffffffff80155996 ffff8100011aa270 0000000000000282 0000000000000000
       0000000000000000 0000000000000000 ffffffff8808320c 0000000000000008
       000000000000001b ffff81003ffbe9a0 
Call Trace:<ffffffff80155996>{test_set_page_writeback+134} <ffffffff8808320c>{:reiserfs:reiserfs_writepage+2140}                      <ffffffff801cdb0b>{radix_tree_delete+347} <ffffffff80153c65>{__pagevec_free+37}
       <ffffffff8015882e>{__pagevec_release_nonlru+126} <ffffffff801704df>{free_buffer_head+47}
       <ffffffff80170562>{try_to_free_buffers+114} <ffffffff8015a217>{shrink_zone+2839}
       <ffffffff801448d0>{autoremove_wake_function+0} <ffffffff8015aa85>{balance_pgdat+565}
       <ffffffff802aff01>{schedule+1} <ffffffff8015ad17>{kswapd+295}
       <ffffffff801448d0>{autoremove_wake_function+0} <ffffffff801448d0>{autoremove_wake_function+0}
       <ffffffff8010ec7b>{child_rip+8} <ffffffff8015abf0>{kswapd+0}                                                                   <ffffffff8010ec73>{child_rip+0}

Code: 0f 0b be 5b 2d 80 ff ff ff ff 58 01 41 83 ea 06 41 ff cb 75
RIP <ffffffff801cd5f9>{radix_tree_tag_set+121} RSP <ffff81003f4b3950>

-- 
 ///  Stephane Jourdois     /"\  ASCII RIBBON CAMPAIGN \\\
(((    Consultant securite  \ /    AGAINST HTML MAIL    )))
 \\\   24 rue Cauchy         X                         ///
  \\\  75015  Paris         / \    +33 6 8643 3085    ///
