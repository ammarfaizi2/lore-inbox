Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264540AbTFQEV5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 00:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264535AbTFQEVw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 00:21:52 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:7182 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S264540AbTFQEVk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 00:21:40 -0400
Date: Mon, 16 Jun 2003 21:35:09 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux v2.5.72 and a move to OSDL
Message-ID: <Pine.LNX.4.44.0306162131350.1644-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by deepthought.transmeta.com id h5H4Z9B19152
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, I waited too long for 2.5.71, so here's a more timely 2.5.72
release. 

It's extra timely largely because the hash list poisoning found some
problems in the RPC code, making NFS break.  Trond found and fixed the
breakage, so 2.5.72 should work fine in an NFS environment too.  Let's
see if the list poisoning shows any other dodgy list users.  Knock wood. 

Also, Arnaldo has cleaned up a lot of the networking code to use the
generic hash lists, instead of the old ad-hoc net-specific list walking
code.  That code has been tested pretty well, but please holler if you
see something. 

Changelog for other details appended.

The other big news - well, for me personally, anyway - is that I've
decided to take a leave-of-absense after 6+ years at Transmeta to
actually work full-time on the kernel. 

Transmeta has always been very good at letting me spend even an
inordinate amount of time on Linux, but as a result I've been feeling a
little guilty at just how little "real work" I got done lately.  To fix
that, I'll instead be working at OSDL, finally actually doing Linux as
my main job. 

[ I do not expect a huge amount of change as a result, testament to just
  /how/ freely Transmeta has let me do Linux work.  My email address will
  change to "torvalds@osdl.org" effective July 1st, but everybody is
  trying to make the transfer as smooth as possible, so we'll make sure
  that there will be sufficient address overlap etc to not cause any
  problems ]

OSDL and Transmeta will have a joint official (read: "boring".  You
should have seen the bio - that didn't make it - that I suggested for
myself for it ;) press-release about this tomorrow morning, but I just
wanted to say thanks to Transmeta.  It has been a special place to work
for, and hello to OSDL that I hope will be the same. 

Snif.  I'm actually all teary-eyed. 


			Linus

----


Summary of changes from v2.5.71 to v2.5.72
============================================

Alexey Kuznetsov:
  o [IPV4]: More sane rtcache behavior

Andi Kleen:
  o Fix typo in timing changes + support for x86-64
  o Fix compilation of 32bit ioctl emulation on x86-64
  o Minor 32bit compatibility fix for /dev/rtc
  o x86-64 merge
  o Fix over-alignment problem on x86-64

Andrew Morton:
  o fix deadlock over proc_lock
  o NUMA fixes
  o compat_ioctl fixes
  o Unisys ES7000 platform subarch 1/2: generic bits
  o Unisys ES7000 2/2: platform subarch
  o pcips2.c compile fix
  o Some clean up of the time code
  o More time clean up stuff
  o fix architecture do_settimeofday() for new API
  o arcnet oops fix
  o remove anon_hash_chain
  o tmpfs: revert license to 2.4 version
  o dm: Repair persistent minors
  o make pid_max readable
  o Fix sign handling bugs in various drivers
  o Parenthesisation fix in drivers
  o efs typo fix
  o new eepro100 PDI ID

Anton Blanchard:
  o fix compat_sys_getrusage

Arnaldo Carvalho de Melo:
  o [NET]: net/core/flow.c needs linux/cpu.h
  o list.h: implement hlist_for_each_entry_{from,continue}
  o net: use hlist for struct sock hash lists
  o tcp: convert struct tcp_bind_bucket to hlist
  o tcp: convert tcp_tw_bucket->tw_death* to hlist
  o af_unix: remove typedef unix_socket, use plain struct sock

Bartlomiej Zolnierkiewicz:
  o ide: bring non-taskfile code back
  o ide: Power Management
  o ide: move "config IDE" to drivers/ide/Kconfig

Brian Gerst:
  o small cleanup for powernow-k7

Christoph Hellwig:
  o [NET]: Move iph5526_probe to initcalls

Daniel Ritz:
  o [PCMCIA] fix yenta unload oops

David S. Miller:
  o [BLUETOOTH]: Remove unused local var in rfcomm/tty.c
  o [TCP]: Make sure tcp_tw_bucket tw_daddr is aligned properly
  o [TCP]: Use proper time_*() comparisons on jiffies
  o [DECNET]: Fix bogus pointer cast to int
  o [SPARC64]: Update sys32_settimeofday for do_settimeofday() changes
  o [SPARC64]: Update defconfig
  o [SPARC64]: Merge sysinfo32 corrections from ppc64 port

