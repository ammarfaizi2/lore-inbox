Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262026AbVCZKmp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262026AbVCZKmp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 05:42:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262031AbVCZKmo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 05:42:44 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:6408 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S262026AbVCZKmJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 05:42:09 -0500
Date: Sat, 26 Mar 2005 11:42:02 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>, mchan@broadcom.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.30-rc2
Message-ID: <20050326104202.GK30052@alpha.home.local>
References: <20050326004631.GC17637@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050326004631.GC17637@logos.cnet>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo, Hi Michael,

ok, it runs fine on athlon-smp and pentium-M notebook.
I still have my negociation trouble on the notebook with the tg3, but as
I have not yet reported them, this is normal ;-)

Basically, when the nic is connected to a 100 Mbps, forced-full duplex
switch (eg: cisco), the NIC negociates 100-half. If I set duplex to auto
on the switch, tg3 goes to 100-full. Now, as soon as I set autoneg to off
on the tg3 with ethtool (v3), the link goes down, whatever the speed and
duplex, or the config on the switch. Setting the interface down then up
does not change anything. So I have no solution to connect this notebook
to a forced 100-full switch (very common in enterprise networks and hosting
rooms), and honnestly, changing the configuration on the switch is not
often an option when I come with my notebook for network troubleshooting ;-)

This is not critical at all as I always have my cardbus 3c575 with me, so
I don't consider this a show-stopper for 2.4.30 at all. But if Michael has
any ideas about the problem or a trivial patch to test, I can do some
testings in a short timeframe as I can reproduce the problem right here,
and the fix could interest other people with similar chips.

For reference, the chip is identified as Broadcom NetXtreme BCM5705M_2 rev3
(id 14e4:165e, subsystem 103c:088c). It's in an hp compaq nc8000.

Regards,
Willy

On Fri, Mar 25, 2005 at 09:46:31PM -0300, Marcelo Tosatti wrote:
> Hi,
> 
> Here goes the second release candidate for v2.4.30.
> 
> It contains a bunch of security updates (ext2 mkdir leak, af_bluetooth range
> checking, isofs corrupt media, load_elf_library DoS), an ia64 update, another 
> round of networking fixes, amongst others.
> 
> If nothing terrible shows up, this will become v2.4.30.
> 
> Please help with testing!
> 
> Summary of changes from v2.4.30-rc1 to v2.4.30-rc2
> ============================================
> 
> <davem:sunset.davemloft.net>:
>   o [TG3]: Add missing CHIPREV_5750_{A,B}X defines
>   o [TG3]: Missing counter bump in tigon3_4gb_hwbug_workaround()
>   o [TG3]: Update driver version and reldate
> 
> <magnus.damm:gmail.com>:
>   o eepro100: fix module parameter description typo
> 
> <mlafon:arkoon.net>:
>   o CAN-2005-0400: ext2 mkdir() directory entry random kernel memory leak
> 
> <relf:os2.ru>:
>   o fs/hpfs/*: fix HPFS support under 64-bit kernel
> 
> <sj-netfilter:cookinglinux.org>:
>   o [NETFILTER]: Fix another DECLARE_MUTEX in header file
> 
> Bjorn Helgaas:
>   o ia64: force all kernel sections into one and the same segment
>   o ia64: round iommu allocations to power-of-two sizes
>   o ia64: fix perfmon typo in /proc/pal/CPU*/processor_info w.r.t. BERR
>   o ia64: add missing syscall-slot
>   o ia64: Update defconfigs
> 
> Chris Wright:
>   o isofs: Some more defensive checks to keep corrupt isofs images from corrupting memory/oopsing
> 
> Dave Kleikamp:
>   o JFS: remove aops from directory inodes
> 
> David Mosberger:
>   o Fix pte_modify() bug which allowed mprotect() to change too many bits
>   o ia64: Fix _PAGE_CHG_MASK so PROT_NONE works again.  Caught by Linus
> 
> Greg Banks:
>   o link_path_walk refcount problem allows umount of active filesystem
> 
> Herbert Xu:
>   o [CRYPTO]: Mark myself as co-maintainer
>   o [NETLINK]: Fix multicast bind/autobind race
>   o CAN-2005-0794: Potential DOS in load_elf_library
> 
> Keith Owens:
>   o [IA64] Sanity check unw_unwind_to_user
>   o [IA64] Tighten up unw_unwind_to_user check
> 
> Linus Torvalds:
>   o isofs: Handle corupted rock-ridge info slightly better
>   o isofs: more "corrupted iso image" error cases
> 
> Marcel Holtmann:
>   o CAN-2005-0750: Fix af_bluetooth range checking bug, discovered by Ilja van Sprundel <ilja@suresec.org>
> 
> Marcelo Tosatti:
>   o Change VERSION to 2.4.30-rc2
> 
> Michael Chan:
>   o [TG3]: Add 5705_plus flag
>   o [TG3]: Flush status block in tg3_interrupt()
>   o [TG3]: Add unstable PLL workaround for 5750
>   o [TG3]: Fix jumbo frames phy settings
>   o [TG3]: Fix ethtool set functions
>   o [TG3]: Add Broadcom copyright
> 
> Neil Brown:
>   o nlm: fix f_count leak
>   o [PATCH md: allow degraded raid1 array to resync after an unclean shutdown
> 
> Pablo Neira:
>   o [NETFILTER]: Fix DECLARE_MUTEX in header file
> 
> Patrick McHardy:
>   o [NETFILTER]: fix return values of ipt_recent checkentry
>   o [NETFILTER]: Fix ip_ct_selective_cleanup(), and rename ip_ct_iterate_cleanup()
>   o [NETFILTER]: Fix cleanup in ipt_recent
>   o [NETFILTER]: Fix ip6tables ESP matching with "-p all"
>   o [NETFILTER]: Fix refreshing of overlapping expectations
>   o [NETFILTER]: Fix IP/TCP option logging
>   o [TUN]: Fix check for underflow
> 
> Pete Zaitcev:
>   o USB: fix oops in serial_write
>   o USB: Fix baud selection in mct_u232
> 
> Simon Horman:
>   o [IPVS]: Fix comment typos
>   o Backport v2.6 ATM copy-to-user signedness fix
>   o earlyquirk.o is needed for CONFIG_ACPI_BOOT
> 
> Stephen Hemminger:
>   o [TCP]: BIC not binary searching correctly
> 
> Wensong Zhang:
>   o [IPVS]: Update mark->cw in the WRR scheduler while service is updated
> 
> Yanmin Zhang:
>   o [IA64] clean up ptrace corner cases
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
