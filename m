Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266297AbTAJUTj>; Fri, 10 Jan 2003 15:19:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266354AbTAJUTi>; Fri, 10 Jan 2003 15:19:38 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:19727 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266297AbTAJUTc>; Fri, 10 Jan 2003 15:19:32 -0500
Date: Fri, 10 Jan 2003 12:26:56 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux v2.5.56
Message-ID: <Pine.LNX.4.44.0301101222510.1856-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Trying to make releases slightly more often and slightly smaller.

ACPI, USB, networking (mainly netfilter) updates. Some syscall path
updates and a thread bug in mm_release() that would miss updating the TID
and cause a few extra traps at exec time.

And a watchdog forward port from 2.4.x by DaveJ.

			Linus

----
Summary of changes from v2.5.55 to v2.5.56
============================================

<blueflux@koffein.net>:
  o [IPV4 ROUTE]: Fix some sysctl documentation

<gandalf@wlug.westbo.se>:
  o [NETFILTER]: Fix a locking bug in ip_conntrack_proto_tcp

<kadlec@blackhole.kfki.hu>:
  o [NETFILTER]: Fix excess logging of reused FTP expectations

<marcus@ingate.com>:
  o [NETFILTER]: ipt_multiport invert fix

<mulix@mulix.org>:
  o fix "assignment from incompatible pointer type"

<neilt@slimy.greenend.org.uk>:
  o USB Serial patch for old pl2303 devices

<netfilter@interlinx.bc.ca>:
  o [NETFILTER]: UDP nat helper support

<pablo@menichini.com.ar>:
  o 2.5.54 dev_*(&<dev>,...): drivers/usb/input/pid.c

Alan Cox <alan@lxorguk.ukuu.org.uk>:
  o more unusual USB storage devices

Anders Gustafsson <andersg@0x63.nu>:
  o [IPV6]: cleanup_ipv6_mibs cannot be __exit, since it is called on
    the ipv6_init error path

Andrew Morton <akpm@digeo.com>:
  o [NET]: Uninline skb_headerinit
  o [AF_UNIX]: Uninline unix_get_socket/maybe_unmark_and_push, mark
    {pop,empty}_stack static
  o [UNIX]: Uninline unix_peer_get
  o [IPSEC]: Uninline _decode_session
  o [IPV4 ROUTE]: Uninline rt_hash_code and rt_may_expire
  o [IPV4 OUTPUT]: Uninline ip_finish_output and skb_fill_page_desc
  o [IPV4 FRAG]: Uninline ipq_kill
  o [IPV4 FIBHASH]: extern inline --> static inline
  o [IPV4 TCP]: Dont export or inline __tcp_put_port, but do inline
    tcp_put_port
  o [IPV4 TCP]: Uninline tcp_rtt_estimator and tcp_urg.  extern inline
    --> static inline

Andy Grover <agrover@groveronline.com>:
  o ACPI: Use printk instead of pr_debug (Randy Dunlap)
  o ACPI: Remove typedefs in favor of using "struct" and "union"
    explicitly
  o ACPI: Expose lid state to userspace (Zdenek OGAR Skalak)
  o ACPI: Make button functions static (Pavel Machek)
  o ACPI: Express state of lid in words, not a number
  o cpufreq-ACPI: no longer use CPUFREQ_ALL_CPUS (Dominik Brodowski)
  o ACPI: Eliminate spawning of thread from timer callback. Use
    schedule_work for all cases. Thanks to Ingo Oeser, Andrew Morton,
    and Pavel Machek for their wisdom.
  o ACPI: Update version string to 20030109

Dave Jones <davej@codemonkey.org.uk>:
  o [WATCHDOG] wdt_pci nowayout fixes from 2.4
  o [WATCHDOG] eurotech indentation fixes
  o [WATCHDOG] eurotech nowayout fixes from 2.4
  o [WATCHDOG] wdt nowayout changes from 2.4
  o [WATCHDOG] wdt977 nowayout fixes from 2.4
  o c99 initialisers
  o [WATCHDOG] Add several new watchdog drivers from 2.4
  o [WATCHDOG] pcwd driver update from 2.4
  o [WATCHDOG] acquirewdt nowayout fixes from 2.4 (plus some
    CodingStyle reformatting)
  o [WATCHDOG] Acquirewdt C99 struct initialisers
  o [WATCHDOG] Advantech fixes from 2.4
  o [WATCHDOG] simplify advwdt_open, and add C99 struct initialisers
  o [WATCHDOG] Fix up incorrect C99 struct conversion
  o [WATCHDOG] acquirewdt compile fixes
  o [WATCHDOG] advantech compile fixes
  o [WATCHDOG] ALIM7101 fixes from 2.4 + C99 structs
  o [WATCHDOG] More alim7101 cleanups
  o [WATCHDOG] i810-tco fix from 2.4
  o [WATCHDOG] ib700wdt fixes from 2.4
  o [WATCHDOG] ib700wdt c99 structs
  o [WATCHDOG] indydog nowayout fixes from 2.4
  o [WATCHDOG] machzwd nowayout fixes from 2.4
  o [WATCHDOG] mixcomwd nowayout fixes from 2.4
  o [WATCHDOG] pcwd nowayout fixes from 2.4
  o [WATCHDOG] sbc60xxwdt nowayout fixes from 2.4
  o [WATCHDOG] SC1200WDT nowayout fixes from 2.4
  o [WATCHDOG] SC520 nowayout fixes from 2.4
  o [WATCHDOG] C99 struct initialisers for shwdt
  o [WATCHDOG] softdog nowayout fixes from 2.4
  o [WATCHDOG] w83877f nowayout fixes from 2.4
  o [WATCHDOG] nowayout fixes for wafer5823

