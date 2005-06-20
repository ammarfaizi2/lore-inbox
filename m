Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261707AbVFTVza@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261707AbVFTVza (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 17:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261704AbVFTVue
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 17:50:34 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:63948 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261548AbVFTVtB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 17:49:01 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: dipankar@in.ibm.com
Subject: Re: 2.6.12-mm1 (kernel BUG at fs/open.c:935!)
Date: Mon, 20 Jun 2005 23:48:29 +0200
User-Agent: KMail/1.8.1
Cc: jan malstrom <xanon@snacksy.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
References: <42B6BEC2.405@snacksy.com> <200506202318.37930.rjw@sisk.pl> <20050620212217.GD4562@in.ibm.com>
In-Reply-To: <20050620212217.GD4562@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506202348.30173.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 20 of June 2005 23:22, Dipankar Sarma wrote:
> On Mon, Jun 20, 2005 at 11:18:37PM +0200, Rafael J. Wysocki wrote:
> > Hi,
> > 
> > On Monday, 20 of June 2005 22:21, Dipankar Sarma wrote:
> > > On Mon, Jun 20, 2005 at 03:04:02PM +0200, jan malstrom wrote:
> > > > right at booting:
> > > > 
> > > > 
> > > > Jun 20 14:38:07 hades kernel: kernel BUG at fs/open.c:935!
> > > > Jun 20 14:38:07 hades kernel: invalid operand: 0000 [#1]
> > > > Jun 20 14:38:07 hades kernel: PREEMPT
> > > > Jun 20 14:38:07 hades kernel: Modules linked in: ipw2100 i2c_i801
> > > > Jun 20 14:38:07 hades kernel: CPU:    0
> > > > Jun 20 14:38:07 hades kernel: EIP:    0060:[fd_install+309/400]    Not 
> > > > tainted VLI
> > > 
> > > Can you try the following patch and let me know if it fixes any
> > > of your problems ?
> > 
> > No, it doesn't.
> 
> Does it always happen with kded and always on reiser4 or does it happen
> with other FS ? I tested with Jan's .config and couldn't reproduce it
> in my P4 box. What exactly are you running in your machine ?

Apparently, it happens with resiserfs, but it is not reiser4.  It always happens at KDE 3.4.1 startup,
on SuSE 9.3 /AMD64, with various components of KDE.  The full log follows (from the kernel
without your patch, but there's no difference).

Greets,
Rafael


----------- [cut here ] --------- [please bite here ] ---------
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
----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at "fs/open.c":935
invalid operand: 0000 [2] PREEMPT 
CPU 0 
Modules linked in: usbserial thermal processor fan button battery ac snd_pcm_oss snd_mixer_oss snd_intel8x0 snd_ac97_codec snd_pcm snd_timer snd soundcore snd_page_alloc ipt_LOG ipt_limit ipt_pkttype ipt_state ipt_REJECT iptable_mangle iptable_filter ip6table_mangle ip_nat_ftp iptable_nat ip_conntrack_ftp ip_conntrack ip_tables ip6table_filter ip6_tables ipv6 af_packet pcmcia firmware_class yenta_socket rsrc_nonstatic pcmcia_core usbhid ehci_hcd ohci_hcd sk98lin evdev joydev sg st sr_mod sd_mod scsi_mod ide_cd cdrom dm_mod parport_pc lp parport
Pid: 4305, comm: kicker Not tainted 2.6.12-mm1
RIP: 0010:[<ffffffff801a14fb>] <ffffffff801a14fb>{fd_install+187}
RSP: 0018:ffff81001d64fed8  EFLAGS: 00010282
RAX: ffff81002cbb4b10 RBX: ffff81002704a0f8 RCX: 0000000000000080
RDX: ffff8100294b1bb0 RSI: ffff81001c716568 RDI: 0000000000000001
RBP: 0000000000000080 R08: 0000000000000000 R09: 0000000000000000
R10: ffff81002cb83000 R11: 0000000000000246 R12: ffff81001c716568
R13: 0000000000000080 R14: 0000000000000080 R15: ffff8100294b1bb0
FS:  00002aaaae576d20(0000) GS:ffffffff80588840(0000) knlGS:0000000056abc320
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00002aaaaaf8aaa0 CR3: 000000001dbdf000 CR4: 00000000000006e0
Process kicker (pid: 4305, threadinfo ffff81001d64e000, task ffff810021ab20b0)
Stack: 0000000000000080 ffff81002704a0f8 0000000000000080 0000000000000080 
       ffff81002704a0f8 ffffffff801beb4d ffff81002d98d000 000000000000000d 
       ffff81001c716568 0000000000000000 
Call Trace:<ffffffff801beb4d>{dupfd+589} <ffffffff801bed75>{sys_fcntl+309}
       <ffffffff8010f442>{system_call+126} 

Code: 0f 0b 9f d9 3e 80 ff ff ff ff a7 03 48 8b 42 10 4c 89 24 c8 
RIP <ffffffff801a14fb>{fd_install+187} RSP <ffff81001d64fed8>
 <6>note: kicker[4305] exited with preempt_count 1
scheduling while atomic: kicker/0x10000001/4305

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
scheduling while atomic: kicker/0x10000001/4305

Call Trace:<ffffffff803c82ea>{schedule+122} <ffffffff803c8c3f>{cond_resched+47}
       <ffffffff80189c01>{unmap_vmas+1841} <ffffffff8018e98a>{exit_mmap+298}
       <ffffffff80137203>{mmput+51} <ffffffff8013fe55>{do_exit+437}
       <ffffffff80111125>{die+69} <ffffffff80111ac1>{do_invalid_op+145}
       <ffffffff801a14fb>{fd_install+187} <ffffffff801bc43f>{link_path_walk+367}
       <ffffffff80153383>{in_group_p+67} <ffffffff8017d800>{check_poison_obj+48}
       <ffffffff8017e1a6>{poison_obj+70} <ffffffff8010fd39>{error_exit+0}
       <ffffffff801a14fb>{fd_install+187} <ffffffff801a1467>{fd_install+39}
       <ffffffff801beb4d>{dupfd+589} <ffffffff801bed75>{sys_fcntl+309}
       <ffffffff8010f442>{system_call+126} 
----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at "fs/open.c":935
invalid operand: 0000 [3] PREEMPT 
CPU 0 
Modules linked in: usbserial thermal processor fan button battery ac snd_pcm_oss snd_mixer_oss snd_intel8x0 snd_ac97_codec snd_pcm snd_timer snd soundcore snd_page_alloc ipt_LOG ipt_limit ipt_pkttype ipt_state ipt_REJECT iptable_mangle iptable_filter ip6table_mangle ip_nat_ftp iptable_nat ip_conntrack_ftp ip_conntrack ip_tables ip6table_filter ip6_tables ipv6 af_packet pcmcia firmware_class yenta_socket rsrc_nonstatic pcmcia_core usbhid ehci_hcd ohci_hcd sk98lin evdev joydev sg st sr_mod sd_mod scsi_mod ide_cd cdrom dm_mod parport_pc lp parport
Pid: 4300, comm: kdesktop Not tainted 2.6.12-mm1
RIP: 0010:[<ffffffff801a14fb>] <ffffffff801a14fb>{fd_install+187}
RSP: 0018:ffff81001dcdfed8  EFLAGS: 00010286
RAX: ffff81002c31c6f8 RBX: ffff810001dfc458 RCX: 0000000000000080
RDX: ffff810028475068 RSI: ffff81001c716e60 RDI: 0000000000000001
RBP: 0000000000000080 R08: 0000000000000000 R09: 0000000000000000
R10: ffff81002cb12000 R11: 0000000000000246 R12: ffff81001c716e60
R13: 0000000000000080 R14: 0000000000000080 R15: ffff810028475068
FS:  00002aaaae576d20(0000) GS:ffffffff80588840(0000) knlGS:0000000056abc320
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00002aaaae5ea0f6 CR3: 000000001e3b0000 CR4: 00000000000006e0
Process kdesktop (pid: 4300, threadinfo ffff81001dcde000, task ffff81001e3af810)
Stack: 0000000000000080 ffff810001dfc458 0000000000000080 0000000000000080 
       ffff810001dfc458 ffffffff801beb4d ffff81002d997000 000000000000000e 
       ffff81001c716e60 0000000000000000 
Call Trace:<ffffffff801beb4d>{dupfd+589} <ffffffff801bed75>{sys_fcntl+309}
       <ffffffff8010f442>{system_call+126} 

Code: 0f 0b 9f d9 3e 80 ff ff ff ff a7 03 48 8b 42 10 4c 89 24 c8 
RIP <ffffffff801a14fb>{fd_install+187} RSP <ffff81001dcdfed8>
 <6>note: kdesktop[4300] exited with preempt_count 1
scheduling while atomic: kdesktop/0x10000001/4300

Call Trace:<ffffffff803c82ea>{schedule+122} <ffffffff8013a875>{release_console_sem+693}
       <ffffffff8013a94d>{release_console_sem+909} <ffffffff803c8c3f>{cond_resched+47}
       <ffffffff80189c01>{unmap_vmas+1841} <ffffffff8018e98a>{exit_mmap+298}
       <ffffffff80137203>{mmput+51} <ffffffff8013fe55>{do_exit+437}
       <ffffffff80111125>{die+69} <ffffffff80111ac1>{do_invalid_op+145}
       <ffffffff801a14fb>{fd_install+187} <ffffffff801bc43f>{link_path_walk+367}
       <ffffffff8017d800>{check_poison_obj+48} <ffffffff8017e1a6>{poison_obj+70}
       <ffffffff8010fd39>{error_exit+0} <ffffffff801a14fb>{fd_install+187}
       <ffffffff801a1467>{fd_install+39} <ffffffff801beb4d>{dupfd+589}
       <ffffffff801bed75>{sys_fcntl+309} <ffffffff8010f442>{system_call+126}
       
----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at "fs/open.c":935
invalid operand: 0000 [4] PREEMPT 
CPU 0 
Modules linked in: usbserial thermal processor fan button battery ac snd_pcm_oss snd_mixer_oss snd_intel8x0 snd_ac97_codec snd_pcm snd_timer snd soundcore snd_page_alloc ipt_LOG ipt_limit ipt_pkttype ipt_state ipt_REJECT iptable_mangle iptable_filter ip6table_mangle ip_nat_ftp iptable_nat ip_conntrack_ftp ip_conntrack ip_tables ip6table_filter ip6_tables ipv6 af_packet pcmcia firmware_class yenta_socket rsrc_nonstatic pcmcia_core usbhid ehci_hcd ohci_hcd sk98lin evdev joydev sg st sr_mod sd_mod scsi_mod ide_cd cdrom dm_mod parport_pc lp parport
Pid: 4499, comm: kded Not tainted 2.6.12-mm1
RIP: 0010:[<ffffffff801a14fb>] <ffffffff801a14fb>{fd_install+187}
RSP: 0018:ffff81001bb25ed8  EFLAGS: 00010282
RAX: ffff81002c87e738 RBX: ffff810001c58038 RCX: 0000000000000080
RDX: ffff81002846e528 RSI: ffff810029264bd0 RDI: 0000000000000001
RBP: 0000000000000080 R08: 0000000000000000 R09: 0000000000000000
R10: ffff81002c3a9000 R11: 0000000000000246 R12: ffff810029264bd0
R13: 0000000000000080 R14: 0000000000000080 R15: ffff81002846e528
FS:  00002aaaae576d20(0000) GS:ffffffff80588840(0000) knlGS:0000000056abc320
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00002aaaaae75b88 CR3: 000000001ba04000 CR4: 00000000000006e0
Process kded (pid: 4499, threadinfo ffff81001bb24000, task ffff810001ed2790)
Stack: 0000000000000080 ffff810001c58038 0000000000000080 0000000000000080 
       ffff810001c58038 ffffffff801beb4d ffff81002d997000 000000000000000c 
       ffff810029264bd0 0000000000000000 
Call Trace:<ffffffff801beb4d>{dupfd+589} <ffffffff801bed75>{sys_fcntl+309}
       <ffffffff8010f442>{system_call+126} 

Code: 0f 0b 9f d9 3e 80 ff ff ff ff a7 03 48 8b 42 10 4c 89 24 c8 
RIP <ffffffff801a14fb>{fd_install+187} RSP <ffff81001bb25ed8>
 <6>note: kded[4499] exited with preempt_count 1
scheduling while atomic: kded/0x10000001/4499

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
----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at "fs/open.c":935
invalid operand: 0000 [5] PREEMPT 
CPU 0 
Modules linked in: usbserial thermal processor fan button battery ac snd_pcm_oss snd_mixer_oss snd_intel8x0 snd_ac97_codec snd_pcm snd_timer snd soundcore snd_page_alloc ipt_LOG ipt_limit ipt_pkttype ipt_state ipt_REJECT iptable_mangle iptable_filter ip6table_mangle ip_nat_ftp iptable_nat ip_conntrack_ftp ip_conntrack ip_tables ip6table_filter ip6_tables ipv6 af_packet pcmcia firmware_class yenta_socket rsrc_nonstatic pcmcia_core usbhid ehci_hcd ohci_hcd sk98lin evdev joydev sg st sr_mod sd_mod scsi_mod ide_cd cdrom dm_mod parport_pc lp parport
Pid: 4532, comm: kicker Not tainted 2.6.12-mm1
RIP: 0010:[<ffffffff801a14fb>] <ffffffff801a14fb>{fd_install+187}
RSP: 0018:ffff810027981ed8  EFLAGS: 00010282
RAX: ffff81002729ab50 RBX: ffff81002fda7418 RCX: 0000000000000080
RDX: ffff810001dcf360 RSI: ffff81001ae272d8 RDI: 0000000000000001
RBP: 0000000000000080 R08: 0000000000000000 R09: 0000000000000000
R10: ffff81002bbaf000 R11: 0000000000000246 R12: ffff81001ae272d8
R13: 0000000000000080 R14: 0000000000000080 R15: ffff810001dcf360
FS:  00002aaaae576d20(0000) GS:ffffffff80588840(0000) knlGS:0000000056abc320
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00002aaaaaf8aaa0 CR3: 0000000027933000 CR4: 00000000000006e0
Process kicker (pid: 4532, threadinfo ffff810027980000, task ffff81001ce5d070)
Stack: 0000000000000080 ffff81002fda7418 0000000000000080 0000000000000080 
       ffff81002fda7418 ffffffff801beb4d ffff81002d997000 000000000000000d 
       ffff81001ae272d8 0000000000000000 
Call Trace:<ffffffff801beb4d>{dupfd+589} <ffffffff801bed75>{sys_fcntl+309}
       <ffffffff8010f442>{system_call+126} 

Code: 0f 0b 9f d9 3e 80 ff ff ff ff a7 03 48 8b 42 10 4c 89 24 c8 
RIP <ffffffff801a14fb>{fd_install+187} RSP <ffff810027981ed8>
 <6>note: kicker[4532] exited with preempt_count 1
scheduling while atomic: kicker/0x10000001/4532

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
scheduling while atomic: kicker/0x10000001/4532

Call Trace:<ffffffff803c82ea>{schedule+122} <ffffffff803c8c3f>{cond_resched+47}
       <ffffffff80189c01>{unmap_vmas+1841} <ffffffff8018e98a>{exit_mmap+298}
       <ffffffff80137203>{mmput+51} <ffffffff8013fe55>{do_exit+437}
       <ffffffff80111125>{die+69} <ffffffff80111ac1>{do_invalid_op+145}
       <ffffffff801a14fb>{fd_install+187} <ffffffff801bc43f>{link_path_walk+367}
       <ffffffff80153383>{in_group_p+67} <ffffffff8017d800>{check_poison_obj+48}
       <ffffffff8017e1a6>{poison_obj+70} <ffffffff8010fd39>{error_exit+0}
       <ffffffff801a14fb>{fd_install+187} <ffffffff801a1467>{fd_install+39}
       <ffffffff801beb4d>{dupfd+589} <ffffffff801bed75>{sys_fcntl+309}
       <ffffffff8010f442>{system_call+126} 



-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
