Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261375AbUK2PCD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbUK2PCD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 10:02:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261720AbUK2PCD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 10:02:03 -0500
Received: from anor.ics.muni.cz ([147.251.4.35]:37866 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id S261375AbUK2PB6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 10:01:58 -0500
Date: Mon, 29 Nov 2004 16:01:55 +0100
From: Jan Kasprzak <kas@fi.muni.cz>
To: linux-kernel@vger.kernel.org
Subject: 2.6.10-rc2 x86_64 SMP problems
Message-ID: <20041129150155.GC24911@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi all,

I have two problems with my HP DL585 quad Opteron running 2.6.10-rc2.
The first problem is that load average is sometimes miscalculated
- e.g. now I have this:

# uptime
 15:53:22  up 11:27,  6 users,  load average: 0.97, 1.00, 18446744073708754944.00

(few seconds later)
# cat /proc/loadavg
0.82 0.96 657189.15 1/330 2191

Maybe some atomic increments or what are not so atomic? :-)
I did not observe the above behaviour under 2.6.8.1.

The second problem is the following message I have found today in
dmesg(8) output:

: irq 11: nobody cared!
: 
: Call Trace:<IRQ> <ffffffff8014f3b0>{__report_bad_irq+48} <ffffffff8014f477>{note_interrupt+87}
:        <ffffffff8014edb1>{__do_IRQ+257} <ffffffff8010b2a0>{default_idle+0}
:        <ffffffff801100ea>{do_IRQ+58} <ffffffff8010d71d>{ret_from_intr+0}
:         <EOI> <ffffffff804014b9>{thread_return+41} <ffffffff8010b2c7>{default_idle+39}
:        <ffffffff8010b350>{cpu_idle+32}
: handlers:
: [<ffffffff80299e15>] (acpi_irq+0x0/0x1a)
: Disabling IRQ #11

The IRQ 11 is ACPI, according to /proc/interrupts:

# cat /proc/interrupts
           CPU0       CPU1       CPU2       CPU3
  0:       3562      19705   41402688     148703    IO-APIC-edge  timer
  1:          0          0         77          0    IO-APIC-edge  i8042
  8:          0          0          0          0    IO-APIC-edge  rtc
 11:          2         10      99764        224   IO-APIC-level  acpi
[...]

The ACPI daemon is running, and kacpid kernel thread as well:

# ps ax|grep acpid
   15 ?        SW<    0:00 [kacpid]
17462 ?        S      0:00 /usr/sbin/acpid

-Yenya

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
> Whatever the Java applications and desktop dances may lead to, Unix will <
> still be pushing the packets around for a quite a while.      --Rob Pike <