David Brownell <david-b@pacbell.net>:
  o ehci, remove potential hangs
  o zaurus B500 (sl-5600?) & usbnet
  o 2.5.54 -- ohci-dbg.c: 358: In function `show_list': `data1'
  o usbtest, covers control queueing and fault cleanup

David S. Miller <davem@nuts.ninka.net>:
  o [SUNZILOG]: Adapt sun4u get_zs for Peters new scanning scheme
  o [CRYPTO]: Fix typo in aes.o rule
  o [NET]: Kill __tcp_put_port module export
  o [TCP]: Fix tcp_put_port declaration
  o [IPSEC]: Dont check algorithm availability unless CONFIG_CRYPTO
  o [IPSEC]: Kill warning in xfrm_algo.c
  o [CRYPTO]: Use appropriate defaults if AH/ESP is enabled
  o [SUNZILOG]: Fix uart_get_baud_rate args
  o [AIC7XXX]: Include asm/io.h, necessary to get at inb/outb/etc
  o [SPARC64]: Update defconfig

Duncan Sands <baldrick@wanadoo.fr>:
  o USB: atmsar is not a module
  o USB: speedtouch missing __init and __exit
  o USB: speedtouch: add GPL notices

Duncan Sands <duncan.sands@math.u-psud.fr>:
  o USB: speedtouch: remove version string duplication

Erich Focht <efocht@ess.nec.de>:
  o small migration thread fix

Filip Sneppe <filip.sneppe@cronos.be>:
  o [NETFILTER]: ip_conntrack_ftp.c, fixes a typo in a DEBUG statement

Gabriel Paubert <paubert@iram.es>:
  o 'iret' segment fixup

Greg Kroah-Hartman <greg@kroah.com>:
  o USB: revert davem's compile time fix, now that it's fixed properly
  o USB brlvger: Forward port 2.4 fix for misuse of types
  o USB: removed MOD_INC_USE_COUNT and MOD_DEC_USE_COUNT from driver
    that do not need it
  o USB printer driver: forward port 2.4 fix for misuse of types
  o USB mdc800: forward port 2.4 fix for misuse of types
  o DEV: change dev_printk() to take a pointer to dev instead of the
    structure itself
  o USB: drivers/usb/core/ fixups due to dev_printk change
  o USB: drivers/usb/host/ fixups due to dev_printk change
  o USB: drivers/usb/serial/ fixups due to dev_printk change
  o USB serial: pass the usb_device_id to the probe() function
  o USB serial: fixup for probe function paramaters changing
  o USB: fix ehci build for older versions of gcc

Harald Welte <laforge@gnumonks.org>:
  o [NETFILTER]: This patch fixes the ULOG target when logging packets
    without any ethernet header (mac address).

Henning Meier-Geinitz <henning@meier-geinitz.de>:
  o scanner.c: fix race in ioctl_scanner()
  o USB scanner driver: updated documentation
  o USB scanner driver: updated Kconfig
  o scanner.c, scanner.h: Added vendor/product ids
  o scanner.c: print user-supplied ids only on start-up
  o scanner.c, scanner.h: Remove PV8630 ioctls
  o [PATCH 2.5.54] scanner.c: endpoint detection cleanup
  o scanner.c, scanner.h: Use symbolic name for interface class

James Morris <jmorris@intercode.com.au>:
  o [IPSEC]: Clean up key manager algorithm handling
  o [CRYPTO]: Add AES algorithm
  o [SUNSAB]: Comment out powering down of chip for now
  o [CRYPTO]: More credits for AES

Linus Torvalds <torvalds@home.transmeta.com>:
  o Fix exec_mmap() to release the MM while we still have it active, to
    properly de-activate it and make the child_tid logic work
    correctly.
  o Fix kallsyms symbol lookup code. Let's do this trivial
    one-character version before looking at more complicated changes.
  o Make psmouse driver _much_ more lenient about packet data timeouts

Luca Barbieri <ldb@ldb.ods.org>:
  o Use %ebp rather than %ebx for thread_info pointer
  o Remove all register pops before sysexit

Matthew Dharm <mdharm-usb@one-eyed-alien.net>:
  o USB storage: remove usb_stor_tranfer_length()

Oliver Neukum <oliver@neukum.name>:
  o USB: kaweth freeing skbs

Patrick McHardy <kaber@trash.net>:
  o [NETFILTER]: Fix ipt_REJECT udp checksums
  o [NETFILTER]: Fix incremental TCP checksum in ECN module

Paul Mackerras <paulus@samba.org>:
  o PPC32: Add support for the IBM PPC 405GPR-based "Sycamore" board
  o PPC32: Handle machine checks on 4xx processors better

Petko Manolov <petkan@users.sourceforge.net>:
  o USB pegasus: small patch for 2.5
  o again rtl8150

Rob Radez <rob@osinvestor.com>:
  o [SPARC32]: Copy over sparc64 exception table changes

Robert Olsson <robert.olsson@data.slu.se>:
  o [NAPI]: Discuss some more issues in driver HOWTO

Russell King <rmk@flint.arm.linux.org.uk>:
  o [SERIAL] Add prototypes and rename UPF_FLAGS
  o [SERIAL] Remove unused info->event
  o [SERIAL] Convert change_speed() to settermios()
  o [SERIAL] Change settermios to set_termios
  o [SERIAL] Bug fix: remove infinite loop in sa1100 serial driver
  o [SERIAL] Restrict the baud rates returnable from
    uart_get_baud_rate()
  o [SERIAL] Fix build errors caused in previous cset

Stephen Rothwell <sfr@canb.auug.org.au>:
  o [COMPAT]: Sparc64 use get/put compat_timespec

Tom Rini <trini@kernel.crashing.org>:
  o PPC32: Default to 768MB of lowmem


