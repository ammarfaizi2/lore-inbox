Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317672AbSHCTEM>; Sat, 3 Aug 2002 15:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317698AbSHCTEM>; Sat, 3 Aug 2002 15:04:12 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:40260 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S317672AbSHCTEK>; Sat, 3 Aug 2002 15:04:10 -0400
Date: Sat, 3 Aug 2002 22:07:34 +0300
From: Ville Herva <vherva@niksula.hut.fi>
To: linux-kernel@vger.kernel.org, Marcin Dalecki <dalecki@evision.ag>
Subject: Re: [BUG] 2.5.30 ide problems booting
Message-ID: <20020803190734.GB1548@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	linux-kernel@vger.kernel.org, Marcin Dalecki <dalecki@evision.ag>
References: <200208020726.51659.tomlins@cam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200208020726.51659.tomlins@cam.org>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trying to boot 2.5.30 with an ext2 fs on a cdrom is a no-go. As soon as the
rootfs (ext2 on /dev/hdc = cdrom) is accessed, the kernel hangs.

Below are a couple of alt-sysrq-p's ran through ksymoops:

----------------------------------------------------------------
Pid: 1, comm:              swapper
EIP: 0010:[<c016b2b4>] CPU: 0 EFLAGS: 00000293    Not tainted
EAX: b85c4750 EBX: 00001388 ECX: b85c38fb EDX: 000070a9
ESI: c02ba7e0 EDI: 00001388 EBP: c02ba7f4 DS: 0018 ES: 0018
CR0: 8005003b CR2: 00000000 CR3: 00101000 CR4: 000006d0
Call Trace: [<c01a76cb>] [<c01a9a4b>] [<c01a9fd7>] [<c01b08d0>]
[<c0109f3a>] 
   [<c010a0f1>] [<c0108c94>] [<c01a7938>] [<c01a7aa7>] [<c01af923>]
[<c01b0331>] 
   [<c01b08d0>] [<c01b0120>] [<c01b0993>] [<c01b08d0>] [<c01b029b>]
[<c01b09d9>] 
   [<c01b0950>] [<c01b1224>] [<c01a9aa7>] [<c0193083>] [<c019321e>]
[<c0139cc5>] 
   [<c0125e65>] [<c0110d30>] [<c0125ea3>] [<c0127079>] [<c0118644>]
[<c015d790>] 
   [<c015b78f>] [<c015d790>] [<c015baeb>] [<c015bc78>] [<c015e7d7>]
[<c0148659>] 
   [<c013f8ec>] [<c013fba0>] [<c0140524>] [<c011b735>] [<c013ffe2>]
[<c011b791>] 
   [<c0118644>] [<c0189ae9>] [<c0140dc4>] [<c01350b6>] [<c0135485>]
[<c0108b4f>] 
   [<c01050d5>] [<c0105060>] [<c01071a1>] 
Warning (Oops_read): Code line not seen, dumping what data is available

>>EIP; c016b2b4 <__rdtsc_delay+14/20>   <=====
Trace; c01a76cb <ata_status_poll+4b/110>
Trace; c01a9a4b <do_ide_request+21b/2e0>
Trace; c01a9fd7 <ata_irq_request+107/150>
Trace; c01b08d0 <cdrom_seek_intr+0/80>
Trace; c0109f3a <handle_IRQ_event+3a/60>
Trace; c010a0f1 <do_IRQ+a1/130>
Trace; c0108c94 <common_interrupt+18/20>
Trace; c01a7938 <ata_write_32+18/20>
Trace; c01a7aa7 <ata_write+37/60>
Trace; c01af923 <atapi_write+33/60>
Trace; c01b0331 <cdrom_transfer_packet_command+81/90>
Trace; c01b08d0 <cdrom_seek_intr+0/80>
Trace; c01b0120 <cdrom_timer_expiry+0/40>
Trace; c01b0993 <cdrom_start_seek_continuation+43/50>
Trace; c01b08d0 <cdrom_seek_intr+0/80>
Trace; c01b029b <cdrom_start_packet_command+13b/150>
Trace; c01b09d9 <cdrom_start_seek+39/40>
Trace; c01b0950 <cdrom_start_seek_continuation+0/50>
Trace; c01b1224 <ide_cdrom_do_request+94/160>
Trace; c01a9aa7 <do_ide_request+277/2e0>
Trace; c0193083 <generic_unplug_device+73/a0>
Trace; c019321e <blk_run_queues+8e/a0>
Trace; c0139cc5 <block_sync_page+5/10>
Trace; c0125e65 <__lock_page+95/c0>
Trace; c0110d30 <default_wake_function+0/40>
Trace; c0125ea3 <lock_page+13/20>
Trace; c0127079 <read_cache_page+a9/100>
Trace; c0118644 <tasklet_hi_action+44/70>
Trace; c015d790 <ext2_readpage+0/20>
Trace; c015b78f <ext2_get_page+1f/70>
Trace; c015d790 <ext2_readpage+0/20>
Trace; c015baeb <ext2_find_entry+7b/190>
Trace; c015bc78 <ext2_inode_by_name+18/30>
Trace; c015e7d7 <ext2_lookup+27/a0>
Trace; c0148659 <d_alloc+19/170>
Trace; c013f8ec <real_lookup+4c/d0>
Trace; c013fba0 <do_lookup+b0/200>
Trace; c0140524 <link_path_walk+834/8f0>
Trace; c011b735 <update_process_times+25/30>
Trace; c013ffe2 <link_path_walk+2f2/8f0>
Trace; c011b791 <timer_bh+31/2c0>
Trace; c0118644 <tasklet_hi_action+44/70>
Trace; c0189ae9 <scrup+69/120>
Trace; c0140dc4 <open_namei+84/410>
Trace; c01350b6 <filp_open+36/60>
Trace; c0135485 <sys_open+35/70>
Trace; c0108b4f <syscall_call+7/b>
Trace; c01050d5 <init+75/190>
Trace; c0105060 <init+0/190>
Trace; c01071a1 <kernel_thread_helper+5/14>
----------------------------------------------------------------


