Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269302AbVBENKq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269302AbVBENKq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 08:10:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269339AbVBENKq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 08:10:46 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:9129 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S269302AbVBENKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 08:10:36 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.11-rc3-mm1: softlockup and suspend/resume
Date: Sat, 5 Feb 2005 14:11:15 +0100
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Pavel Machek <pavel@suse.cz>
References: <20050204103350.241a907a.akpm@osdl.org>
In-Reply-To: <20050204103350.241a907a.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200502051411.16194.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

It looks like softlockup is not happy with suspend/resume:

Feb  5 02:16:06 albercik kernel: BUG: soft lockup detected on CPU#0!
Feb  5 02:16:06 albercik kernel:
Feb  5 02:16:06 albercik kernel: Modules linked in: snd_seq snd_seq_device usbserial parport_pc lp parport thermal processor fan button battery
ac snd_pcm_oss snd_mixer_oss snd_intel8x0 snd_ac97_codec snd_pcm snd_timer snd soundcore snd_page_alloc ipt_TOS ipt_LOG ipt_limit ipt_pkttype af
_packet ipt_state ipt_REJECT iptable_mangle iptable_filter ip6table_mangle ip_nat_ftp iptable_nat ip_conntrack_ftp ip_conntrack ip_tables ip6tab
le_filter ip6_tables ipv6 pcmcia binfmt_misc joydev sg st sd_mod sr_mod scsi_mod ide_cd cdrom ohci1394 yenta_socket rsrc_nonstatic pcmcia_core i
eee1394 sk98lin i2c_nforce2 i2c_core usbhid ehci_hcd ohci_hcd evdev dm_mod
Feb  5 02:16:09 albercik kernel: Pid: 8680, comm: do_acpi_sleep Not tainted 2.6.11-rc3-mm1
Feb  5 02:16:12 albercik kernel: RIP: 0010:[<ffffffff80164534>] <ffffffff80164534>{swsusp_suspend+52}
Feb  5 02:16:13 albercik kernel: RSP: 0000:ffff81000d51de38  EFLAGS: 00000292
Feb  5 02:16:18 albercik kernel: RAX: 0000000000000000 RBX: ffffffff80427fc0 RCX: ffffffff803f263e
Feb  5 02:16:20 albercik kernel: RDX: ffffffff80499290 RSI: 00000000000002e9 RDI: 0000000000200000
Feb  5 02:16:21 albercik kernel: RBP: ffffffff803f4e5f R08: ffffffff803f259d R09: 0000000000000000
Feb  5 02:16:23 albercik kernel: R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff803f4fe0
Feb  5 02:16:25 albercik kernel: R13: ffffffff00400000 R14: ffffffff802c0946 R15: 0000000000000000
Feb  5 02:16:27 albercik kernel: FS:  00002aaaab28b800(0000) GS:ffffffff80565800(0000) knlGS:0000000000000000
Feb  5 02:16:27 albercik kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
Feb  5 02:16:27 albercik kernel: CR2: 00002aaaaac4e642 CR3: 000000000d4f5000 CR4: 00000000000006e0
Feb  5 02:16:27 albercik kernel:
Feb  5 02:16:28 albercik kernel: Call Trace:<ffffffff80164531>{swsusp_suspend+49} <ffffffff8016541a>{pm_suspend_disk+90}
Feb  5 02:16:28 albercik kernel:        <ffffffff80162f96>{enter_state+70} <ffffffff8016314d>{state_store+109}
Feb  5 02:16:28 albercik kernel:        <ffffffff801ececf>{subsys_attr_store+31} <ffffffff801ed3d1>{sysfs_write_file+209}
Feb  5 02:16:29 albercik kernel:        <ffffffff8019ac29>{vfs_write+233} <ffffffff8019adc3>{sys_write+83}
Feb  5 02:16:29 albercik kernel:        <ffffffff8010ebf2>{system_call+126}

Would it be possible to make it relax here?

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
