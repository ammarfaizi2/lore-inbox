Return-Path: <linux-kernel-owner+w=401wt.eu-S1762784AbWLKLFF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762784AbWLKLFF (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 06:05:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762786AbWLKLFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 06:05:05 -0500
Received: from cust200-138.dsl.versadsl.be ([62.166.200.138]:44617 "HELO
	trinityhome.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1762784AbWLKLFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 06:05:02 -0500
Message-ID: <55427.212.166.5.178.1165835168.squirrel@trinityhome.org>
Date: Mon, 11 Dec 2006 12:06:08 +0100 (CET)
Subject: Segmentation fault on modprobe depca
From: "Tom Kerremans" <harakiri@trinityhome.org>
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.6-1
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I 'm the maintainter of Trinity Rescue Kit (http://trinityhome.org/trk) ,
a live rescue distribution that tries (amongst many other features) to be
as generic as possible in terms of hardware detection. Therefore I include
all network and disk controller drivers in the kernel or as module.
I recently tried kernel 2.6.19 and stumbled upon the fact that the module
DEPCA seems to be broken. When I compile it in the kernel, the kernel
crashes at boot time. Compiled as module it creates a segmentation fault
on modprobe.
I 've tested compilation on two different systems: first is my TRK
workbench, which is a Mandriva 2005 with gcc 3.4.3-7mdk and
module-init-tools 3.0 (later upgraded to 3.2.2, recompiled kernel, but
same result). The other system I compiled and tried it on is an
out-of-the-box Mandriva 2007, which  is quite new and has more recent
compilers and libraries. The result was the same.
When I do a "modprobe depca", even though there is no hardware that could
use this module (it 's for old DEC nics..), I get the following output:

[root@vmlinux ~]# modprobe depca
Segmentation fault
[root@vmlinux ~]#
Message from syslogd@localhost at Mon Dec 11 11:43:56 2006 ...
localhost kernel: ------------[ cut here ]------------

Message from syslogd@localhost at Mon Dec 11 11:43:56 2006 ...
localhost kernel: Kernel BUG at [verbose debug info unavailable]

Message from syslogd@localhost at Mon Dec 11 11:43:56 2006 ...
localhost kernel: invalid opcode: 0000 [#1]

Message from syslogd@localhost at Mon Dec 11 11:43:56 2006 ...
localhost kernel: CPU:    0

Message from syslogd@localhost at Mon Dec 11 11:43:56 2006 ...
localhost kernel: EIP:    0060:[<c014b738>]    Not tainted VLI

Message from syslogd@localhost at Mon Dec 11 11:43:56 2006 ...
localhost kernel: EFLAGS: 00010006   (2.6.19 #2)

Message from syslogd@localhost at Mon Dec 11 11:43:56 2006 ...
localhost kernel: EIP is at kfree+0x32/0x59

Message from syslogd@localhost at Mon Dec 11 11:43:56 2006 ...
localhost kernel: eax: ef632674   ebx: f64f7800   ecx: f64f7870   edx:
c1800000

Message from syslogd@localhost at Mon Dec 11 11:43:56 2006 ...
localhost kernel: esi: 00000206   edi: 00000300   ebp: ea4a5e1c   esp:
ea4a5e10

Message from syslogd@localhost at Mon Dec 11 11:43:56 2006 ...
localhost kernel: ds: 007b   es: 007b   ss: 0068

Message from syslogd@localhost at Mon Dec 11 11:43:56 2006 ...
localhost kernel: Process modprobe (pid: 26866, ti=ea4a4000 task=c1a74a70
task.ti=ea4a4000)

Message from syslogd@localhost at Mon Dec 11 11:43:56 2006 ...
localhost kernel: Stack: f64f7800 f64f7870 c0552580 ea4a5e2c c0279ecc
00000300 c05525dc ea4a5e44

Message from syslogd@localhost at Mon Dec 11 11:43:56 2006 ...
localhost kernel:        c0275ccf f64f7808 ea4a5e44 c0275de3 f64f7870
ea4a5e60 c020d3a2 f64f7870

Message from syslogd@localhost at Mon Dec 11 11:43:56 2006 ...
localhost kernel:        c05528c8 f64f7888 c020d3c9 00000000 ea4a5e6c
c020d3dd f64f7870 ea4a5e8c

Message from syslogd@localhost at Mon Dec 11 11:43:56 2006 ...
localhost kernel: Call Trace:

Message from syslogd@localhost at Mon Dec 11 11:43:56 2006 ...
localhost kernel:  [<c010317a>] show_trace_log_lvl+0x26/0x3c

Message from syslogd@localhost at Mon Dec 11 11:43:56 2006 ...
localhost kernel:  [<c010322b>] show_stack_log_lvl+0x9b/0xa3

Message from syslogd@localhost at Mon Dec 11 11:43:56 2006 ...
localhost kernel:  [<c01035f6>] show_registers+0x18f/0x229

Message from syslogd@localhost at Mon Dec 11 11:43:56 2006 ...
localhost kernel:  [<c01037ba>] die+0x12a/0x1ef

Message from syslogd@localhost at Mon Dec 11 11:43:56 2006 ...
localhost kernel:  [<c01038ff>] do_trap+0x80/0x88

Message from syslogd@localhost at Mon Dec 11 11:43:56 2006 ...
localhost kernel:  [<c01040fa>] do_invalid_op+0xa0/0xaa

Message from syslogd@localhost at Mon Dec 11 11:43:56 2006 ...
localhost kernel:  [<c047f329>] error_code+0x39/0x40

Message from syslogd@localhost at Mon Dec 11 11:43:56 2006 ...
localhost kernel:  [<c0279ecc>] platform_device_release+0x1b/0x35

Message from syslogd@localhost at Mon Dec 11 11:43:56 2006 ...
localhost kernel:  [<c0275ccf>] device_release+0x2f/0x71

Message from syslogd@localhost at Mon Dec 11 11:43:56 2006 ...
localhost kernel:  [<c020d3a2>] kobject_cleanup+0x49/0x70

Message from syslogd@localhost at Mon Dec 11 11:43:56 2006 ...
localhost kernel:  [<c020d3dd>] kobject_release+0x14/0x16

Message from syslogd@localhost at Mon Dec 11 11:43:56 2006 ...
localhost kernel:  [<c020df30>] kref_put+0x6a/0x78

Message from syslogd@localhost at Mon Dec 11 11:43:56 2006 ...
localhost kernel:  [<c020d357>] kobject_put+0x20/0x22

Message from syslogd@localhost at Mon Dec 11 11:43:56 2006 ...
localhost kernel:  [<c0275de3>] put_device+0x18/0x1a

Message from syslogd@localhost at Mon Dec 11 11:43:56 2006 ...
localhost kernel:  [<c0279efe>] platform_device_put+0x18/0x1a

Message from syslogd@localhost at Mon Dec 11 11:43:56 2006 ...
localhost kernel:  [<f8ac98a0>] depca_module_init+0x79/0xc4 [depca]

Message from syslogd@localhost at Mon Dec 11 11:43:56 2006 ...
localhost kernel:  [<c012be5a>] sys_init_module+0x1332/0x14b9

Message from syslogd@localhost at Mon Dec 11 11:43:56 2006 ...
localhost kernel:  [<c0102c9d>] sysenter_past_esp+0x56/0x79

Message from syslogd@localhost at Mon Dec 11 11:43:56 2006 ...
localhost kernel:  =======================

Message from syslogd@localhost at Mon Dec 11 11:43:56 2006 ...
localhost kernel: Code: 56 53 85 ff 74 47 9c 5e fa 8d 97 00 00 00 40 c1 ea
0c c1 e2 05 03 15 a0 26 68 c0 8b 02 f6 c4 40 74 03 8b 52 0c 8b 02 84 c0 78
02 <0f> 0b 8b 4a 18 8b 19 8b 03 3b 43 04 72 0b 89 c8 89 da e8 25 ff

Message from syslogd@localhost at Mon Dec 11 11:43:56 2006 ...
localhost kernel: EIP: [<c014b738>] kfree+0x32/0x59 SS:ESP 0068:ea4a5e10

This used to work in all of the older 2.6 kernels I 've tried before
(which are easily about 10 different ones). It still worked in kernel
2.6.18

The bug should be easily reproducable. If not, I can send my .config file
for any misconfiguration you might encounter.



Greetings

Tom Kerremans