----------------------------------------------------------------
Pid: 1, comm:              swapper
EIP: 0010:[<c016b2b4>] CPU: 0 EFLAGS: 00000297    Not tainted
EAX: 92f9d784 EBX: 00001388 ECX: 92f9cc81 EDX: 00007097
ESI: c02ba7e0 EDI: 00000010 EBP: 00000000 DS: 0018 ES: 0018
CR0: 8005003b CR2: 00000000 CR3: 00101000 CR4: 000006d0
Call Trace: [<c01a772a>] [<c01b11d0>] [<c01a9aa7>] [<c01a9fd7>] [<c01b08d0>] 
   [<c0109f3a>] [<c010a0f1>] [<c0108c94>] [<c01a7938>] [<c01a7aa7>]
[<c01af923>] 
   [<c01b0331>] [<c01b08d0>] [<c01b0120>] [<c01b0993>] [<c01b08d0>]
[<c01b029b>] 
   [<c01b09d9>] [<c01b0950>] [<c01b1224>] [<c01a9aa7>] [<c0193083>]
[<c019321e>] 
   [<c0139cc5>] [<c0125e65>] [<c0110d30>] [<c0125ea3>] [<c0127079>]
[<c0118644>] 
   [<c015d790>] [<c015b78f>] [<c015d790>] [<c015baeb>] [<c015bc78>]
[<c015e7d7>] 
   [<c0148659>] [<c013f8ec>] [<c013fba0>] [<c0140524>] [<c011b735>]
[<c013ffe2>] 
   [<c011b791>] [<c0118644>] [<c0189ae9>] [<c0140dc4>] [<c01350b6>]
[<c0135485>] 
   [<c0108b4f>] [<c01050d5>] [<c0105060>] [<c01071a1>] 
Warning (Oops_read): Code line not seen, dumping what data is available

>>EIP; c016b2b4 <__rdtsc_delay+14/20>   <=====
Trace; c01a772a <ata_status_poll+aa/110>
Trace; c01b11d0 <ide_cdrom_do_request+40/160>
Trace; c01a9aa7 <do_ide_request+277/2e0>
Trace; c01a9fd7 <ata_irq_request+107/150>
Trace; c01b08d0 <cdrom_seek_intr+0/80>
Trace; c0109f3a <handle_IRQ_event+3a/60>
Trace; c010a0f1 <do_IRQ+a1/130>
Trace; c0108c94 <common_interrupt+18/20>
Trace; c01a7938 <ata_write_32+18/20>
Trace; c01a7aa7 <ata_write+37/60>
Trace; c01af923 <atapi_write+33/60>
Trace; c01b0331 <cdrom_transfer_packet_command+81/90>
Trace; c01b08d0 <cdrom_seek_intr+0/80>
Trace; c01b0120 <cdrom_timer_expiry+0/40>
Trace; c01b0993 <cdrom_start_seek_continuation+43/50>
Trace; c01b08d0 <cdrom_seek_intr+0/80>
Trace; c01b029b <cdrom_start_packet_command+13b/150>
Trace; c01b09d9 <cdrom_start_seek+39/40>
Trace; c01b0950 <cdrom_start_seek_continuation+0/50>
Trace; c01b1224 <ide_cdrom_do_request+94/160>
Trace; c01a9aa7 <do_ide_request+277/2e0>
Trace; c0193083 <generic_unplug_device+73/a0>
Trace; c019321e <blk_run_queues+8e/a0>
Trace; c0139cc5 <block_sync_page+5/10>
Trace; c0125e65 <__lock_page+95/c0>
Trace; c0110d30 <default_wake_function+0/40>
Trace; c0125ea3 <lock_page+13/20>
Trace; c0127079 <read_cache_page+a9/100>
Trace; c0118644 <tasklet_hi_action+44/70>
Trace; c015d790 <ext2_readpage+0/20>
Trace; c015b78f <ext2_get_page+1f/70>
Trace; c015d790 <ext2_readpage+0/20>
Trace; c015baeb <ext2_find_entry+7b/190>
Trace; c015bc78 <ext2_inode_by_name+18/30>
Trace; c015e7d7 <ext2_lookup+27/a0>
Trace; c0148659 <d_alloc+19/170>
Trace; c013f8ec <real_lookup+4c/d0>
Trace; c013fba0 <do_lookup+b0/200>
Trace; c0140524 <link_path_walk+834/8f0>
Trace; c011b735 <update_process_times+25/30>
Trace; c013ffe2 <link_path_walk+2f2/8f0>
Trace; c011b791 <timer_bh+31/2c0>
Trace; c0118644 <tasklet_hi_action+44/70>
Trace; c0189ae9 <scrup+69/120>
Trace; c0140dc4 <open_namei+84/410>
Trace; c01350b6 <filp_open+36/60>
Trace; c0135485 <sys_open+35/70>
Trace; c0108b4f <syscall_call+7/b>
Trace; c01050d5 <init+75/190>
Trace; c0105060 <init+0/190>
Trace; c01071a1 <kernel_thread_helper+5/14>
----------------------------------------------------------------

I see a couple of ata_write's there - could trying to write to a ro media be
the culprit?

2.4.x is ok and 2.5.26 boots as well.


-- v --

v@iki.fi
