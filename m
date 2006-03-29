Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751279AbWC2Xi6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279AbWC2Xi6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 18:38:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751280AbWC2Xi6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 18:38:58 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:3724 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751279AbWC2Xi5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 18:38:57 -0500
Subject: Re: kernel: BUG: soft lockup detected on CPU#0!
From: Lee Revell <rlrevell@joe-job.com>
To: Paul Risenhoover <prisenhoover@daxsolutions.com>
Cc: Jussi Hamalainen <count@theblah.fi>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <442AEF2B.2000506@daxsolutions.com>
References: <4429A027.1010509@daxsolutions.com>
	 <Pine.LNX.4.62.0603290748240.22034@mir.senvnet.fi>
	 <442AEF2B.2000506@daxsolutions.com>
Content-Type: text/plain
Date: Wed, 29 Mar 2006 18:38:49 -0500
Message-Id: <1143675530.15145.3.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-29 at 12:33 -0800, Paul Risenhoover wrote:
> Thanks for the info Jussi, and I will definitely try that, but I don't 
> understand why the stack trace shows a pile of smbfs calls, and how that 
> might relate to the USB controller.  But then again, maybe that's why 
> I'm not a kernel developer.
> 

Here's the non-wrapped version, which should be much easier to read.  I
don't think it's related to the USB controller.

Mar 28 08:10:07 xenon kernel: BUG: soft lockup detected on CPU#0!
Mar 28 08:10:07 xenon kernel: 
Mar 28 08:10:07 xenon kernel: Modules linked in: smbfs md5 ipv6 parport_pc lp parport autofs4 i2c_dev i2c_core rfcomm l2cap bluetooth sunrpc pcmcia yenta_socket rsrc_nonstatic pcmcia_core video button battery ac uhci_hcd ehci_hcd shpchp e1000 dm_snapshot dm_zero dm_mirror ext3 jbd dm_mod ata_piix libata sd_mod scsi_mod
Mar 28 08:10:07 xenon kernel: Pid: 2601, comm: smbiod Not tainted 2.6.11-1.1369_FC4
Mar 28 08:10:07 xenon kernel: RIP: 0010:[<ffffffff80349754>] <ffffffff80349754>{skb_copy_datagram_iovec+52}
Mar 28 08:10:07 xenon kernel: RSP: 0018:ffff810073219b58  EFLAGS: 00000206
Mar 28 08:10:07 xenon kernel: RAX: ffff810073219e08 RBX: 0000000000000003 RCX: 0000000000000000
Mar 28 08:10:07 xenon kernel: RDX: ffff810073219e48 RSI: 00000000000000c5 RDI: ffff81005ddbb380
Mar 28 08:10:07 xenon kernel: RBP: 00000000000000c5 R08: 0000000000000000 R09: 0000000000004000
Mar 28 08:10:07 xenon kernel: R10: ffffffff804cc7e0 R11: 0000000000000048 R12: 00000000000000c8
Mar 28 08:18:10 xenon kernel: R13: ffff810064a72160 R14: 00000000000000c5 R15: 0000000000000000
Mar 28 08:18:10 xenon kernel: FS:  00002aaaaadfc6e0(0000) GS:ffffffff80576c00(0000) knlGS:0000000000000000
Mar 28 08:18:10 xenon kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
Mar 28 08:22:11 xenon kernel: CR2: 00002aaaaaaac000 CR3: 000000003e11c000 CR4: 00000000000006e0
Mar 28 08:22:11 xenon kernel: 
Mar 28 08:22:11 xenon kernel: Call Trace:<ffffffff8037a148>{tcp_recvmsg+1320} <ffffffff80343df3>{sock_common_recvmsg+51}
Mar 28 08:22:11 xenon kernel:        <ffffffff80343210>{sock_recvmsg+304} <ffffffff8015cad0>{autoremove_wake_function+0}
Mar 28 08:22:11 xenon kernel:        <ffffffff8034468f>{lock_sock+783} <ffffffff803439fb>{kernel_recvmsg+59}
Mar 28 08:22:11 xenon kernel:        <ffffffff8821face>{:smbfs:smb_receive_drop+158} <ffffffff8039b2a7>{inet_ioctl+167}
Mar 28 08:22:11 xenon kernel:        <ffffffff88222896>{:smbfs:smb_request_recv+86} <ffffffff8039b2a7>{inet_ioctl+167}
Mar 28 08:22:11 xenon kernel:        <ffffffff882224c8>{:smbfs:smbiod+1080} <ffffffff8015cad0>{autoremove_wake_function+0}
Mar 28 08:22:11 xenon kernel:        <ffffffff8010fc33>{child_rip+8} <ffffffff88222090>{:smbfs:smbiod+0}
Mar 28 08:22:11 xenon kernel:        <ffffffff8010fc2b>{child_rip+0} 
Mar 28 08:22:11 xenon kernel: 
Mar 28 08:22:11 xenon kernel: Call Trace: <IRQ> <ffffffff8017012d>{softlockup_tick+285} <ffffffff80113fc1>{timer_interrupt+913}
Mar 28 08:22:11 xenon kernel:        <ffffffff801703ec>{handle_IRQ_event+44} <ffffffff801705fd>{__do_IRQ+477}
Mar 28 08:22:11 xenon kernel:        <ffffffff8013c54e>{profile_tick+78} <ffffffff801120b8>{do_IRQ+72}
Mar 28 08:22:11 xenon kernel:        <ffffffff8010f6c3>{ret_from_intr+0}  <EOI> <ffffffff80349754>{skb_copy_datagram_iovec+52}
Mar 28 08:22:11 xenon kernel:        <ffffffff8037a148>{tcp_recvmsg+1320} <ffffffff80343df3>{sock_common_recvmsg+51}
Mar 28 08:22:11 xenon kernel:        <ffffffff80343210>{sock_recvmsg+304} <ffffffff8015cad0>{autoremove_wake_function+0}
Mar 28 08:22:11 xenon kernel:        <ffffffff8034468f>{lock_sock+783} <ffffffff803439fb>{kernel_recvmsg+59}
Mar 28 08:22:11 xenon kernel:        <ffffffff8821face>{:smbfs:smb_receive_drop+158} <ffffffff8039b2a7>{inet_ioctl+167}
Mar 28 08:22:11 xenon kernel:        <ffffffff88222896>{:smbfs:smb_request_recv+86} <ffffffff8039b2a7>{inet_ioctl+167}
Mar 28 08:24:12 xenon kernel:        <ffffffff882224c8>{:smbfs:smbiod+1080} <ffffffff8015cad0>{autoremove_wake_function+0}
Mar 28 08:24:12 xenon kernel:        <ffffffff8010fc33>{child_rip+8} <ffffffff88222090>{:smbfs:smbiod+0}
Mar 28 08:24:12 xenon kernel:        <ffffffff8010fc2b>{child_rip+0} 



