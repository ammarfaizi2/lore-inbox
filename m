Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030267AbVLSFR0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030267AbVLSFR0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 00:17:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030268AbVLSFR0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 00:17:26 -0500
Received: from dsl092-073-214.bos1.dsl.speakeasy.net ([66.92.73.214]:40073
	"EHLO kevlar.burdell.org") by vger.kernel.org with ESMTP
	id S1030267AbVLSFRZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 00:17:25 -0500
Date: Mon, 19 Dec 2005 00:16:59 -0500
From: Sonny Rao <sonny@burdell.org>
To: linux-kernel@vger.kernel.org
Cc: manfred@colorfullife.com, clameter@sgi.com, anton@samba.org,
       sonnyrao@us.ibm.com
Subject: cpu hotplug oops on 2.6.15-rc5
Message-ID: <20051219051659.GA6299@kevlar.burdell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(apologies if this is a dup)

Hi, I'm crashing 2.6.15-rc5 when I try and offline the last and only CPU in a node on a ppc64 Power5, SMT was disabled.

Here's the backtrace:

0:mon> t
[c0000001ad033820] c000000000096a7c .kfree+0x250/0x280
[c0000001ad0338d0] c00000000009a544 .cpuup_callback+0x238/0x5fc
[c0000001ad0339c0] c000000000068114 .notifier_call_chain+0x68/0x9c
[c0000001ad033a50] c0000000000789fc .cpu_down+0x1fc/0x368
[c0000001ad033b40] c0000000002ac658 .store_online+0x88/0xe8
[c0000001ad033bd0] c0000000002a6f14 .sysdev_store+0x4c/0x68
[c0000001ad033c50] c000000000110368 .sysfs_write_file+0x100/0x1a0
[c0000001ad033cf0] c0000000000be854 .vfs_write+0x100/0x200
[c0000001ad033d90] c0000000000bea64 .sys_write+0x54/0x9c
[c0000001ad033e30] c000000000008600 syscall_exit+0x0/0x18
--- Exception: c01 (System Call) at 000000000fe5ec10
SP (ffc4c4f0) is in userspace

0:mon> e
cpu 0x0: Vector: 300 (Data Access) at [c0000001ad033520]
    pc: c00000000048bd30: ._spin_lock+0x18/0x80
    lr: c000000000096a7c: .kfree+0x250/0x280
    sp: c0000001ad0337a0
   msr: 8000000000001032
   dar: 48
 dsisr: 40000000
  current = 0xc0000001aff12040
  paca    = 0xc0000000005c1000
    pid   = 17376, comm = bash


Should I try this with CONFIG_DEBUG_SLAB ?

Sonny