Dominik Brodowski:
  o [PCMCIA] Remove stale structure definition
  o [PCMCIA] Fix class device name
  o [PCMCIA] Move socket /proc to sysfs
  o [PCMCIA] move creation of /proc/pccard to ds.c
  o [PCMCIA] Remove inquire_socket

François Romieu:
  o resync of dscc4 driver with 2.4.x version

Greg Ungerer:
  o DragonEngine board name change
  o conditional ROMfs copy for M5206eLITE board
  o remove 68328 arch specific irq init
  o ColdFire serial driver fixups

Helge Deller:
  o input: Turn on the NumLock ON by default on PARISC HP-HIL machines

Hideaki Yoshifuji:
  o [IPSEC]: Fix xfrm_alloc_spi() always selecting minspi

Hiroshi Miura:
  o input: Add default mapping for the hiragana/katakana key

Ivan Kokshaysky:
  o [ALPHA] Fix Jensen PCI domains warning
  o alpha osf_settimeofday fix

Kazunori Miyazawa:
  o [IPV6]: Fix ipv6 header handling of AH input

Linus Torvalds:
  o Fix up missing header files

Matthew Dharm:
  o unusual_devs fixups

Matthew Wilcox:
  o [NET]: Kill extraneous CONFIG_{NET,KMOD} in net/socket.c
  o parisc arch update

Mikael Pettersson:
  o local APIC blacklist rules updates
  o local APIC driver model cleanups

Paul Mackerras:
  o PPC32: Fix pci_domain_nr()
  o PPC32: only define cond_syscall if it isn't already defined
  o PPC32: Update the defconfigs
  o PPC32: vmlinux.lds.S cleanup + discard .exitcall.exit sections
  o fix weird kmalloc bug
  o [NET]: Use unregister_netdev() in ppp

Paul Mundt:
  o Fix PCI hotplug path for SH
  o Add mach-type generation for SH

Peter Chubb:
  o input: The appended fix is needed on I2000 machines, to map the
    legacy ISA interrupt onto the actual interrupt provided.  Otherwise
    the mouse and keyboard won't work.  Patch against 2.5.70.

Peter Osterlund:
  o input: fix some minor errors found in the input-programming.txt
    file
  o input: Add Synaptics touchpad absolute mode support

Ravikiran G. Thirumalai:
  o [DECNET]: Fix signedness error in dm_ioctl()
  o [TUN]: Fix signedness error in tun_get_user()

Richard Henderson:
  o [ALPHA] Update Jensen call to ide_register_hw

Rik van Riel:
  o [NET]: Fix error message when registering IGMP

Robert Olsson:
  o [IPV4]: Add rtcache hash lookup statistics to rtstat
  o [IPV4]: In rt_intern_hash, reinit all state vars on branch to
    "restart"

Roman Zippel:
  o Clean up kernel parameter array declaration

Russell King:
  o input: PCI PS/2 keyboard and mouse controller (Mobility Docking
    station)
  o [PCMCIA] Remove inquire_socket method from sa11xx_core.c
  o [PCMCIA] Prevent class_device related oops

Rusty Russell:
  o clean up overzealous deprecated warning

Samuel Thibault:
  o Fix ma600.c compile

Sergey Vlasov:
  o hid: fix HID feature/output report writing to devices. This should
    fix most problems with UPS shutdown.
  o hid: Add missing 'return 0's in hiddev ioctl handler

Stelian Pop:
  o sonypi driver update
  o meye driver update

Stephen Hemminger:
  o [NET]: Convert SLIP driver to alloc_netdev
  o [NET]: Network hotplug via class_device/kobject
  o [NET]: Fix spurious kfree and missed initialization in TUN driver

Trond Myklebust:
  o Fix rpc dentry list usage

Ville Nuorvala:
  o [IPV6]: Fix refcount leaks in udpv6_connect()

Vojtech Pavlik:
  o input: fix sunkbd to properly set its bitfields up to key #127
  o input: Add key definitions for HP-HIL keyboards
  o input: Change input/misc/pcspkr.c to use CLOCK_TICK_RATE instead of
    a fixed value of 1193182. And change CLOCK_TICK_RATE and several
    usages of a fixed value 1193180 to a slightly more correct value

Zephaniah E. Hull:
  o input: Implement input device grabbing so that it is possible to
    steal an input device from other handlers and have an exclusive
    access to events.
  o input: Implement a HID quirk for 2-wheel A4Tech mice


