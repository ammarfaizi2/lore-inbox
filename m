Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964945AbWHHPMP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964945AbWHHPMP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 11:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964946AbWHHPMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 11:12:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:34691 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964945AbWHHPMN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 11:12:13 -0400
Date: Tue, 8 Aug 2006 08:12:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: Re: 2.6.18-rc3-mm2: reiserfs problem?
Message-Id: <20060808081200.5bcba3f3.akpm@osdl.org>
In-Reply-To: <200608081639.38245.rjw@sisk.pl>
References: <20060806030809.2cfb0b1e.akpm@osdl.org>
	<200608081639.38245.rjw@sisk.pl>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Aug 2006 16:39:38 +0200
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> Hi,
> 
> I get something like the appended on every attempt to unmount the reiserfs
> filesystem mounted on /tmp.  The other reiserfs filesystems don't have such
> problems and this one didn't have them too with 2.6.18-rc2-mm1.
> 
> 
> BUG: Dentry ffff810037c573e8{i=3,n=.reiserfs_priv} still in use (1) [unmount of reiserfs hdc7]
> ----------- [cut here ] --------- [please bite here ] ---------
> Kernel BUG at fs/dcache.c:611
> invalid opcode: 0000 [1] PREEMPT
> last sysfs file: /devices/pci0000:00/0000:00:00.0/irq
> CPU 0
> Modules linked in: ide_cd cdrom xt_pkttype ipt_LOG xt_limit usbserial asus_acpi thermal processor fan button battery ac snd_pcm_oss snd_mix
> er_oss snd_seq snd_seq_device af_packet bcm43xx ieee80211softmac ieee80211 ieee80211_crypt pcmcia firmware_class ohci1394 ieee1394 skge yen
> ta_socket rsrc_nonstatic pcmcia_core usbhid ff_memless ip6t_REJECT xt_tcpudp ipt_REJECT xt_state snd_intel8x0 snd_ac97_codec snd_ac97_bus s
> nd_pcm snd_timer snd iptable_mangle soundcore iptable_nat ip_nat iptable_filter snd_page_alloc ip6table_mangle ehci_hcd ip_conntrack i2c_nf
> orce2 i2c_core ip_tables ohci_hcd ip6table_filter ip6_tables x_tables ipv6 parport_pc lp parport dm_mod
> Pid: 9478, comm: umount Not tainted 2.6.18-rc3-mm2 #7
> RIP: 0010:[<ffffffff802a6eb7>]  [<ffffffff802a6eb7>] shrink_dcache_for_umount_subtree+0x1d7/0x2b0

Thanks, Rafael. 
vfs-destroy-the-dentries-contributed-by-a-superblock-on-unmounting.patch
added that BUG_ON().

> RSP: 0018:ffff810059291da8  EFLAGS: 00010296
> RAX: 0000000000000062 RBX: ffff810037c573e8 RCX: 0000000000000003
> RDX: 0000000000000008 RSI: ffff810037c627d8 RDI: 0000000000000001
> RBP: ffff810059291dc8 R08: 0000000000000002 R09: ffffffff8022de59
> R10: 0000000000000000 R11: 0000000000000001 R12: ffff810037c573e8
> R13: ffff81005ddc4800 R14: ffff81005f539250 R15: ffff81005f0a8688
> FS:  00002afc38e00b00(0000) GS:ffffffff808c2000(0000) knlGS:00000000558b4d00
> CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
> CR2: 00002ac8a49a1d40 CR3: 000000005f546000 CR4: 00000000000006e0
> Process umount (pid: 9478, threadinfo ffff810059290000, task ffff810037c62080)
> Stack:  ffff81005f0a8b10 ffff81005f0a8688 ffffffff80577a20 ffff810059291ea8
>  ffff810059291de8 ffffffff802a6fc4 ffff81005f0a8688 ffffffff80577a20
>  ffff810059291e18 ffffffff80293bb4 ffff81005f539250 ffff81005e09d140
> Call Trace:
>  [<ffffffff802a6fc4>] shrink_dcache_for_umount+0x34/0x70
>  [<ffffffff80293bb4>] generic_shutdown_super+0x24/0x110
>  [<ffffffff80293cd0>] kill_block_super+0x30/0x50
>  [<ffffffff80293f81>] deactivate_super+0x81/0xa0
>  [<ffffffff802ac008>] mntput_no_expire+0x58/0xa0
>  [<ffffffff8029b83d>] path_release_on_umount+0x1d/0x30
>  [<ffffffff802ad3f4>] sys_umount+0x274/0x290
>  [<ffffffff80209d0e>] system_call+0x7e/0x83
> DWARF2 unwinder stuck at system_call+0x7e/0x83
> Leftover inexact backtrace:
> 
> 
> Code: 0f 0b 68 41 33 4a 80 c2 63 02 49 8b 5c 24 68 49 39 dc 75 05
> RIP  [<ffffffff802a6eb7>] shrink_dcache_for_umount_subtree+0x1d7/0x2b0
>  RSP <ffff810059291da8>
