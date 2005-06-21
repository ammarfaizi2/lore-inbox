Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261317AbVFULzQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261317AbVFULzQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 07:55:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261280AbVFULtE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 07:49:04 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:57317 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261199AbVFUL3B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 07:29:01 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: dipankar@in.ibm.com
Subject: Re: 2.6.12-mm1 (kernel BUG at fs/open.c:935!)
Date: Tue, 21 Jun 2005 13:29:01 +0200
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
Message-Id: <200506211329.01712.rjw@sisk.pl>
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

BTW, it happens with CONFIG_PREEMPT_NONE too.  The log follows.

Greets,
Rafael


Kernel BUG at "fs/open.c":935
invalid operand: 0000 [1] 
CPU 0 
Modules linked in: usbserial thermal processor fan button battery ac snd_pcm_oss snd_mixer_oss snd_intel8x0 snd_ac97_codec snd_pcm snd_timer snd soundcore snd_page_alloc ipt_LOG ipt_limit ipt_pkttype ipt_state ipt_REJECT iptable_mangle iptable_filter ip6table_mangle ip_nat_ftp iptable_nat ip_conntrack_ftp ip_conntrack ip_tables ip6table_filter ip6_tables ipv6 af_packet pcmcia firmware_class yenta_socket rsrc_nonstatic pcmcia_core usbhid evdev joydev sg ehci_hcd st sr_mod ohci_hcd sk98lin sd_mod scsi_mod ide_cd cdrom dm_mod parport_pc lp parport
Pid: 4191, comm: kded Not tainted 2.6.12-mm1
RIP: 0010:[<ffffffff801992a8>] <ffffffff801992a8>{fd_install+184}
RSP: 0018:ffff810021fc1ed8  EFLAGS: 00010286
RAX: ffff81002c9110e8 RBX: ffff81002fca8418 RCX: 0000000000000080
RDX: ffff8100287ded78 RSI: ffff810021b12420 RDI: 0000000000000080
RBP: 0000000000000080 R08: 0000000000000080 R09: 0000000000000000
R10: ffff81002cf79000 R11: 0000000000000246 R12: ffff810021b12420
R13: 0000000000000080 R14: 0000000000000080 R15: ffff8100287ded78
FS:  00002aaaae576d20(0000) GS:ffffffff80567840(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00002aaaaae75b88 CR3: 0000000021fb5000 CR4: 00000000000006e0
Process kded (pid: 4191, threadinfo ffff810021fc0000, task ffff81002cf88850)
Stack: 0000000000000080 ffff81002fca8418 0000000000000080 0000000000000080 
       ffff81002fca8418 ffffffff801b44e6 ffff81002d83e000 000000000000000c 
       ffff810021b12420 0000000000000000 
Call Trace:<ffffffff801b44e6>{dupfd+534} <ffffffff801b46f5>{sys_fcntl+309}
       <ffffffff8010f202>{system_call+126} 

Code: 0f 0b cf d2 3c 80 ff ff ff ff a7 03 48 8b 42 10 4c 89 24 c8 
RIP <ffffffff801992a8>{fd_install+184} RSP <ffff810021fc1ed8>
 ----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at "fs/open.c":935
invalid operand: 0000 [2] 
CPU 0 
Modules linked in: usbserial thermal processor fan button battery ac snd_pcm_oss snd_mixer_oss snd_intel8x0 snd_ac97_codec snd_pcm snd_timer snd soundcore snd_page_alloc ipt_LOG ipt_limit ipt_pkttype ipt_state ipt_REJECT iptable_mangle iptable_filter ip6table_mangle ip_nat_ftp iptable_nat ip_conntrack_ftp ip_conntrack ip_tables ip6table_filter ip6_tables ipv6 af_packet pcmcia firmware_class yenta_socket rsrc_nonstatic pcmcia_core usbhid evdev joydev sg ehci_hcd st sr_mod ohci_hcd sk98lin sd_mod scsi_mod ide_cd cdrom dm_mod parport_pc lp parport
Pid: 4227, comm: kicker Not tainted 2.6.12-mm1
RIP: 0010:[<ffffffff801992a8>] <ffffffff801992a8>{fd_install+184}
RSP: 0018:ffff81001d603ed8  EFLAGS: 00010282
RAX: ffff81002b95b5a8 RBX: ffff81002ce7c4d8 RCX: 0000000000000080
RDX: ffff8100287de6f0 RSI: ffff81001cc336b0 RDI: 0000000000000080
RBP: 0000000000000080 R08: 0000000000000080 R09: 0000000000000000
R10: ffff81002bc2a000 R11: 0000000000000246 R12: ffff81001cc336b0
R13: 0000000000000080 R14: 0000000000000080 R15: ffff8100287de6f0
FS:  00002aaaae576d20(0000) GS:ffffffff80567840(0000) knlGS:0000000056abc320
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00002aaaaaf8aaa0 CR3: 000000001d510000 CR4: 00000000000006e0
Process kicker (pid: 4227, threadinfo ffff81001d602000, task ffff810021a69070)
Stack: 0000000000000080 ffff81002ce7c4d8 0000000000000080 0000000000000080 
       ffff81002ce7c4d8 ffffffff801b44e6 ffff81002d8ab000 000000000000000d 
       ffff81001cc336b0 0000000000000000 
Call Trace:<ffffffff801b44e6>{dupfd+534} <ffffffff801b46f5>{sys_fcntl+309}
       <ffffffff8010f202>{system_call+126} 

Code: 0f 0b cf d2 3c 80 ff ff ff ff a7 03 48 8b 42 10 4c 89 24 c8 
RIP <ffffffff801992a8>{fd_install+184} RSP <ffff81001d603ed8>
 


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
