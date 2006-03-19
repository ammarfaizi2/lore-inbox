Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932112AbWCSQZq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112AbWCSQZq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 11:25:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751513AbWCSQZq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 11:25:46 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:58889 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1751512AbWCSQZq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 11:25:46 -0500
Date: Sun, 19 Mar 2006 17:25:21 +0100
From: Willy Tarreau <willy@w.ods.org>
To: linux-kernel@vger.kernel.org
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Grant Coady <grant_lkml@dodo.com.au>
Subject: [ANNOUNCE] Linux-2.4.32-hf32.3
Message-ID: <20060319162521.GA17248@w.ods.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

here goes the third hotfix for 2.4.32 and older kernels. There are 12
new fixes (it's been one month and a half since hf32.2). Particularly,
you will find a fix for CVE-2005-3180 and another one for a local DoS
affecting ELF on Intel x86_64. Exceptionnaly, a fix has been brought
to two drivers, orinoco (which was the subject of the CVE) and E1000
which can crash the kernel by simply moving the cable. Others are
fixes for build and minor bugs.

The full changelog is appended to this mail.

Please use the links below to download it :

    hotfixes home : http://linux.exosec.net/kernel/2.4-hf/
     last version : http://linux.exosec.net/kernel/2.4-hf/LATEST/LATEST/
         RSS feed : http://linux.exosec.net/kernel/hf.xml
    build results : http://bugsplatter.mine.nu/test/linux-2.4/ (Grant's site)

Also, I've moved the project to GIT and new patches will be available here
waiting for next release :

       GIT: http://w.ods.org/kernel/2.4/patches-2.4-hf.git/
    GITWEB: http://w.ods.org/git/?p=patches-2.4-hf.git;a=summary

Regards,
Willy


Changelog from 2.4.32-hf32.2 to 2.4.32-hf32.3
---------------------------------------
'+' = added ; '-' = removed

+ 2.4.32-orinoco-cve-2005-3180-information-leakage-1                 (horms)

  Fix for CVE-2005-3180 by Alan Cox, back-ported by Horms. Fixes
  and etherleak bug in the orinoco driver. As yet untested.

+ 2.4.32-x86_64-check-for-bad-elf-entry-address-1               (andi kleen)

  Fixes a local DOS on Intel systems that lead to an endless recursive
  fault. AMD machines don't seem to be affected. Actually based on a
  2.6 patch by Suresh Siddha, but the 2.4 implementation is somewhat
  different.

+ 2.4.32-information-leak-in-SO_ORIGINAL_DST-and-getname-1 (pavel kankovsky)

  It appears sockaddr_in.sin_zero is not zeroed during certain operations
  returning IPv4 socket names : getsockopt(...SO_ORIGINAL_DST...),
  getsockname() and getpeername().

+ 2.4.32-e1000-do-not-call-msec_delay-in-irq-context-1    (jesse brandeburg)

  There are some functions that are called in irq context that need to use
  msec_delay_irq instead to avoid a BUG.

+ 2.4.32-fix-overflow-in-inode-1                              (Rik van Riel)

  The following patch fixes an overflow in inode.c. This overflow can cause
  a system to stop reclaiming inodes, with a large amount of memory and
  zillions of inodes. This has caused systems to run out of low memory in
  real world situations. Thanks go out to Larry Woodman, as well as the
  unnamed customer who first tracked this problem down.

+ 2.4.32-make-kernel-work-on-i486-again-1                  (jacek lipkowski)

  Booting the 2.4.32 kernel compiled for a i486 on an i486 box fails,
  because "Kernel compiled for Pentium+, requires TSC feature!" (printed
  from check_config() include/asm-i386/bugs.h).

+ 2.4.32-ppc64-fix-sys_rt_sigreturn-return-type-1         (stephen rothwell)

  Paul Mackerras noticed that sys_rt_sigreturn's return value was "int".
  It needs to be "long" or else the return value of a syscall that is
  interrupted by a signal will be truncated to 32 bits and then sign
  extended. This causes .e.g mmap's return value to be corrupted if it
  is returning an address above 2^31 (which is what caused a SEGV in
  malloc). This problem obviously only affects 64 bit processes.

+ 2.4.32-ip_queue-fix-wrong-skb-len-nlmsg_len-assumption-1     (thomas graf)

  The size of the skb carrying the netlink message is not equivalent to the
  length of the actual netlink message due to padding. ip_queue matches the
  length of the payload against the original packet size to determine if
  packet mangling is desired, due to the above wrong assumption arbitary
  packets may not be mangled depening on their original size.

+ 2.4.32-drm_stub_open-range-checking-1                        (marin mitov)

  Xorg-6.9.0 SIGSEGFAULTs when the loading of dri module is enabled (direct
  rendering). Xorg-6.9.0 (and evidently not the previous versions) has
  defined DRM_MAX_MINOR as 255 (and Xorg-6.9.0 tries to open all of them)
  while in the kernel:  DRM_STUB_MAXCARDS is defined as 16.

+ 2.4.32-sparc-fix-compile-failures-in-math-emu-1             (david miller)

  Kill debugging default switch cases in do_one_mathemu(). That case is
  handled properly already and gcc hates the empty statement that results
  when the debug code is disabled. Pointed out by kaffe.

+ 2.4.32-alpha-fix-recursive-inlining-failure-pci_iommu-1   (solar designer)

  Building on alpha with gcc 3.4.5 fails because of recursive inlining.
  Simply removing the "inline" from the declaration of sg_fill() makes
  it build and work.

+ 2.4.32-build-fix-auto_fs4-changes-broke-ppc64-build-1   (jesse brandeburg)

  This patch adds a couple of #include statements verified to fix the
  compile for ppc64 and probably will fix the compile on parisc. ppc64
  would not build without this fix.

----

