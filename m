Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264423AbTLLDhm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 22:37:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264430AbTLLDhl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 22:37:41 -0500
Received: from waste.org ([209.173.204.2]:4568 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S264423AbTLLDhf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 22:37:35 -0500
Date: Thu, 11 Dec 2003 21:37:34 -0600
From: Matt Mackall <mpm@selenic.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] -tiny tree for small systems (2.6.0-test11)
Message-ID: <20031212033734.GG23787@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the first release of a new kernel tree dubbed '-tiny' (someone
already took -mm). The aim of this tree is to collect patches that
reduce kernel disk and memory footprint as well as tools for working
on small systems, an area Linux mainstream has been moving away from
since Linus got a real job. Target users are things like embedded
systems, small or legacy desktop folks, and handhelds.

To get the ball rolling, I've thrown in about 50 patches that trim
various bits of the kernel, almost all configurable, and a fair number
may eventually be appropriate for mainline. All the config options are
currently thrown under CONFIG_EMBEDDED and many of the minor tweaks
are covered under a set of config options called CONFIG_CORE_SMALL,
CONFIG_NET_SMALL, and CONFIG_CONSOLE_SMALL.

Nifty things I've included:
 - building with -Os
 - 4k process stacks (via -wli)
 - configurable removal of printk, BUG, and panic() strings
 - configurable HZ
 - configurable support for vm86, core dumps, kcore, sysfs, aio, etc.
 - a very nice kmalloc auditing system via /proc/kmalloc
 - auditing of bootmem usage
 - a system for counting inline instantiations
 - my netpoll/netconsole patches
 - my drivers/char/random fixups

Some items on my todo list:
 - borrow kgdb from -mm
 - merge my netpoll-based kgdb-over-ethernet
 - pageable kernel memory for a select subset of the kernel
 - reduced functionality vt for small gui systems
 - generic lookup/hash management code

How small is -tiny? It's hard to quantify as it's all configurable and
some functionality is more important than others, but my current test
config has full IPv4 net stack and most other important functionality
and will boot comfortably on a 4M x86 box with about 2M
free+buffers+cache.

Bug reports, suggestions, and patch submissions are welcome!

The patch, currently against 2.6.0-test11, can be found at:

 http://selenic.com/tiny/


Full patch list:

# netpoll
#
netpoll-core.patch
tg3-poll.patch
netconsole.patch
#
# random
#
debug-cleanup.patch
fix-random-wait.patch
kill-pool-resize.patch
kill-getstate.patch
pool-rename.patch
pool-init.patch
kill-extract-secondary.patch
bug-on-grb.patch
extract-min-max.patch
debit-entropy.patch
reserved-in-struct.patch
nonblocking-pool.patch
kill-extract-state.patch
kill-md5.patch
kill-sha-variants.patch
random-waitqueue.patch
shrink-random.patch
ln-to-fls.patch
random-sched-clock.patch
kill-rotate.patch
kill-batching.patch
random-credit.patch
tiny-syncookie.patch
static-rnd-pools.patch
#
# akpm
#
gcc-Os-if-embedded.patch
fix-sqrt.patch
scale-min_free_kbytes.patch
config_spinline.patch
#
# new
# 
tiny-extraversion.patch
core-small.patch
config-net-small.patch
console-small.patch
deprecate-inline.patch
audit-bootmem.patch
kmalloc-accounting.patch
change-hz.patch
remove-vm86.patch
ide-hwif.patch
tiny-crc.patch
no-doublefault.patch
nosysfs.patch
tg3-oops.patch
hash-sizes.patch
ether-queue.patch
cache_defer_hash.patch
con_buf.patch
serial-pci.patch
vprintk.patch
kill-ext2-error-buff.patch
kill-ext3-error-buff.patch
kill-printk.patch
tiny-bug.patch
tiny-panic.patch
rolled-md4.patch
kill-ext3-md4.patch
no-elf-core.patch
no-kcore.patch
max-swapfiles.patch
user-hash.patch
futex-queues.patch
proc_alloc_map.patch
ldiscs.patch
tvec_bases.patch
dmi_blacklist.patch
no-translations.patch
unix_socket_table.patch
bh_wait_queue_heads.patch
major_names.patch
chrdevs.patch
pid-max.patch
roll-inflate-crc.patch
no-aio.patch
max_user_rt_prio.patch
ethtool.patch
4k-stacks.patch

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
