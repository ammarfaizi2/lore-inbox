Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263345AbUARTdC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 14:33:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263424AbUARTdC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 14:33:02 -0500
Received: from ctb-mesg6.saix.net ([196.25.240.78]:9385 "EHLO
	ctb-mesg6.saix.net") by vger.kernel.org with ESMTP id S263345AbUARTcr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 14:32:47 -0500
Subject: Re: PROBLEM: ISDN CAPI (avm b1pci) doesn't work, occasionally
	freezes Kernel (2.6.1)
From: fcp <fcp@pop.co.za>
To: "Georg C. F. Greve" <greve@gnu.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200401181746.i0IHkO2G002776@reason.gnu-hamburg>
References: <200401181746.i0IHkO2G002776@reason.gnu-hamburg>
Content-Type: text/plain
Message-Id: <1074468927.2722.2.camel@server>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 18 Jan 2004 21:35:27 -0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had similar problems. Running RH9, 2.6.1, W6692 pci card. Spent quite
some time chasing this and in the end installed mISDN beta and it worked
the first time. No nonsense. Hope this helps

On Sun, 2004-01-18 at 15:46, Georg C. F. Greve wrote:
> Hi all,
> 
> I've tried to get my AVM B1 V4 ISDN card to run with Kernel 2.6.1; it
> produced lots of noise on the logs, didn't work and occasionally froze
> the kernel.
> 
> Regardless of whether I compile everything (or parts of it ) into the
> kernel or as a module, the symptoms/effects remain the same. The card
> appears to be detected just fine
> 
> 
> ______________________________________________________________________
> Jan 18 16:59:11 mybox kernel: capi20_register: 
> Jan 18 16:59:11 mybox kernel: kcapi: appl 1 up
> Jan 18 16:59:11 mybox kernel: capidrv: Rev 1.39.6.7: loaded
> Jan 18 16:59:11 mybox kernel: capi20: Rev 1.1.4.1.2.2: started up with major 68 (middleware+capifs)
> Jan 18 16:59:11 mybox kernel: b1dma: revision 1.1.4.1.2.1
> Jan 18 16:59:11 mybox kernel: PCI: Found IRQ 11 for device 0000:00:0c.0
> Jan 18 16:59:11 mybox kernel: b1pci: PCI BIOS reports AVM-B1 V4 at i/o 0x8000, irq 11, mem 0xd9000000
> Jan 18 16:59:11 mybox kernel: kcapi: Controller 1: b1pciv4-8000 attached
> Jan 18 16:59:11 mybox kernel: b1pci: AVM B1 PCI V4 at i/o 0x8000, irq 11, mem 0 xd9000000, revision 4 (dma)
> 
> ______________________________________________________________________
> and I can load the firmware into the card [*], but here it is starting
> to get noisy
> 
> 
> ______________________________________________________________________
> Jan 18 16:59:38 mybox kernel: b1pciv4-8000: card 1 "B1" ready.
> Jan 18 16:59:38 mybox kernel: b1pciv4-8000: card 1 Protocol: DSS1
> Jan 18 16:59:38 mybox kernel: b1pciv4-8000: card 1 Linetype: point to multipoint
> Jan 18 16:59:38 mybox kernel: b1pciv4-8000: B1-card (3.11-03) now active
> Jan 18 16:59:38 mybox kernel: kcapi: card 1 "b1pciv4-8000" ready.
> Jan 18 16:59:38 mybox kernel: kcapi: notify up contr 1
> Jan 18 16:59:38 mybox kernel: capidrv: controller 1 up
> Jan 18 16:59:38 mybox kernel: get_drv 0: 0 -> 1
> Jan 18 16:59:38 mybox kernel: capidrv-1: State ST_DRV_NULL Event EV_DRV_REGISTER
> Jan 18 16:59:38 mybox kernel: capidrv-1: ChangeState ST_DRV_LOADED
> Jan 18 16:59:38 mybox kernel: get_drv 0: 1 -> 2
> Jan 18 16:59:38 mybox kernel: b1pciv4-8000: b1dma_interrupt: 0x1 ???
> Jan 18 16:59:38 mybox kernel: capidrv-1: State ST_DRV_LOADED Event EV_STAT_RUN
> Jan 18 16:59:38 mybox kernel: capidrv-1: ChangeState ST_DRV_RUNNING
> Jan 18 16:59:38 mybox kernel: put_drv 0: 2 -> 1
> Jan 18 16:59:38 mybox kernel: capi20_put_message: applid 0x1
> Jan 18 16:59:38 mybox kernel: capidrv-1: now up (2 B channels)
> Jan 18 16:59:38 mybox kernel: capidrv-1: D2 trace enabled
> Jan 18 16:59:38 mybox kernel: capi20_put_message: applid 0x1
> 
> ______________________________________________________________________
> When starting up "old style" isdn0/ipppd interfaces, I see lots of
> lines like
> 
> 
> ______________________________________________________________________
> Jan 18 13:08:51 mybox kernel: get_drv 0: 1 -> 2
> Jan 18 13:08:51 mybox kernel: put_drv 0: 2 -> 1
> 
> ______________________________________________________________________
> with the occasional reports that things have been set up correctly,
> like
> 
> 
> ______________________________________________________________________
> Jan 18 13:08:52 mybox ipppd[2578]: Found 2 devices: , 
> Jan 18 13:08:52 mybox ipppd[2589]: ipppd i2.2.12 (isdn4linux version of pppd by
>  MH) started
> Jan 18 13:08:52 mybox ipppd[2589]: init_unit: 0
> Jan 18 13:08:52 mybox kernel: ipppd_get: 1
> Jan 18 13:08:52 mybox ipppd[2589]: Connect[0]: /dev/ippp1, fd: 9
> Jan 18 13:08:52 mybox ipppd[2589]: init_unit: 1
> Jan 18 13:08:52 mybox kernel: ipppd_get: 1
> Jan 18 13:08:52 mybox ipppd[2589]: Connect[1]: /dev/ippp0, fd: 10
> [...]
> Jan 18 13:08:53 mybox isdnlog: Holiday Version 1.10-Germany [12-Apr-1999] loaded [11 entries from /usr/share/isdn/holiday-de.dat]
> Jan 18 13:08:53 mybox isdnlog: Dest V1.01: File '/usr/share/isdn/dest.cdb' opened fine - Dest 1.0 int (+h) AT DE NL CH BE
> Jan 18 13:08:53 mybox isdnlog: Zone V1.25: Provider 0 File '/usr/share/isdn/zone-de-dtag.cdb' opened fine - V1.25 K2 C2 N256 T157147 O1 L5
> Jan 18 13:08:53 mybox isdnlog: Rates   Version 3.06 [07-Aug-2003 22:35:40] loaded [70 Providers, 738 Zones, 2667 Areas, 42 Services, 509 Comments, 13 eXceptions, 35 Redirects, 2091 Rates from /usr/share/isdn/rate-de.dat]
> [...]
> Jan 18 13:08:53 mybox isdnlog: (ISDN subsystem with ISDN_MAX_CHANNELS > 16 detected, ioctl(IIOCNETGPN) is available)
> Jan 18 13:08:53 mybox isdnlog: isdn.conf:2 active channels, 6 MSN/SI entries
> Jan 18 13:08:53 mybox isdnlog: (Data versions: iprofd=0x06  net_cfg=0x06  /dev/isdninfo=0x01)
> Jan 18 13:08:53 mybox isdnlog: Everything is fine, isdnlog-4.67 is running in full featured mode.
> Jan 18 13:08:53 mybox isdnlog: 
> Jan 18 13:08:53 mybox + Jan 18 13:08:53 -----------------------------------------
> Jan 18 13:08:53 mybox isdnlog: | capidrv-1#0 : free
> Jan 18 13:08:53 mybox isdnlog: | capidrv-1#1 : free
> [...]
> 
> ______________________________________________________________________
> These have several get_drv/put_drv lines thrown in (as above).
> 
> But then very quickly, the following block shows up, which gets
> repeated occasionally
> 
> 
> ______________________________________________________________________
> Jan 18 13:09:30 mybox kernel: capidrv-1: controller dead ??
> Jan 18 13:09:30 mybox kernel: capi20_put_message: applid 0x1
> Jan 18 13:09:30 mybox kernel: capidrv-1: listen_change_state state=1 event=1 ????
> 
> ______________________________________________________________________
> Trying to access the ISDN, or trying to call the cards (to check the
> answering machine) produce many more of the get_drv/put_drv lines with
> different numbers at the end (e.g. "3 -> 4", "4 -> 3") but nothing
> appears to work.
> 
> 
> I've tried for hours, checking the kernel config and recompiling with
> different options (including acpi/no acpi, pnp/no pnp and so on), but
> the behaviour was always the same. 
> 
> The card ought to be fine -- it works flawlessly with kernel 2.4.x.
> 
> So may this be a problem with kernel 2.6.x?
> 
> 
> I hope this helps, if you need more info, please let me know.
> 
> Help to get it to work would be appreciated.
> 
> Regards,
> Georg
> 
> 
> [*] Yes, the firmware should be correct: the cards works perfectly
> (with that firmware) under kernel 2.4.24.
> 
> 
> P.S. Distribution: Debian GNU/Linux Testing
>      CPU:          AMD Athlon(tm) Processor (700MHz)
> 
> 
> P.P.S. Possibly related (not sure):
> 
> When trying the compiled-in CAPI with dynamically loaded "old style"
> ISDN interfaces, I saw some kernel oopses. When everything was
> compiled-in, I didn't see Oopses, although the above is still exactly
> the same.
> 
> Even though it may be unrelated, in case it helps here are the syslog
> entries for reference:
> 
> 
> ______________________________________________________________________
> Jan 18 14:25:53 mybox kernel: Unable to handle kernel paging request at virtual address 04800600
> Jan 18 14:25:53 mybox kernel:  printing eip:
> Jan 18 14:25:53 mybox kernel: c0139a40
> Jan 18 14:25:53 mybox kernel: *pde = 00000000
> Jan 18 14:25:53 mybox kernel: Oops: 0000 [#1]
> Jan 18 14:25:53 mybox kernel: CPU:    0
> Jan 18 14:25:53 mybox kernel: EIP:    0060:[shrink_list+400/1136]    Not tainted
> Jan 18 14:25:53 mybox kernel: EFLAGS: 00010282
> Jan 18 14:25:53 mybox kernel: EIP is at shrink_list+0x190/0x470
> Jan 18 14:25:53 mybox kernel: eax: 04800600   ebx: 00000000   ecx: 00000000   edx: 00000002
> Jan 18 14:25:53 mybox kernel: esi: c13b7568   edi: d7d67e64   ebp: d7c8db4c   esp: d7d67da0
> Jan 18 14:25:53 mybox kernel: ds: 007b   es: 007b   ss: 0068
> Jan 18 14:25:53 mybox kernel: Process kswapd0 (pid: 8, threadinfo=d7d66000 task=d7d6ccc0)
> Jan 18 14:25:53 mybox kernel: Stack: d7d4c080 00000082 c0429680 00000001 00000000 0000004e c13b7a08 c13be0b0 
> Jan 18 14:25:53 mybox kernel:        20000001 00000000 d7d67e10 c010ae0a 0000000e d7d4c080 d7d67e10 0000000e 
> Jan 18 14:25:53 mybox kernel:        00000000 00000001 00000087 c010b13c 0000000e c03e0d80 00000001 c036ed34 
> Jan 18 14:25:53 mybox kernel: Call Trace:
> Jan 18 14:25:53 mybox kernel:  [handle_IRQ_event+58/112] handle_IRQ_event+0x3a/0x70
> Jan 18 14:25:53 mybox kernel:  [do_IRQ+140/240] do_IRQ+0x8c/0xf0
> Jan 18 14:25:53 mybox kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
> Jan 18 14:25:53 mybox kernel:  [shrink_cache+352/640] shrink_cache+0x160/0x280
> Jan 18 14:25:53 mybox kernel:  [balance_pgdat+372/496] balance_pgdat+0x174/0x1f0
> Jan 18 14:25:53 mybox kernel:  [kswapd+252/256] kswapd+0xfc/0x100
> Jan 18 14:25:53 mybox kernel:  [autoremove_wake_function+0/80] autoremove_wake_function+0x0/0x50
> Jan 18 14:25:53 mybox kernel:  [autoremove_wake_function+0/80] autoremove_wake_function+0x0/0x50
> Jan 18 14:25:53 mybox kernel:  [kswapd+0/256] kswapd+0x0/0x100
> Jan 18 14:25:53 mybox kernel:  [kernel_thread_helper+5/12] kernel_thread_helper+0x5/0xc
> Jan 18 14:25:53 mybox kernel: 
> Jan 18 14:25:53 mybox kernel: Code: 8b 08 85 c9 0f 84 9b 01 00 00 8b 54 24 0c 85 d2 74 3e 8b 45
> 
> ______________________________________________________________________
> Jan 18 15:11:37 mybox kernel: Unable to handle kernel paging request at virtual address 01001f02
> Jan 18 15:11:37 mybox kernel:  printing eip:
> Jan 18 15:11:37 mybox kernel: c01732b1
> Jan 18 15:11:37 mybox kernel: *pde = 00000000
> Jan 18 15:11:37 mybox kernel: Oops: 0000 [#2]
> Jan 18 15:11:37 mybox kernel: CPU:    0
> Jan 18 15:11:37 mybox kernel: EIP:    0060:[proc_lookup+49/192]    Not tainted
> Jan 18 15:11:37 mybox kernel: EFLAGS: 00010206
> Jan 18 15:11:37 mybox kernel: EIP is at proc_lookup+0x31/0xc0
> Jan 18 15:11:37 mybox kernel: eax: d5632900   ebx: 01001f00   ecx: 00000082   edx: d5632900
> Jan 18 15:11:37 mybox kernel: esi: d563297d   edi: d7c82e89   ebp: 00000003   esp: d54d9e84
> Jan 18 15:11:37 mybox kernel: ds: 007b   es: 007b   ss: 0068
> Jan 18 15:11:37 mybox kernel: Process cat (pid: 17165, threadinfo=d54d8000 task=d601ed40)
> Jan 18 15:11:37 mybox kernel: Stack: d563297c d4a62ec0 c015dfe3 fffffffe 00000000 fffffff4 d69e82b8 d69e8250 
> Jan 18 15:11:37 mybox kernel:        d5632900 c0154cdc d69e8250 d5632900 d54d9f70 00000000 d54d9f70 d7ff0840 
> Jan 18 15:11:37 mybox kernel:        d54d9f00 c0154f46 d4a62ec0 d54d9f08 d54d9f70 c489b00a d54d9f00 d69e8250 
> Jan 18 15:11:37 mybox kernel: Call Trace:
> Jan 18 15:11:37 mybox kernel:  [d_lookup+35/80] d_lookup+0x23/0x50
> Jan 18 15:11:37 mybox kernel:  [real_lookup+204/240] real_lookup+0xcc/0xf0
> Jan 18 15:11:37 mybox kernel:  [do_lookup+150/176] do_lookup+0x96/0xb0
> Jan 18 15:11:37 mybox kernel:  [link_path_walk+1036/2016] link_path_walk+0x40c/0x7e0
> Jan 18 15:11:37 mybox kernel:  [open_namei+131/1008] open_namei+0x83/0x3f0
> Jan 18 15:11:37 mybox kernel:  [filp_open+62/112] filp_open+0x3e/0x70
> Jan 18 15:11:37 mybox kernel:  [sys_open+91/144] sys_open+0x5b/0x90
> Jan 18 15:11:37 mybox kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
> Jan 18 15:11:37 mybox kernel: 
> Jan 18 15:11:37 mybox kernel: Code: 0f b7 4b 02 39 e9 74 47 8b 5b 28 85 db 75 f1 8b 44 24 10 85 
> 
> ______________________________________________________________________

