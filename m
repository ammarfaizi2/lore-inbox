Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262288AbVCBMrz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262288AbVCBMrz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 07:47:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262285AbVCBMrm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 07:47:42 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:27077 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S262281AbVCBMr3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 07:47:29 -0500
Date: Wed, 2 Mar 2005 13:47:28 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.11
Message-ID: <20050302124728.GD14002@mail.13thfloor.at>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0503012356480.25732@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0503012356480.25732@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2005 at 12:02:03AM -0800, Linus Torvalds wrote:
> 
> Ok,
>  there it is. Only small stuff lately  - as promised. Shortlog from -rc5 
> appended, nothing exciting there, mostly some fixes from various code 
> checkers (like fixed init sections, and some coverity tool finds).
> 
> So it's now _officially_ all bug-free.

BUG_ON() and friends are still broken (at least on x86)

the following 'patch':

--- ./init/main.c.orig  Thu Feb 17 19:25:21 2005
+++ ./init/main.c       Sun Feb 27 05:13:45 2005
@@ -684,6 +684,8 @@ static int init(void * unused)
         * trying to recover a really broken machine.
         */

+	BUG_ON(0==0);
+
        if (execute_command)
                run_init_process(execute_command);


results in this oops:
(look at the filename and linenumber ;)

Freeing unused kernel memory: 244k freed
------------[ cut here ]------------
kernel BUG at <bad filename>:9377!
	      ~~~~~~~~~~~~~~~~~~~

best,
Herbert

> 			Linus
> 
> ----
> Summary of changes from v2.6.11-rc5 to v2.6.11
> ============================================
> 
> <c.lucas:com.rmk.(none)>:
>   o [SERIAL] drivers/serial/*: convert to pci_register_driver
> 
> <takis:lumumba.luc.ac.be>:
>   o prism54 not releasing region
> 
> Alex Williamson:
>   o [SERIAL] 8250 woraround for buggy uart
> 
> Alexander Nyberg:
>   o SELinux: Leak in error path
>   o SELinux: null dereference in error path
> 
> Andrea Arcangeli:
>   o Make the new merged pipe writes check for SIGPIPE
> 
> Andrew Morton:
>   o binfmt_elf build fix
>   o [IA64] ia64 audit build fix
>   o genhd: NULL checking fix
> 
> Andries E. Brouwer:
>   o __devinitdata in parport_pc
>   o __init in cfq-iosched.c
>   o remove __initdata in scsi_devinfo.c
>   o __initdata in apic.c
>   o more apic.c
> 
> Aurelien Jarno:
>   o USB: Fix usbfs regression
> 
> Bartlomiej Zolnierkiewicz:
>   o [ide] fix build for built-in hpt366 and modular ide-disk
>   o [ide] fix IRQ masking in ide_do_request()
> 
> Ben Dooks:
>   o [ARM PATCH] 2498/1: CREDITS - add Ben Dooks
>   o [ARM PATCH] 2505/1: Remove FTVPCI from debug code
> 
> Bjorn Helgaas:
>   o [SERIAL] discover PNP ports before PCI, etc
>   o [SERIAL] add TP560 data/fax/modem support
> 
> Chris Wright:
>   o fix audit inode filter
>   o send audit reply to correct socket
> 
> David Gibson:
>   o ppc64: hugepage hash flushing bugfix
> 
> David Howells:
>   o Make keyctl(KEYCTL_JOIN_SESSION_KEYRING) use the correct arg
> 
> David S. Miller:
>   o [IPV4]: Fix lost routes in fn_hash netlink dumps
>   o [AF_UNIX]: Fix SIOCINQ for STREAM and SEQPACKET
> 
> Dmitry Torokhov:
>   o Input: add more PNP IDs to i8042 driver
> 
> Greg Kroah-Hartman:
>   o sysfs: fix signedness problem
>   o fix module paramater permissions in radeon_base.c
>   o USB: fix bug in acm's open function
> 
> Harald Welte:
>   o [NETFILTER]: ipt_hashlimit rule load time race condition
> 
> Hideaki Yoshifuji:
>   o add sysctl helper functions to provide milliseconds-based
>     interfaces
>   o [IPV4] Use appropriate sysctl helpers for gc_min_interval_ms
>   o [IPV6]: Unregister per-device snmp6 proc entry earlier
> 
> Jens Axboe:
>   o [PATCH] Fix bounced bio and dm panic
> 
> Kenji Kaneshige:
>   o [IA64] pci_irq.c: need signed variable to handle error return from
>     acpi
> 
> Linus Torvalds:
>   o Fix possible pty line discipline race
>   o Properly limit keyboard keycodes to KEY_MAX
>   o Make pipe "poll()" take direction of pipe into account
>   o Linux 2.6.11
> 
> Nishanth Aravamudan:
>   o [PKTGEN]: Replace interruptible_sleep_on_timeout()
> 
> Olaf Hering:
>   o Fix incorrect __init on 'modedb[]' array
> 
> Patrick McHardy:
>   o [NETFILTER]: Prevent NAT from seeing fragments
> 
> Randy Dunlap:
>   o [ide] make 1-bit fields unsigned
>   o srat: initdata section references
>   o sound/oss/aedsp16: init/exit section cleanups
>   o sonicvibes: fix initdata references
>   o sound/oss/opl3as2: fix init section reference
>   o isdn: use __init for ICCVersion()
>   o dc395x: fix section references
>   o hp100: fix section references
>   o rrunner: fix section references
> 
> Robert Olsson:
>   o [PKTGEN]: reduce stack usage
> 
> Russell King:
>   o [ARM] Fix dma_mmap() size argument
> 
> Sascha Hauer:
>   o [ARM PATCH] 2496/1: i.MX DMA fix
>   o [ARM PATCH] 2497/1: i.MX pll decode
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
