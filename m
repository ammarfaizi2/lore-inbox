Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262265AbTI0Xk2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Sep 2003 19:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262277AbTI0Xk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Sep 2003 19:40:28 -0400
Received: from hell.org.pl ([212.244.218.42]:59665 "HELO hell.org.pl")
	by vger.kernel.org with SMTP id S262265AbTI0Xk0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Sep 2003 19:40:26 -0400
Date: Sun, 28 Sep 2003 01:46:30 +0200
From: Karol Kozimor <sziwan@hell.org.pl>
To: Patrick Mochel <mochel@osdl.org>
Cc: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PM][ACPI] /proc/acpi/alarm halfway working
Message-ID: <20030927234630.GA32525@hell.org.pl>
Mail-Followup-To: Patrick Mochel <mochel@osdl.org>,
	acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I've just tested 2.6.0-test5-mm4, it seems that the /proc/acpi/alarm
has ceased to deadlock my laptop and actually started to work as
expected. The only drawback is:
#v+
irq 9: nobody cared!
Call Trace:
 [<c010c57e>] __report_bad_irq+0x2a/0x8b
 [<c010c668>] note_interrupt+0x6f/0x9f
 [<c010c856>] do_IRQ+0xe2/0xe4
 [<c02d1668>] common_interrupt+0x18/0x20
 [<c01f007b>] sys_shmat+0x1f6/0x2b6
 [<c012256c>] do_softirq+0x40/0x97
 [<c010c83d>] do_IRQ+0xc9/0xe4
 [<c02d1668>] common_interrupt+0x18/0x20
 [<c01fb045>] acpi_os_write_port+0x33/0x35
 [<c020f8aa>] acpi_hw_low_level_write+0x118/0x122
 [<c021e6fe>] acpi_ut_trace+0x28/0x2c
 [<c020f5cf>] acpi_hw_register_write+0xca/0x16b
 [<c020f26a>] acpi_set_register+0x1d0/0x2aa
 [<c02232ce>] acpi_system_write_alarm+0x497/0x520
 [<c0150711>] vfs_write+0xbc/0x127
 [<c0150821>] sys_write+0x42/0x63
 [<c02d14fb>] syscall_call+0x7/0xb

handlers:
[<c01faed6>] (acpi_irq+0x0/0x16)
Disabling IRQ #9
#v-

This happens upon the first echo > proc/acpi/alarm. The echo, however, sets
the time right, and the system is actually woken up successfully (S1, S3,
S4 were tested). Subsequent echos work, but do not generate the above
messages. Since IRQ 9 is what ACPI resides on, almost no new events are
reported (except those explicitely trigerred by _WAK).
The chipset is i845M; tell me if full dmesg is needed.
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan@hell.org.pl
