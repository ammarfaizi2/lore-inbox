Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264929AbTLREOO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 23:14:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264930AbTLREOO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 23:14:14 -0500
Received: from fw.osdl.org ([65.172.181.6]:29619 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264929AbTLREOH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 23:14:07 -0500
Date: Wed, 17 Dec 2003 20:14:06 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.6.0
Message-ID: <Pine.LNX.4.58.0312171951030.5789@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


				"The beaver is out of detox"
						- Anon

This should not be a big surprise to anybody on the list any more, since
we've been building up to it for a long time now, and for the last few
weeks I haven't accepted any patches except for what amounts to fairly
obvious one-liners.

Anyway, 2.6.0 is out there now, and the patch from -test11 is a swelte 
11kB in size. It's not the totally empty patch I was hoping for, but 
judging by the bugs I worked on personally, things are looking pretty 
good. 

To give you an example, one of the nastier bugs that we chased for the 
last five weeks was a bug that could only be reproduced reliably on a 
16- or 32-way system, and only when the system had flaky disks. Putting in 
known-good disks made the problem disappear. Similarly, compiling the 
kernel with another compiler made the problem disappear.

It turned out to be a really subtle bug wrt SMP ordering and stack
allocation, and lots of thanks to Ram Pai for gathering all the
information that eventually led to it being fixed. The fix was a one-liner
and a big comment - but my point is that the quality of bugs has been
pretty high lately, and we feel that we're in pretty good shape.

Andrew has written up some caveats and pointers to information about 2.4.x
vs 2.6.x changes, and I'll let him post that. Some known issues were not
considered to be release-critical and a number of them have pending fixes
in the -mm queue. Generally they just didn't have the kind of verification
yet where I was willing to take them in order to make sure a fair 2.6.0
release.

NOTE! I'll continue to keep track of the 2.6 BK tree until we're closer to
the time when we literally split it for 2.7.x, because both Andrew and I
are pretty comfortable with our respective toolchains. But Andrew is the
stable tree maintainer, so everything should be approved by him at this
point. Think of the -mm tree as the staging area, and mine as a release
tree. We'll work together, but Andrew is boss.

(BK merging will have to go through some approval format, we'll see how
that works out exactly).

		Linus

---

Summary of changes from v2.6.0-test11 to v2.6.0
============================================

Alan Stern:
  o USB: fix bug not setting device state following usb_device_reset()

Andrey Borzenkov:
  o USB: prevent catch-all USB aliases in modules.alias

Arnaldo Carvalho de Melo:
  o [IPV6]: Fix TCP socket leak

David Brownell:
  o USB: fix remove device after set_configuration

David S. Miller:
  o [NETFILTER]: In conntrack, do not fragment TSO packets by accident
  o [PKT_SCHED]: Do not dereference the special pointer value 'HTB_DIRECT'

Greg Kroah-Hartman:
  o USB: register usb-serial ports in the proper place in sysfs
  o USB: fix race with hub devices disconnecting while stuff is still
    happening to them
  o USB: fix bug for multiple opens on ttyUSB devices
  o kobject: fix bug where a parent could be deleted before a child
    device

Harald Welte:
  o [NETFILTER]: Sanitize ip_ct_tcp_timeout_close_wait value, from 2.4.x

Herbert Xu:
  o USB: Fix connect/disconnect race

Hideaki Yoshifuji:
  o [IPV6]: Fix ipv4 mapped address calculation in udpv6_sendmsg()

Hirofumi Ogawa:
  o Missing initialization of /proc/net/tcp seq_file

Ingo Molnar:
  o Fix lost wakeups problem
  o Fix /proc access to dead thread group list oops

James McMechan:
  o tmpfs oops fix

Jean Delvare:
  o I2C: fix i2c_smbus_write_byte() for i2c-nforce2

Jeff Garzik:
  o fix use-after-free in libata
  o fix oops on unload in pcnet32
  o remove manual driver poisoning of net_device
  o wireless airo oops fix

Jens Axboe:
  o fix broken x86_64 rdtscll
  o scsi_ioctl memcpy'ing user address
  o no bio unmap on cdb copy failure
  o Fix IDE bus reset and DMA disable when reading blank DVD-R
  o CDROM_SEND_PACKET bug

Jes Sorensen:
  o qla1280 crash fix in error handling

Julian Anastasov:
  o [BRIDGE]: Provide correct TOS value to IPv4 routing

Linus Torvalds:
  o Fix x86 kernel page fault error codes
  o Fix ide-scsi.c uninitialized variable
  o Fix the PROT_EXEC breakage on anonymous mmap
  o Fix subtle bug in "finish_wait()", which can cause kernel stack
    corruption on SMP because of another CPU still accessing a
    waitqueue even after it was de-allocated.
  o More subtle SMP bugs in prepare_to_wait()/finish_wait()
  o Fix thread group leader zombie leak

Martin Devera:
  o [PKT_SCHED]: In HTB, filters must be destroyed before the classes

Matthew Dharm:
  o USB storage: fix for jumpshot and datafab devices

Neil Brown:
  o Fix possible bio corruption with RAID5

Oliver Neukum:
  o USB: fix sleping in interrupt bug in auerswald driver
  o USB: fix race with signal delivery in usbfs

Pavlin Radoslavov:
  o [RTNETLINK]: Add RTPROT_XORP

René Scharfe:
  o HPFS: missing lock_kernel() in hpfs_readdir()

Tom Rini:
  o USB: mark the scanner driver as obsolete

Ulrich Drepper:
  o Fix 'noexec' behaviour
