Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275126AbTHLJLE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 05:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275193AbTHLJLE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 05:11:04 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:35019 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S275126AbTHLJLB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 05:11:01 -0400
Date: Tue, 12 Aug 2003 11:10:56 +0200
From: Karel Kulhavy <clock@atrey.karlin.mff.cuni.cz>
To: linux-kernel@vger.kernel.org
Subject: Hangup on nforce2 UDMA
Message-ID: <20030812091056.GA13487@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Could you please try if your nforce2 MCP southbridge is also possible
to be crashed the way I describe lower?

I have nforce2 motherboard Soltek SL75FRN2-L with MCP southbridge. Using
2.4.21 with AMD 74xx driver for IDE. If I leave the UDMA5 (UATA-100)
setting BIOS leaves on the IDE disk I can hangup the machine almost
deterministically with

cat /dev/hda > /dev/null 

performed just after hard reset and subsequent boot. It hangs after max.
a minute or so. If it doesn't work, try hard reset and again, then
putting this script into /root/crash:

( a=0; while true; do echo $a; a=`/usr/bin/expr $a + 1`; sleep 1; done ) &
cat /dev/hda > /dev/null

then adding this into your lilo.conf:

image=/boot/vmlinuz
        label=crash
        append="init=/bin/bash /root/crash"
        read-only

and finally lilo -D crash and reboot and hard reset. Repeat several
times if the crash doesn't occur on the first try.

keyboard lights don't work, alt-sysrq-b doesn't work, power off doesn't
work. Reset works. I tried NMI watchog but both with nmi_watchdog=1 and
nmi_watchdog=2 I get NMI 14 or 15 in /proc/interrupts and it doesn't
increment in 5 second intervals. Without nmi_watchdog I get NMI 0 in
/proc/interrupts. Enabling NMI watchdog and waiting 5 seconds after the
crash does nothing.

When UDMA is disabled in BIOS, I get lower performance of 17MB/s instead
of 40MB/s. I have also tried IGNORE word93 Validation BITS and AMD Viper
ATA-66 Override and none helped.

Cl<
