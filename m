Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262356AbVAOXLD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262356AbVAOXLD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 18:11:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262358AbVAOXLD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 18:11:03 -0500
Received: from astro.systems.pipex.net ([62.241.163.6]:15046 "EHLO
	astro.systems.pipex.net") by vger.kernel.org with ESMTP
	id S262356AbVAOXKt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 18:10:49 -0500
From: Rob Walker <rob@tenfoot.org.uk>
To: linux-kernel@vger.kernel.org
Subject: OOPS in kjournald on 2.6.10
Date: Sat, 15 Jan 2005 23:10:55 +0000
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501152310.55535.rob@tenfoot.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've just had an oops with kjournald on a stock 2.6.10 kernel.  
I'm running ext3 and reiserfs3 filesystems, but most of the load was on an 
ext3 fs at the time of the oops.  The backtrace is:

Jan 15 22:45:32 linchpin kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000108
Jan 15 22:45:32 linchpin kernel:  printing eip:
Jan 15 22:45:32 linchpin kernel: c012d88f
Jan 15 22:45:32 linchpin kernel: *pde = 00000000
Jan 15 22:45:32 linchpin kernel: Oops: 0000 [#1]
Jan 15 22:45:32 linchpin kernel: PREEMPT
Jan 15 22:45:32 linchpin kernel: Modules linked in: lp mga ipv6 ipt_TOS 
ipt_MASQUERADE ipt_REJECT ipt_pkttype ipt_LOG ipt_TCPMSS ipt_state 
ipt_multiport ipt_conntrack iptable_mangle ip_nat_irc ip_nat_tftp ip_nat_ftp 
iptable_nat ip_conntrack_irc ip_conntrack_tftp ip_conntrack_ftp ip_conntrack 
iptable_filter ip_tables 8139too mii snd_via82xx snd_ac97_codec 
snd_mpu401_uart snd_rawmidi snd_seq_device ehci_hcd uhci_hcd usbcore snd_bt87x
snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore snd_page_alloc tuner
 tvaudio bttv video_buf firmware_class i2c_algo_bit v4l2_common btcx_risc videodev
 via_agp agpgart parport_pc parport pcspkr rtc nls_iso8859_1 nls_cp850 vfat 
fat ext3 jbd mbcache it87 lm90 i2c_sensor i2c_isa i2c_viapro i2c_core 
ppp_generic slhc evdev mousedev loop psmouse ide_floppy ide_cd cdrom 
unixreiserfs ide_disk ide_generic via82cxxx ide_core
Jan 15 22:45:32 linchpin kernel: CPU:    0
Jan 15 22:45:32 linchpin kernel: EIP:    0060:[bit_waitqueue+47/96]    Not tainted VLI
Jan 15 22:45:32 linchpin kernel: EFLAGS: 00010213   (2.6.10)
Jan 15 22:45:32 linchpin kernel: EIP is at bit_waitqueue+0x2f/0x60
Jan 15 22:45:32 linchpin kernel: eax: 4a929982   ebx: 00000000   ecx: 00000020   edx: 00000002
Jan 15 22:45:32 linchpin kernel: esi: 00000002   edi: c76bbf2c   ebp: c0154880   esp: cfce7d78
Jan 15 22:45:32 linchpin kernel: ds: 007b   es: 007b   ss: 0068
Jan 15 22:45:32 linchpin kernel: Process kjournald (pid: 2410, threadinfo=cfce6000 task=cfc10080)
Jan 15 22:45:32 linchpin kernel: Stack: 089d24cc c0287ab2 c7ebba7c c013e843 cfaee410 cfaee500 000000f0 0000003c
Jan 15 22:45:32 linchpin kernel:        cfaee400 00000296 c7ebba7c c5c71260 00000296 d29ffea6 cb74586c cfce6000
Jan 15 22:45:32 linchpin kernel:        cfce6000 c7ebbf5c 00000000 c5c71278 089d24cc cfce6000 c76bbf2c c5c71260
Jan 15 22:45:32 linchpin kernel: Call Trace:
Jan 15 22:45:32 linchpin kernel:  [out_of_line_wait_on_bit+18/160] out_of_line_wait_on_bit+0x12/0xa0
Jan 15 22:45:32 linchpin kernel:  [cache_flusharray+131/240] cache_flusharray+0x83/0xf0
Jan 15 22:45:32 linchpin kernel:  [pg0+308752038/1070011392] __journal_remove_journal_head+0xb6/0x190 [jbd]
Jan 15 22:45:32 linchpin kernel:  [pg0+308730929/1070011392] journal_commit_transaction+0x331/0x11c0 [jbd]
Jan 15 22:45:32 linchpin kernel:  [__alloc_pages+458/864] __alloc_pages+0x1ca/0x360
Jan 15 22:45:32 linchpin kernel:  [find_get_page+45/96] find_get_page+0x2d/0x60
Jan 15 22:45:32 linchpin kernel:  [filemap_nopage+506/880] filemap_nopage+0x1fa/0x370
Jan 15 22:45:32 linchpin kernel:  [schedule+753/1328] schedule+0x2f1/0x530
Jan 15 22:45:32 linchpin kernel:  [pg0+308743542/1070011392] kjournald+0xd6/0x260 [jbd]
Jan 15 22:45:32 linchpin kernel:  [autoremove_wake_function+0/96] autoremove_wake_function+0x0/0x60
Jan 15 22:45:32 linchpin kernel:  [autoremove_wake_function+0/96] autoremove_wake_function+0x0/0x60
Jan 15 22:45:32 linchpin kernel:  [ret_from_fork+6/20] ret_from_fork+0x6/0x14
Jan 15 22:45:32 linchpin kernel:  [pg0+308743296/1070011392] commit_timeout+0x0/0x10 [jbd]
Jan 15 22:45:32 linchpin kernel:  [pg0+308743328/1070011392] kjournald+0x0/0x260 [jbd]
Jan 15 22:45:32 linchpin kernel:  [kernel_thread_helper+5/20] kernel_thread_helper+0x5/0x14
Jan 15 22:45:32 linchpin kernel: Code: 00 40 53 c1 e0 05 c1 e9 0c 09 d0 c1 e1 05 03 0d 10 26 37 c0 69 c0 01 00 37 9e 8b 09 c1 e9 1d 8b 1c 8d dc 23 37 c0 b9 20 00 00 00 <2b> 8b 08 01 00 00 8b 93 00 01 00 00 5b d3 e8 8d 04 c2 c3 90 90


Rob

-- 
Rob Walker <rob@tenfoot.org.uk>
http://www.tenfoot.org.uk
