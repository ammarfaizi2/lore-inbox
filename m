Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264900AbUG0Lw0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264900AbUG0Lw0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 07:52:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265038AbUG0Lw0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 07:52:26 -0400
Received: from starnet.skynet.com.pl ([213.25.173.230]:4820 "EHLO
	skynet.skynet.com.pl") by vger.kernel.org with ESMTP
	id S264900AbUG0LwL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 07:52:11 -0400
Date: Tue, 27 Jul 2004 02:21:54 +0200
From: Marcin Owsiany <marcin@owsiany.pl>
To: linux-kernel@vger.kernel.org
Subject: "swap_free: Unused swap offset entry 00000100" but no crash?
Message-ID: <20040727002154.GA21628@melina.ds14.agh.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
X-Scanner: exiscan *1BpQV1-00057i-00*wj1oZ.fthl.*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

The machine is a dual pentium 4, on an Intel motherboard, running kernel
2.4.26 with SMP.  This is a mail smarthost. Load average is around 3 for
most of the day, and around 0.2 during night. The box has been running
for a few months wothout problems.

$ cat /proc/swaps
Filename                        Type            Size    Used    Priority
/dev/rd/c0d0p1                  partition       1461872 2556    -1
$

(c0d0 is a Mylex DAC960 array).

Suddenly on the 8th day of its uptime, it started to log the message
cited in subject after EVERY SINGLE /usr/sbin/cron invocation.

There is an almost perfect correlation: the number of

    /USR/SBIN/CRON[PID]: (USER) CMD (blah blah)

lines in syslog is EXACTLY the same as the number of

    kernel: swap_free: Unused swap offset entry 00000100

lines.

It does not matter what command, and for what user, is run by cron (even
a single "true" in crontab provokes the kernel message).

The message is logged by kernel at the moment that the new cron process
exits (I found that out when some long-running commands were invoked).

This has been happening constantly for 5 days now, there are no other
messages from kernel in syslog. We also have two more similar machines,
and only this one recently started showing that.

The only references to this message I could find with google were also
describing almost immediate crashes, and hardware problems were
suggested.  But in my case the system works just fine.

I didn't try rebooting it, swapoff/on-ing or restarting cron yet - maybe
someone has some ideas on what to test to find out what caused this
before I do that?

Also, I would be grateful if someone could explain what is that number in the
message supposed to be? An address?

lspci -v:
00:00.0 Host bridge: Intel Corp.: Unknown device 2570 (rev 02)
        Subsystem: ABIT Computer Corp.: Unknown device 100a
        Flags: bus master, fast devsel, latency 0
        Memory at e0000000 (32-bit, prefetchable) [size=128M]
        Capabilities: [e4] #09 [2106]
        Capabilities: [a0] AGP version 3.0

00:01.0 PCI bridge: Intel Corp.: Unknown device 2571 (rev 02) (prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, fast devsel, latency 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        Memory behind bridge: f0000000-f1ffffff
        Prefetchable memory behind bridge: e8000000-efffffff

00:1e.0 PCI bridge: Intel Corp. 82820 820 (Camino 2) Chipset PCI (rev c2) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=02, subordinate=03, sec-latency=32
        I/O behind bridge: 00009000-00009fff
        Memory behind bridge: f2000000-f3ffffff
        Prefetchable memory behind bridge: f4000000-f47fffff

00:1f.0 ISA bridge: Intel Corp.: Unknown device 24d0 (rev 02)
        Flags: bus master, medium devsel, latency 0

00:1f.1 IDE interface: Intel Corp.: Unknown device 24db (rev 02) (prog-if 8a [Master SecP PriP])
        Subsystem: ABIT Computer Corp.: Unknown device 100a
        Flags: bus master, medium devsel, latency 0, IRQ 16
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at f000 [size=16]
        Memory at 40000000 (32-bit, non-prefetchable) [size=1K]

00:1f.3 SMBus: Intel Corp.: Unknown device 24d3 (rev 02)
        Subsystem: ABIT Computer Corp.: Unknown device 100a
        Flags: medium devsel, IRQ 17
        I/O ports at 0500 [size=32]

01:00.0 VGA compatible controller: nVidia Corporation: Unknown device 0181 (rev c1) (prog-if 00 [VGA])
        Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 16
        Memory at f0000000 (32-bit, non-prefetchable) [size=16M]
        Memory at e8000000 (32-bit, prefetchable) [size=128M]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [60] Power Management version 2
        Capabilities: [44] AGP version 3.0

02:04.0 Ethernet controller: Intel Corp. 82557 [Ethernet Pro 100] (rev 08)
        Subsystem: Intel Corp. EtherExpress PRO/100+ Management Adapter
        Flags: bus master, medium devsel, latency 32, IRQ 20
        Memory at f3100000 (32-bit, non-prefetchable) [size=4K]
        I/O ports at 9000 [size=64]
        Memory at f3000000 (32-bit, non-prefetchable) [size=1M]
        Capabilities: [dc] Power Management version 2

02:06.0 PCI bridge: Intel Corp. 80960RP [i960 RP Microprocessor/Bridge] (rev 03) (prog-if 00 [Normal decode])
        Flags: bus master, medium devsel, latency 32
        Bus: primary=02, secondary=03, subordinate=03, sec-latency=32

02:06.1 RAID bus controller: Mylex Corporation DAC960PX (rev 03)
        Subsystem: Mylex Corporation DAC960PX
        Flags: bus master, medium devsel, latency 32, IRQ 22
        Memory at f4000000 (32-bit, prefetchable) [size=8M]
        Expansion ROM at <unassigned> [disabled] [size=32K]

free:
             total       used       free     shared    buffers     cached
Mem:        904348     507716     396632          0      34896     254208
-/+ buffers/cache:     218612     685736
Swap:      2000052      61860    1938192

Marcin
-- 
Marcin Owsiany <marcin@owsiany.pl>              http://marcin.owsiany.pl/
GnuPG: 1024D/60F41216  FE67 DA2D 0ACA FC5E 3F75  D6F6 3A0D 8AA0 60F4 1216
 
"Every program in development at MIT expands until it can read mail."
                                                              -- Unknown
