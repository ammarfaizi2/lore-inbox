Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262386AbTHaCfR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 22:35:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262394AbTHaCfR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 22:35:17 -0400
Received: from auth22.inet.co.th ([203.150.14.104]:40201 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S262386AbTHaCfI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 22:35:08 -0400
From: Michael Frank <mhf@linuxmail.org>
Subject: 2.6.0-test4: Tested the Power Management Update
Date: Sun, 31 Aug 2003 10:34:33 +0800
User-Agent: KMail/1.5.2
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
To: Patrick Mochel <mochel@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-Id: <200308311027.08779.mhf@linuxmail.org>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick,

Thank you for taking this on.

1) IMPROVED: S3/mem works better than ever - no resume failures encountered!

2) WORKS AGAIN: S4/disk functionality restored, no problems seen.

3) NEW: ACPI alarm function has new problem:

echo > /proc/acpi/alarm often (not always) causes:

Aug 31 09:16:36 mhfl2 kernel: irq 9: nobody cared!
Aug 31 09:16:36 mhfl2 kernel: Call Trace:
Aug 31 09:16:36 mhfl2 kernel:  [<c010c35b>] __report_bad_irq+0x2b/0x90
Aug 31 09:16:36 mhfl2 kernel:  [<c010c363>] __report_bad_irq+0x33/0x90
Aug 31 09:16:36 mhfl2 kernel:  [<c010c438>] note_interrupt+0x50/0x78
Aug 31 09:16:36 mhfl2 kernel:  [<c010c5b2>] do_IRQ+0x96/0xf4
Aug 31 09:16:36 mhfl2 kernel:  [<c010afe8>] common_interrupt+0x18/0x20
Aug 31 09:16:36 mhfl2 kernel:  [<c011dd58>] do_softirq+0x48/0xb0
Aug 31 09:16:36 mhfl2 kernel:  [<c010c600>] do_IRQ+0xe4/0xf4
Aug 31 09:16:36 mhfl2 kernel:  [<c010afe8>] common_interrupt+0x18/0x20
Aug 31 09:16:36 mhfl2 kernel:  [<c01e110d>] acpi_os_write_port+0x35/0x50
Aug 31 09:16:36 mhfl2 kernel:  [<c01f65de>] acpi_hw_low_level_write+0x7e/0x11e
Aug 31 09:16:36 mhfl2 kernel:  [<c01f632d>] acpi_hw_register_write+0xb9/0x1c0
Aug 31 09:16:37 mhfl2 kernel:  [<c01f6046>] acpi_set_register+0x262/0x2d0
Aug 31 09:16:37 mhfl2 kernel:  [<c020ac7c>] acpi_system_write_alarm+0x4f8/0x544
Aug 31 09:16:37 mhfl2 kernel:  [<c01464fe>] vfs_write+0x9e/0xd0
Aug 31 09:16:37 mhfl2 kernel:  [<c01465b0>] sys_write+0x30/0x50
Aug 31 09:16:37 mhfl2 kernel:  [<c010adc7>] syscall_call+0x7/0xb
Aug 31 09:16:37 mhfl2 kernel: 
Aug 31 09:16:37 mhfl2 kernel: handlers:
Aug 31 09:16:37 mhfl2 kernel: [<c01e0f6c>] (acpi_irq+0x0/0x1c)
Aug 31 09:16:37 mhfl2 kernel: Disabling IRQ #9

$ cat /proc/interrupts
           CPU0
  0:     786435          XT-PIC  timer
  1:       2266          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  5:          1          XT-PIC  0000:00:12.0
  8:          0          XT-PIC  rtc
  9:         96          XT-PIC  acpi
 10:       1003          XT-PIC  eth0
 12:       8252          XT-PIC  i8042
 14:       6937          XT-PIC  ide0
NMI:          0
ERR:          2

4) UNCHANGED: Alarm wakeup from S3 powers up and hangs.

5) MAJOR UNCHANGED: (ACPI routed) PCI interrupt links still stay dead 
on S3 resume as their state was lost upon powerdown of the router and 
on resume USB, Network and PCMCIA/Yenta are dead.

I had posted a patch earlier to set all links again in ACPI prior to 
resuming devices, Russell said it was discussed at OLS, what will be 
done about it?

6) MINOR UNCHANGED: As to the mouse, i8042 does not resume, so I 
config i8042 as a module and reload it on resume. However, current 
drivers/input/serio/Kconfig makes this impossible, which I whined 
about a few times already ;)

config SERIO_I8042
tristate "i8042 PC Keyboard controller" if EMBEDDED || !X86

Maybe bug in kconfig: Even when X86 if off, can't touch i8042 
using menuconfig.


Regards
Michael

