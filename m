Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267724AbTHJOPZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 10:15:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269523AbTHJOPY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 10:15:24 -0400
Received: from 217-124-19-24.dialup.nuria.telefonica-data.net ([217.124.19.24]:3720
	"EHLO dardhal.mired.net") by vger.kernel.org with ESMTP
	id S267724AbTHJOPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 10:15:13 -0400
Date: Sun, 10 Aug 2003 16:15:12 +0200
From: Jose Luis Domingo Lopez <linux-kernel@24x7linux.com>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: 2.6.0-test2-mm2: "rmmod floppy" hangs the box
Message-ID: <20030810141512.GB421@localhost>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:

   (I filled a bug report to http://bugme.osdl.org a couple of days ago, and
   it seems the automated email to linux-kernel on each new bug filed
   doesn't work anymore, so here it is the problem explained.)

[1.] One line summary of the problem:    
"rmmod floppy" hangs the box if done shortly after "modprobe floppy" and
no floppy in the drive

[2.] Full description of the problem/report:
Doing some tests to see why ide-cd doesn't autoload while floppy does, I
came across this problem. I was basically doing the following:
mount /dev/fd0 /floppy ; sleep 1 ; rmmod floppy
And most of the times, shortly after (a couple of seconds) the last command 
I get a kernel panic on the console: no networking, no disk access, just
SysRq to reboot the box, but nothing else. The following panic message
was copied by hand from the screen maybe there is something missing,
becasue resolutino was 80x25 and nVIDIA framebuffer still doesn't work
completely ok.

Badness in device_release at drivers/base/core.c:84
Call Trace:
  [<c01a973d>] kobject_cleanup+0x7d/0x80
  
esi: c02e1080  edi: c02e0780  ebp: c0349ef8  esp: c0349ee4
ds: 007b  es:007b  ss: 0068

Process: swapper (pid: 0, threadinfo=c034800 task=c02dd980)
Stack: 00000001 00000000 00000000 c03711c8 c0349f0c c0349f24 c0120681 c02e0780
       c02e0f88 0000001f c0349f0c c0349f0c c02ff5fc 00000001 c03711c8 0000000a
       c0349f40 c011c899 c03711c8 00000046 00000000 c0345a00 00000000 c0349f64

Call Trace:
[<c0120681>] run_timer_softirq+0x101/0x180
[<c011c899>] do_softirq+0x99/0xa0
[<c010ad68>] do_IRQ+0xe8/0x120
[<c01092dc>] common_interrupt+0x18/0x20
[<c01dfcfa>] acpi_processor_idle+0x15a/0x1ef
[<c01dfba0>] acpi_processor_idle+0x0/0x1ef
[<c0107000>] default_idle+0x0/0x30
[<c01070a1>] cpu_idle+0x31/0x40
[<c0105000>] rest_init0x0/0x30
[<c034a6ec>] start_kernel+0x15c/0x190
[<c034a460>] unknown_bootoption+0x0/0x100

Code: 94 00 b5 38 2a c0 eb bf 8d 76 00 55 89 e5 57 56 53 83 ec 08 8b 75 10 8b 7d
 08 c1 e6 03 03 75 0c 8b 1e 39 f3 74 1e 90 8d 74 26 00 <39> 7b 18 89 d8 75 22 8b
 1b 89 3c 24 89 44 24 04 e8 1b fd ff ff
 <0> kernel panic: Fatal exception in interrupt
In interrupt handler - not syncing

I tried the same sequence of commands with ACPI disabled in the BIOS,
with the same results (but slightly different stack trace, of course).

[3.] Keywords:
2.6.0-test2-mm2 floppy module rmmod panic kernel panic

[4.] Kernel version:
Linux version 2.6.0-test2-mm2 (jdomingo@dardhal) (gcc version 3.2.3 20030415 (Debian prerelease)) #2 jue jul 31 20:45:59 CEST 2003

[5.] Output of Oops.. message
See above [2.]

[6.] A small shell script or example program which triggers the problem
See above [2.]

[7.] Environment
Debian Linux Sid, kernel version 2.6.0-test2-mm2 compiled with gcc 3.2.3, 
libc 2.3.1, module-init-tools 0.9.13-pre-1. Kernel compiled with ACPI
support, but not modular. Box booted in "minimal mode" (linux
init=/bin/bash) to avoid messing things up.


Hope it helps.

-- 
Jose Luis Domingo Lopez
Linux Registered User #189436     Debian Linux Sid (Linux 2.6.0-test2-mm2)
