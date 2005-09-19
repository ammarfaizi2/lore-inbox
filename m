Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932565AbVISStb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932565AbVISStb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 14:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932567AbVISStb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 14:49:31 -0400
Received: from adsl-static-1-49.uklinux.net ([62.245.36.49]:54467 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S932565AbVISSta (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 14:49:30 -0400
Subject: 2.6.13-rt13 SMP crashes on boot
To: linux-kernel@vger.kernel.org
From: John Rigg <lk@sound-man.co.uk>
Message-Id: <E1EHQmY-0001MS-8L@localhost.localdomain>
Date: Mon, 19 Sep 2005 19:54:26 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been trying to get 2.6.13 with RT-preempt patch to run on my
dual Opteron with debugging code (with CONFIG_PREEMPT_RT=y).
It crashes on boot if I enable latency tracing in .config. This happens 
with -rt13, -rt12, and -rt4 versions of the patch. Unfortunately it
occurs before any logging, so I can't provide any log data.
The crash appears to happen just after drive hda is
detected, while it's trying to mount my ext3 / filesystem (on hda7).
The mount fails then the screen fills with a segfault message in an
infinite loop:

segfault at ffffffff8010f20c rip ffffffff8010f20c rsp 00007fffffacdc88

A hard reboot is then required.

Without latency tracing it boots and runs fine with the following:

Kernel debug
	MagicSysRq
Detect soft lockups
Wakeup latency timing
Compile with debug info
Collect scheduler stats
Debug preemptible kernel

With latency tracing the crash occurs even if I disable all other
kernel hacking except for
Magic SysRq, Wakeup latency timing, and Compile w. debug info.

Hardware is 2 x Opteron 240, MSI K8T Master2-FAR (VIA K8T 800) m/board,
1GB ECC RAM. System is Debian amd64 unstable (gcc-4.0_4.0.1-7,
binutils_2.16.1cvs20050902-1).
Copy of .config and lspci output are here:
http://www.sound-man.co.uk/crash

Regards,
John
