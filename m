Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751206AbVJKN2v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206AbVJKN2v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 09:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751210AbVJKN2u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 09:28:50 -0400
Received: from magic.adaptec.com ([216.52.22.17]:38612 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S1751206AbVJKN2t convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 09:28:49 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: Linux v2.6.14-rc4
Date: Tue, 11 Oct 2005 09:28:39 -0400
Message-ID: <547AF3BD0F3F0B4CBDC379BAC7E4189F01B5188B@otce2k03.adaptec.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Linux v2.6.14-rc4
Thread-Index: AcXOA4d0KPG2EjcOQJup46GINpkXfwAY5CSg
From: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
To: "Linus Torvalds" <torvalds@osdl.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Cc: <linux-scsi@vger.kernel.org>, "Mark Haverkamp" <markh@osdl.org>,
       "Tom Coughlan" <coughlan@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A resend of the one-line patch to fix a regression that did not make it in ...

Sincerely -- Mark Salyzyn

-----Original Message-----
From: Salyzyn, Mark 
Sent: Wednesday, October 05, 2005 12:59 PM
To: 'linux-kernel@vger.kernel.org'
Cc: 'linux-scsi@vger.kernel.org'; 'Juan D Ch'; 'Mark Haverkamp'; 'Martin Drab'
Subject: RE: 2.6.13.2 aacraid regression

Juan was kind enough to linger on site, and work on a production machine, to try the parameter to make the system stable. He discovered that reducing the maximum transfer size issued to the adapter to 128KB stabilized his system. This is related to an earlier change for the 2.6.13 tree resulting from Martin Drab's testing where the transfer size was reduced from 4G to 256KB; we needed to go still further in scaling back the request size.

Here is the patch that tames this regression.

Applies to the 2.6.13.2 tree.

Signed-off-by: Mark Salyzyn <aacraid@adaptec.com>

Index: linux-2.6.13.2/drivers/scsi/aacraid/aacraid.h
===================================================================
--- linux-2.6.13.2/drivers/scsi/aacraid/aacraid.h       2005-10-05 12:45:16 -0400
+++ linux-2.6.13.2-aacraid-fix/drivers/scsi/aacraid/aacraid.h   2005-09-16 21:02:12 -0400
@@ -15,7 +15,7 @@
 #define AAC_MAX_LUN            (8)

 #define AAC_MAX_HOSTPHYSMEMPAGES (0xfffff)
-#define AAC_MAX_32BIT_SGBCOUNT ((unsigned short)512)
+#define AAC_MAX_32BIT_SGBCOUNT ((unsigned short)256)

 /*
  * These macros convert from physical channels to virtual channels

Sincerely -- Mark Salyzyn

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Linus Torvalds
Sent: Monday, October 10, 2005 9:31 PM
To: Linux Kernel Mailing List
Subject: Linux v2.6.14-rc4

Here's the final -rc before a 2.6.14 release.

In the diffstat, most of the changes are one-liners, with the main 
exceptions being some sparc64 work (fix user-space corruption due to FP 
save/restore) and the new Megaraid SAS driver. There's some networking 
fixes, and a couple of driver updates (scsi: aacraid, net: cassini, and 
watchdog: pcwd_pci).

Along with a x86-64 suspend/resume page table corruption and some new 
defconfig files for ARM, that rounds out the bigger chunks.

The shortlog (appended) should be a pretty good idea of the rest.

		Linus

---
Adam Radford:
      [SCSI] 3ware 9000: Add support for 9550SX controllers

Adrian Bunk:
      [SPARC]: "extern inline" doesn't make much sense.

Al Viro:
      [CASSINI]: Convert to ethtool_ops
      missing include in megaraid_sas
      bogus kfree() in ibmtr
      bfs iget() abuses
      fix the breakage in sparc headers
      gfp flags annotations - part 1

Alexey Dobriyan:
      bfs endianness annotations

Allan Graves:
      uml: Fix sysrq-r support for skas mode

Ananth N Mavinakayanahalli:
      ppc64: fix up()/down() usage for kprobe_mutex

Andi Kleen:
      x86_64: Drop global bit from early low mappings
      x86_64: Fix change_page_attr cache flushing
      x86_64: Allocate cpu local data for all possible CPUs
      i386: Don't discard upper 32bits of HWCR on K8

Andrew Morton:
      [SCSI] lpfc build fix

Andrew Vasquez:
      [SCSI] qla2xxx: fix remote port timeout with qla2xxx driver

Anton Altaparmakov:
      NTFS: Fix a stupid bug in __ntfs_bitmap_set_bits_in_run() which caused the
      NTFS: Fix a 64-bitness bug where a left-shift could overflow a 32-bit variable

Bagalkote, Sreenivas:
      [SCSI] MegaRAID SAS RAID: new driver

Ben Dooks:
      [ARM] 2963/1: S3C2410 - add .owner field to device_driver
      [ARM] 2964/1: S3C2410 - serial: add .owner to driver

Benjamin Herrenschmidt:
      pmac: fix cpufreq for old tipb 550Mhz
      ppc: Fix timekeeping with HZ=250 on some Mac models
      ide: Workaround PM problem

Bryan Sutula:
      [IA64] Avoid kernel hang during CMC interrupt storm

Catalin Marinas:
      [ARM] 2943/1: Clear the exclusive monitor in v6_early_abort
      [ARM] 2954/1: Allow D and I cache and branch prediction disabling for ARMv6

Christoph Hellwig:
      [SCSI] sas: fix remote phy removal

Clemens Ladisch:
      [ALSA] usb-audio: ignore Hercules DJ Console mixer errors
      [ALSA] usb-audio: add Roland RD-700SX support
      [ALSA] usb-audio: add more Yamaha USB MIDI devices
      [ALSA] usb-audio: add another ID for the TerraTec PHASE26
      [ALSA] usb-audio: increase max buffer size
      [ALSA] korg1212: fix typo
      [ALSA] usb-audio: add another ID for Hercules DJ Console
      [ALSA] usb-audio: add MIDI quirk for Hercules DJ Console

Daniel Ritz:
      [ALSA] snd_opl3sa2: add missing pnp_unregister_driver() calls

Dave Jones:
      Fix drm 'debug' sysfs permissions

David Howells:
      key: plug request_key_auth memleak
      Keys: Add request-key process documentation
      Keys: Split key permissions checking into a .c file
      Keys: Possessor permissions should be additive

David S. Miller:
      [IPV6]: Fix leak added by udp connect dst caching fix.
      [IPV4]: Update icmp sysctl docs and disable broadcast ECHO/TIMESTAMP by default
      [TG3]: Update driver version and release date.
      [SUNSU]: Fix bogus locking in sunsu_change_mouse_baud()
      [SPARC64]: Replace cheetah+ code patching with variables.
      [SPARC64]: Fix initrd when net booting.
      [SPARC64]: Probe for power device on ISA bus too.
      [SPARC64]: Fix userland FPU state corruption.
      [SPARC64]: Fix Ultra5, Ultra60, et al. boot failures.

David Vrabel:
      yenta: fix build if YENTA && !CARDBUS

Deepak Saxena:
      Fix IXP2000 serial port resource range
      ARM: Fix IXP2000 serial port resource range. For real this time.
      Fix broken IXP4xx GPIO macro

Diego Calleja:
      trivial #if -> #ifdef

Dirk Opfer:
      [ALSA] Fix pm_message_t in PXA2XX-AC97 driver

Eric Dumazet:
      [INET]: speedup inet (tcp/dccp) lookups
      [INET]: Shrink struct inet_ehash_bucket on 32 bits UP

Eric Kinzie:
      [ATM]: add support for LECS addresses learned from network

Francois Romieu:
      r8169: tone down the r8169 driver

George G. Davis:
      [ARM] 2959/1: Add test for invalid LDRD/STRD Rd cases in ARM alignment handler

Grant Coady:
      net/Kconfig: convert pocket_adapter ISA to PARPORT

Harald Welte:
      Fix signal sending in usbdevio on async URB completion

Herbert Xu:
      [NET]: Fix packet timestamping.
      [IPV4]: Fix "Proxy ARP seems broken"
      [IPV4]: Replace __in_dev_get with __in_dev_get_rcu/rtnl
      [IPV4]: Get rid of bogus __in_put_dev in pktgen
      [IPSEC]: Document that policy direction is derived from the index.

Horst H. von Brand:
      [NETFILTER]: Fix Kconfig typo

Ion Badulescu:
      [netdrvr starfire] fix highmem and broken firmware issues

Ivan Skytte Jørgensen:
      [SCTP] Fix sctp_get{pl}addrs() API to work with 32-bit apps on 64-bit kernels.

James Bottomley:
      [SCSI] allow REPORT LUN scanning even for LUN 0 PQ of 3
      [SCSI] fix potential panic with proc on module removal
      [SCSI] aic7xxx/aic79xx: fix module removal path not to panic
      [SCSI] Legacy MegaRAID: Fix READ CAPACITY

Jay Vosburgh:
      fix bonding crash, remove old ABI support

Jean-Denis Boyer:
      [ATM]: [br2684] if we free the skb, we should return 0

Jeff Dike:
      UML - Fix Al's build tidying
      uml: fix x86_64 with !CONFIG_FRAME_POINTER

Jens Axboe:
      scsi_ioctl: only warn for rejected commands

John W. Linville:
      [ALSA] fix HD audio ALC260 mono (un)mute
      [ALSA] fix alc880_test_mixer typo
      [ALSA] fix HD audio ALC882 lfe (un)mute

Komuro:
      [netdrvr] fix smc91c92_cs multicast bug

Linus Torvalds:
      Fix inequality comparison against "task->state"
      Avoid 'names_cache' memory leak with CONFIG_AUDITSYSCALL
      Use the new "kill_proc_info_as_uid()" for USB disconnect too
      Linux v2.6.14-rc4

Mark Haverkamp:
      [SCSI] aacraid: Greater than 2TB capacity support
      [SCSI] aacraid: aacraid: AIF preallocation (update)
      [SCSI] aacraid: handle AIF hotplug events (update)
      [SCSI] aacraid: error return checking
      [SCSI] aacraid: initialization timeout
      [SCSI] aacraid: fib size math fix
      [SCSI] aacraid: remove aac_insert_entry

Markus F.X.J. Oberhumer:
      i386: fix stack alignment for signal handlers

Martin Habets:
      [SPARC]: Remove some duplicated sparc32 config items

Michael Chan:
      [TG3]: Refine AMD K8 write-reorder chipset test.

Michael S. Tsirkin:
      [IB] mthca: Fix memory leak on device close

Nicolas Pitre:
      [ARM] 2951/1: fix wrong comment
      [ARM] 2952/1: fix a register clobber list
      [ALSA] remove bogus match method for ac97_bus
      [ALSA] remove redundent assignment to the ac97 device structure
      [ALSA] clean suspend/resume calls for ac97_bus_type
      [ARM] 2956/1: fix the "Fix gcc4 build errors in ucb1x00-core.c"

Oleg Nesterov:
      fix do_coredump() vs SIGSTOP race

Paolo 'Blaisorblade' Giarrusso:
      Uml: hide commands when not being verbose
      uml: add mode=skas0 as a synonym of skas0
      uml: allow building .s/.i/.lst files from userspace files
      uml: restore include breakage, breaking binary format of COW driver
      uml: cleanup byte order macros for COW driver
      uml: cleanup whitespace for COW driver

Paul Jackson:
      Document from line in patch format
      Document patch subject line better

Pavel Roskin:
      orinoco: Information leakage due to incorrect padding

Philippe De Muyter:
      tulip DC21143 rev 48 10Mbit HDX fix

Rafael J. Wysocki:
      x86_64: Set up safe page tables during resume

Ralf Baechle:
      [AX.25]: Fix packet socket crash

Randy Dunlap:
      ns83820: fix gfp flags type
      ieee80211: fix gfp flags type
      ieee80211: fix gfp flags type
      ns83820: fix gfp flags type
      sungem: fix gfp flags type
      [ATM]: fix sparse gfp nocast warnings
      [BONDING]: fix sparse gfp nocast warnings
      [CONNECTOR]: fix sparse gfp nocast warnings
      [DECNET]: fix sparse gfp nocast warnings
      [IPVS]: fix sparse gfp nocast warnings
      [NETFILTER]: fix sparse gfp nocast warnings
      [AF_KEY]: fix sparse gfp nocast warnings
      [RPC]: fix sparse gfp nocast warnings
      [TEXTSEARCH]: fix sparse gfp nocast warnings
      [XFRM]: fix sparse gfp nocast warnings

Ravikiran G Thirumalai:
      x86_64: Fix numa node topology detection for srat based x86_64 boxes

Richard Henderson:
      alpha: fix kernel alignment traps

Richard Purdie:
      [ARM] 2960/1: collie: Add missing scoop call parameters
      [ARM] 2961/1: corgi: Add missing include
      [ARM] 2962/1: scoop: Allow GPIO pin suspend state to be specified

Robert Olsson:
      [IPV4]: fib_trie root-node expansion

Roland Dreier:
      [IPoIB] Rename IPoIB's path_lookup() to avoid name clashes

Russell King:
      [ARM] Fix EBSA110 network driver link detection
      [ARM] Fix init printk for EBSA110 network driver, and link timer
      [NET]: Fix "sysctl_net.c:36: error: 'core_table' undeclared here"
      [MFD] Fix gcc4 build errors in ucb1x00-core.c
      [ARM] Update mach-types

Sascha Hauer:
      [ARM] 2949/1: Hynix h720x Run mode
      [ARM] 2950/1: i.MX gpio setup function
      [ARM] 2957/1: imx UART Error handling
      [ARM] 2958/1: fix definition in imx-regs.h

Sasha Khapyorsky:
      [ALSA] no templated index for mc97 controls
      [ALSA] no templated index for si3036 modem controls
      [ALSA] hda-codec - 'empty' generic mfg-only codec

Sridhar Samudrala:
      [SCTP] Fix SCTP socket options to work with 32-bit apps on 64-bit kernels.

Stephen Hemminger:
      skge: set mac address oops with bonding
      [TCP]: BIC coding bug in Linux 2.6.13

Steven Rostedt:
      pcmcia: fix task state at pccard thread exit

Sven Hartge:
      [SPARC64]: Fix compile error in irq.c

Sven Henkel:
      pmac/radeonfb: Add suspend support for M11 chip in new iBook 12"
      ppc32: Add new iBook 12" to PowerMac models table

Takashi Iwai:
      [ALSA] hda-intel - Disable DMA position auto-correction
      [ALSA] via82xx - Add a dxs whitelist entry
      [ALSA] Add iBook 1.33GHz support
      [ALSA] Fix confliction of capture controls on ALC880 test model
      [ALSA] via82xx - dxs_support entry for an ASUS mobo
      [ALSA] emu10k1 - Fix loading of SBLive Game board
      [ALSA] emu10k1 - Fix handling of ac97_chip=2
      [ALSA] ali5451 - Don't build non-existing modem PCM

Tom 'spot' Callaway:
      [SPARC32]: Enable generic IOMAP.
      [SPARC]: Fix p9100 framebuffer in 2.6

Tom Zanussi:
      relayfs: fix bogus param value in call to vmap

Ursula Braun:
      s390: qeth driver fixes

Vincent Sanders:
      [ARM] 2944/1: GCC 4 mx1ads serial driver compile fix
      [ARM] 2945/1: ARM fortunet fails to build because of missing include
      [ARM] 2965/1: defconfig for the ARM Spitz platform
      [ARM] 2966/1: defconfig for the ARM Poodle platform
      [ARM] 2967/1: defconfig for the ARM Corgi platform
      [ARM] 2968/1: defconfig for the ARM Collie platform

Wade Farnsworth:
      emac: add support for platform-specific unsupported PHY features

Wim Van Sebroeck:
      [WATCHDOG] pcwd_pci.c control status + boot-code clean-up
      [WATCHDOG] pcwd_pci.c add debug module_param

Yan Zheng:
      [IPV6]: Fix ipv6 fragment ID selection at slow path
      [MCAST] ipv6: Fix address size in grec_size

YOSHIFUJI Hideaki:
      [IPV6]: Fix infinite loop in udp_v6_get_port().
      [IPV6]: Fix NS handing for proxy/anycast address
