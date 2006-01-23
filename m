Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964816AbWAWRDf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964816AbWAWRDf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 12:03:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964826AbWAWRDf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 12:03:35 -0500
Received: from main.gmane.org ([80.91.229.2]:48783 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964816AbWAWRDe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 12:03:34 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kalin KOZHUHAROV <kalin@thinrope.net>
Subject: Re: CONFIG_X86_PM_TIMER broken in 2.6.15.1 (since before 2.6.14?)
Date: Tue, 24 Jan 2006 02:02:18 +0900
Message-ID: <dr326s$q61$1@sea.gmane.org>
References: <dr1t39$qod$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: s175249.ppp.asahi-net.or.jp
User-Agent: Mail/News 1.5 (X11/20060115)
In-Reply-To: <dr1t39$qod$1@sea.gmane.org>
X-Enigmail-Version: 0.94.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kalin KOZHUHAROV wrote:
> Hi all.
> 
> Now I have a repeatable confirmation that selecting CONFIG_X86_PM_TIMER=y
> does "break" printk on a few systems.
> 
> With CONFIG_X86_PM_TIMER=y pmtmr is preferred to tsc and as a result, printk
> time is not reset on CPU init.
> 
> The difference (hand diff) between the dmesg in the two configs is:
> 
> normal( # CONFIG_X86_PM_TIMER is not set ):
> ....
> 
> ....
> [17179569.184000] PID hash table entries: 4096 (order: 12, 65536 bytes)
> [    0.000000] Detected 3011.142 MHz processor.
> [   25.672059] Using tsc for high-res timesource
> [   25.673931] Console: colour VGA+ 80x25
> 
> 
> broken ( CONFIG_X86_PM_TIMER=y ):
> ....
> [17179569.184000] ACPI: PM-Timer IO Port: 0x808
> ....
> [17179569.184000] PID hash table entries: 4096 (order: 12, 65536 bytes)
> [17179569.184000] Detected 3011.098 MHz processor.
> [17179569.184000] Using pmtmr for high-res timesource
> [17179569.184000] Console: colour VGA+ 80x25

My MUA broke the whitespace somehow, fixed above.

> Apart from that everything is the same (apart from the prink time).
> 
> Any clues as to why might this be broken?
> 
> I tired to look under arch/i386/kernel/timers but it was too much for me,
> got buried under too many jiffies :-)

Now there is another system, my PIII laptop and it has another strange timer
set:

ss ~ # dmesg |head -n 40
[17179569.184000] Linux version 2.6.15.1-K01_PIII_laptop (kalin@char) (gcc
version 3.4.4 (Gentoo 3.4.4-r1, ssp-3.4.4-1.0, pie-8.7.8)) #1 PREEMPT Mon
Jan 23 19:10:41 JST 2006
[17179569.184000] BIOS-provided physical RAM map:
[17179569.184000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
[17179569.184000]  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
[17179569.184000]  BIOS-e820: 00000000000e0000 - 00000000000eee00 (reserved)
[17179569.184000]  BIOS-e820: 00000000000eee00 - 00000000000ef000 (ACPI NVS)
[17179569.184000]  BIOS-e820: 00000000000ef000 - 0000000000100000 (reserved)
[17179569.184000]  BIOS-e820: 0000000000100000 - 000000000ef60000 (usable)
[17179569.184000]  BIOS-e820: 000000000ef60000 - 000000000ef70000 (ACPI data)
[17179569.184000]  BIOS-e820: 000000000ef70000 - 0000000010000000 (reserved)
[17179569.184000]  BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
[17179569.184000] 239MB LOWMEM available.
[17179569.184000] On node 0 totalpages: 61280
[17179569.184000]   DMA zone: 4096 pages, LIFO batch:0
[17179569.184000]   DMA32 zone: 0 pages, LIFO batch:0
[17179569.184000]   Normal zone: 57184 pages, LIFO batch:15
[17179569.184000]   HighMem zone: 0 pages, LIFO batch:0
[17179569.184000] DMI 2.3 present.
[17179569.184000] ACPI: RSDP (v000 TOSHIB                                ) @
0x000f0090
[17179569.184000] ACPI: RSDT (v001 TOSHIB 750      0x00970814 TASM
0x04010000) @ 0x0ef60000
[17179569.184000] ACPI: FADT (v002 TOSHIB 750      0x00970814 TASM
0x04010000) @ 0x0ef60058
[17179569.184000] ACPI: DBGP (v001 TOSHIB 750      0x00970814 TASM
0x04010000) @ 0x0ef600dc
[17179569.184000] ACPI: BOOT (v001 TOSHIB 750      0x00970814 TASM
0x04010000) @ 0x0ef60030
[17179569.184000] ACPI: DSDT (v001 TOSHIB 2000M    0x20020530 MSFT
0x0100000a) @ 0x00000000
[17179569.184000] Allocating PCI resources starting at 20000000 (gap:
10000000:eff80000)
[17179569.184000] Built 1 zonelists
[17179569.184000] Kernel command line: root=/dev/hda3
[17179569.184000] Local APIC disabled by BIOS -- you can enable it with "lapic"
[17179569.184000] mapped APIC to ffffd000 (011e0000)
[17179569.184000] Initializing CPU#0
[17179569.184000] PID hash table entries: 1024 (order: 10, 16384 bytes)
[    0.000000] Detected 796.776 MHz processor.
[ 1364.722869] Using tsc for high-res timesource
[ 1364.725059] Console: colour VGA+ 80x25
[ 1364.726889] Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
[ 1364.727619] Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
[ 1364.760246] Memory: 239904k/245120k available (1548k kernel code, 4792k
reserved, 646k data, 132k init, 0k highmem)
[ 1364.760361] Checking if this processor honours the WP bit even in
supervisor mode... Ok.
[ 1364.838652] Calibrating delay using timer specific routine.. 1596.68
BogoMIPS (lpj=3193360)
[ 1364.838901] Security Framework v1.0.0 initialized


And, no it does not take 1364 seconds to boot, not that slow (about 35s?).

Is tsc totally broken?

I tried to fix the prink time by disabling the PM_TIMER but it didn't work
that well.

ss ~ # gzcat /proc/config.gz |grep TIME
CONFIG_HPET_TIMER=y
# CONFIG_X86_PM_TIMER is not set
CONFIG_HANGCHECK_TIMER=y
CONFIG_SND_TIMER=m
CONFIG_SND_RTCTIMER=m
CONFIG_SND_SEQ_RTCTIMER_DEFAULT=y
CONFIG_PRINTK_TIME=y

Full .config available:
	http://linux.tar.bz/reports/misc/ss/2.6.15.1-K01_PIII_laptop.config
other (lots of) stuff for this machine is in the directory:
	http://linux.tar.bz/reports/misc/ss/

Kalin.

-- 
|[ ~~~~~~~~~~~~~~~~~~~~~~ ]|
+-> http://ThinRope.net/ <-+
|[ ______________________ ]|

