Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965021AbVJ1A2x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965021AbVJ1A2x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 20:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965022AbVJ1A2x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 20:28:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:31184 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965021AbVJ1A2w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 20:28:52 -0400
Date: Thu, 27 Oct 2005 17:28:50 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.6.14
Message-ID: <Pine.LNX.4.64.0510271717190.4664@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, it's finally there. 

2.6.14 was delayed twice due to some last-minute bug-reports, some of 
which ended up being false alarms (hey, I should be happy, but it was a 
bit frustrating)

But hey, the delays - even when perhaps unnecessary - got us to look at 
the code and fix some other bugs instead. So it's all good.

So special thanks go to Oleg Nesterov and Roland McGrath for doing some 
code inspection and fixing and just making the otherwise frustrating wait 
for bug resolution more productive ;^p.

Let's try the 2-week merge window thing again, I think it worked pretty 
well despite the delays, and hopefully it will work even better this time 
around.

The actual changes from 2.6.14-rc5 are a number of mostly one-liners, with 
the ShortLog appended (full log from 2.6.13 on the normal sites together 
with the release itself). The only slightly bigger ones (ie more than a 
handful of lines) is a kernel parameter doc update, and the PIIX4 PCI 
quirk printouts, and the cleanups/fixes for the posix cpu timers.

(In fact, according to diffstat, about half the diff is that one 
documentation update, and most of that is whitespace cleanups)

		Linus

----
Alan Stern:
      [SCSI] Fix leak of Scsi_Cmnds

Andrew Morton:
      inotify/idr leak fix
      alpha: atomic dependency fix
      qlogic lockup fix
      export cpu_online_map
      svcsock timestamp fix

Ben Dooks:
      [ARM] 3026/1: S3C2410 - avoid possible overflow in pll calculations
      [ARM] 3027/1: BAST - reduce NAND timings slightly
      [ARM] 3028/1: S3C2410 - add DCLK mask definitions

Benjamin Herrenschmidt:
      ppc64: Fix pages marked dirty abusively
      ppc64: Fix wrong register mapping in mpic driver

Bjorn Helgaas:
      [SERIAL] support the Exsys EX-4055 4S four-port card

Chris Wright:
      typo fix in last cpufreq powernow patch

Christoph Hellwig:
      [SCSI] mptsas: fix phy identifiers

Dave Airlie:
      drm: another mga bug

Dave Jones:
      cpufreq: fix pending powernow timer stuck condition
      cpufreq: SMP fix for conservative governor

Davi Arnaut:
      SELinux: handle sel_make_bools() failure in selinuxfs

David Gibson:
      ppc64: Fix typo bug in iSeries hash code

Eric Moore:
      mptsas: fix phy identifiers

Herbert Xu:
      [DCCP]: Use skb_set_owner_w in dccp_transmit_skb when skb->sk is NULL
      [DCCP]: Make dccp_write_xmit always free the packet
      [DCCP]: Clear the IPCB area
      [TCP] Allow len == skb->len in tcp_fragment
      [NEIGH] Print stack trace in neigh_add_timer
      [NEIGH] Fix add_timer race in neigh_add_timer
      [NEIGH] Fix timer leak in neigh_changeaddr
      [TCP]: Clear stale pred_flags when snd_wnd changes

Hugh Dickins:
      Fix handling spurious page fault for hugetlb region

Ian Campbell:
      [ARM] 3032/1: sparse: complains about generic_fls() prototype in asm-arm/bitops.h

Ivan Kokshaysky:
      alpha: additional smp barriers
      fix radeon_cp_init_ring_buffer()

James Simmons:
      Return the line length via sysfs for fbdev

James.Smart@Emulex.Com:
      [SCSI] FW: for Deadlock in transport_fc

Jeff Garzik:
      kill massive wireless-related log spam

Jochen Friedrich:
      [TR]: Preserve RIF flag even for 2 byte RIF fields.
      [LLC]: Strip RIF flag from source MAC address

Julian Anastasov:
      [SK_BUFF]: ipvs_property field must be copied

Justin Chen:
      [SERIAL] new hp diva console port

Karl Magnus Kolstoe:
      [SCSI] 2.6.13.3; add Pioneer DRM-624x to drivers/scsi/scsi_devinfo.c

Kostik Belousov:
      aio syscalls are not checked by lsm

Linus Torvalds:
      Revert "Fix cpu timers exit deadlock and races"
      Posix timers: limit number of timers firing at once
      cardbus: limit IO windows to 256 bytes
      PCI: be more verbose about resource quirks
      posix cpu timers: fix timer ordering
      Revert "remove false BUG_ON() from run_posix_cpu_timers()"
      Revert "x86-64: Avoid unnecessary double bouncing for swiotlb"
      Linux v2.6.14

Magnus Damm:
      NUMA: broken per cpu pageset counters

Matt Reimer:
      [ARM] 3025/1: Add I2S platform device for PXA

Mike Krufky:
      Kconfig: saa7134-dvb should not select cx22702

Miklos Szeredi:
      uml: fix compile failure for TT mode

NeilBrown:
      md: make sure mdthreads will always respond to kthread_stop

Oleg Nesterov:
      posix-timers: fix cleanup_timers() and run_posix_cpu_timers() races
      posix-timers: remove false BUG_ON() from run_posix_cpu_timers()
      posix-timers: exit path cleanup
      posix-timers: fix posix_cpu_timer_set() vs run_posix_cpu_timers() race
      Fix cpu timers expiration time

Paul Mackerras:
      ppc64: Fix typo in time calculations

Pavel Machek:
      [ARM] fix sharp zaurus c-3000 compile failure without CONFIG_FB_PXA

Peter Wainwright:
      Fix HFS+ to free up the space when a file is deleted.

Ralf Baechle:
      [AX.25]: Fix signed char bug

Randy Dunlap:
      [SCSI] NCR5380: fix undefined preprocessor identifier
      kernel-parameters cleanup

Roland Dreier:
      ib: mthca: Always re-arm EQs in mthca_tavor_interrupt()

Roland McGrath:
      Call exit_itimers from do_exit, not __exit_signal
      Yet more posix-cpu-timer fixes

Russell King:
      [ARM] Fix Integrator IM/PD-1 support

Salyzyn, Mark:
      [SCSI] Fix aacraid regression

Stephen Smalley:
      selinux: Fix NULL deref in policydb_destroy

Steven Rostedt:
      [SCSI] scsi_error thread exits in TASK_INTERRUPTIBLE state.

Takashi Iwai:
      ALSA: Fix Oops of suspend/resume with generic drivers

Yan Zheng:
      [IPV6]: Fix refcnt of struct ip6_flowlabel

