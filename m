Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261539AbTJRLRq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 07:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261552AbTJRLRq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 07:17:46 -0400
Received: from slimnet.xs4all.nl ([194.109.194.192]:41376 "EHLO slimnas.slim")
	by vger.kernel.org with ESMTP id S261539AbTJRLRn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 07:17:43 -0400
Subject: 2.6.0-test8: cpufreq longhaul probs..still :-(
From: Jurgen Kramer <gtm.kramer@inter.nl.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1066475780.2607.6.camel@paragon.slim>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-3) 
Date: Sat, 18 Oct 2003 13:16:21 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

With test8 there are still problems with the longhaul cpufreq stuff:

longhaul: VIA C3 'Ezra' [C5C] CPU detected. Longhaul v1 supported.
longhaul: MinMult=3.0x MaxMult=6.0x
longhaul: FSB: 0MHz Lowestspeed=0MHz Highestspeed=0MHz
------------[ cut here ]------------
kernel BUG at drivers/cpufreq/cpufreq_userspace.c:502!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c022a203>]    Not tainted
EFLAGS: 00010246
EIP is at cpufreq_governor_userspace+0xb3/0x1b0
eax: 00000000   ebx: 00000001   ecx: cf2ef0a0   edx: 00000000
esi: cf2ef6a0   edi: 00000001   ebp: 00000000   esp: ccc0fe64
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 1941, threadinfo=ccc0e000 task=cd250ca0)
Stack: 00000001 cf2ef6a0 00000001 cf2ef6a0 c0229778 cf2ef6a0 00000001
00000000
       00000000 ccc0fee4 cf2ef6a0 c0229abe cf2ef6a0 00000001 cf2ef6c4
ccc0fee4
       cf2ef6a0 cf2ef6e4 c0229b59 cf2ef6a0 ccc0fee4 cf2ef6a0 00000000
ccc0e000
Call Trace:
 [<c0229778>] __cpufreq_governor+0x68/0x120
 [<c0229abe>] __cpufreq_set_policy+0xde/0x140
 [<c0229b59>] cpufreq_set_policy+0x39/0x70
 [<c02292c5>] cpufreq_add_dev+0x185/0x2a0
 [<c014d74c>] unmap_vm_area+0x2c/0x80
 [<c01d8a83>] sysdev_driver_register+0x83/0xe0
 [<c0229e21>] cpufreq_register_driver+0x91/0xa0
 [<d082e4e4>] longhaul_init+0x54/0x56 [longhaul]
 [<c013677d>] sys_init_module+0x10d/0x230
 [<c010b247>] syscall_call+0x7/0xb

Code: 0f 0b f6 01 60 66 2a c0 eb 82 0f 0b f4 01 60 66 2a c0 e9 6e

/sys/devices/system/cpu/cpu0/cpufreq:

[root@paradox cpufreq]# more *
::::::::::::::
cpuinfo_max_freq
::::::::::::::
0
::::::::::::::
cpuinfo_min_freq
::::::::::::::
0
::::::::::::::
scaling_available_governors
::::::::::::::
userspace
::::::::::::::
scaling_driver
::::::::::::::
longhaul
::::::::::::::
scaling_governor
::::::::::::::
userspace
::::::::::::::
scaling_max_freq
::::::::::::::
0
::::::::::::::
scaling_min_freq
::::::::::::::
0

I'll check if I can fix the min/max freq. Is Longhaul v1 correct for
this CPU? With cpufreq from 2.4 it always displays v2.

Jurgen

