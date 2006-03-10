Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751964AbWCJRio@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751964AbWCJRio (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 12:38:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751983AbWCJRio
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 12:38:44 -0500
Received: from mx1.suse.de ([195.135.220.2]:32665 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751964AbWCJRin (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 12:38:43 -0500
Date: Fri, 10 Mar 2006 18:38:42 +0100
From: Olaf Hering <olh@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.6.16-rc5-git14 crash in spin_bug on ppc64
Message-ID: <20060310173842.GA14924@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I got this crash while hunting some other bug. dualcore 970mp. 

Welcome to SUSE Linux Enterprise Server 9.90 Beta7 (ppc) - Kernel 2.6.16-rc5-git
14-ppc64-defconfig (console).


wels login: BUG: spinlock bad magic on CPU#1, gdm/4568
cpu 0x1: Vector: 300 (Data Access) at [c0000000f3c2f5c0]
    pc: c00000000020a7ec: .spin_bug+0x94/0x100
    lr: c00000000020a7cc: .spin_bug+0x74/0x100
    sp: c0000000f3c2f840
   msr: 8000000000009032
   dar: ffff000000000104
 dsisr: 40000000
  current = 0xc0000000f916e040
  paca    = 0xc0000000005ddd00
    pid   = 4568, comm = gdm
enter ? for help
1:mon> t
[c0000000f3c2f8d0] c00000000020aa64 ._raw_spin_lock+0x40/0x164
[c0000000f3c2f960] c00000000048bff4 ._spin_lock+0x10/0x24
[c0000000f3c2f9e0] c0000000000a28b0 .anon_vma_link+0x30/0x74
[c0000000f3c2fa70] c00000000005540c .dup_mm+0x244/0x4a8
[c0000000f3c2fb40] c00000000005658c .copy_process+0x930/0xff4
[c0000000f3c2fcb0] c000000000056d34 .do_fork+0xe4/0x244
[c0000000f3c2fdc0] c00000000000f440 .sys_clone+0x5c/0x74
[c0000000f3c2fe30] c000000000008950 .ppc_clone+0x8/0xc
--- Exception: c00 (System Call) at 000000000f202918
SP (ff829160) is in userspace
1:mon>

This kernel was booted serveral times.
