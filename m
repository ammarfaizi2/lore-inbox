Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932264AbWCAOqn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932264AbWCAOqn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 09:46:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932272AbWCAOqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 09:46:43 -0500
Received: from 209-166-240-202.cust.walrus.com ([209.166.240.202]:55486 "EHLO
	mail1.telemetry-investments.com") by vger.kernel.org with ESMTP
	id S932264AbWCAOqm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 09:46:42 -0500
Date: Wed, 1 Mar 2006 09:46:41 -0500
From: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
To: Andi Kleen <ak@suse.de>
Cc: Jason Baron <jbaron@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: AMD64 X2 lost ticks on PM timer
Message-ID: <20060301144641.GB20092@ti64.telemetry-investments.com>
Mail-Followup-To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
	Andi Kleen <ak@suse.de>, Jason Baron <jbaron@redhat.com>,
	linux-kernel@vger.kernel.org
References: <200602280022.40769.darkray@ic3man.com> <20060227222152.GA26541@ti64.telemetry-investments.com> <Pine.LNX.4.61.0602271744270.31386@dhcp83-105.boston.redhat.com> <200602281041.27960.darkray@ic3man.com> <20060228220054.GC23330@ti64.telemetry-investments.com> <p73veuzyr8p.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73veuzyr8p.fsf@verdi.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2006 at 12:53:58AM +0100, Andi Kleen wrote:
> What chipset?

Thanks for the interest, Andi.
 
The chipset is NVIDIA nForce Pro 2200 (CK804).  The mobo is Tyan 2895:

  http://www.tyan.com/products/html/thunderk8we.html

It's running the current 1.02 version of the BIOS.

Current kernel is the FC4 errata:

  Linux ti94 2.6.15-1.1831_FC4smp #1 SMP Tue Feb 7 13:51:52 EST 2006 x86_64 x86_64 x86_64 GNU/Linux

  rugolsky@ti94: rpm -q --changelog kernel-smp-2.6.15-1.1831_FC4 | head -3
  * Tue Feb 07 2006 Dave Jones <davej@redhat.com>
  - 2.6.15.3
    Fixes remotely exploitable bug in ICMP (CVE-2006-0454)

Powernow-k8 is built into the kernel (see log messages below),
but I have it turned off in the BIOS config.

Some time today I'll build vanilla 2.6.15.4 and 2.6.16-rc5.

> What output do you get when you run ftp.suse.com:/pub/people/ak/tools/trtc.c ?
> (and what is the _HZ value you configured in Kconfig?)

  rugolsky@ti94: grep CONFIG_HZ /usr/src/kernels/2.6.15-1.1831_FC4smp-x86_64/.config 
  # CONFIG_HZ_100 is not set
  CONFIG_HZ_250=y
  # CONFIG_HZ_1000 is not set
  CONFIG_HZ=250

Below is the trtc output while running "find /usr -type f |  cpio -o > /dev/null"
without and with idle=poll.

> Does it go away when you run with idle=poll?

No.

Here's some output of trtc without idle=poll:

1141220165:151240: rtc 464 int 0 125 (=125)
1141220165:651241: rtc 448 int 0 125 (=125)
1141220166:151242: rtc 464 int 0 125 (=125)
1141220166:651244: rtc 448 int 0 125 (=125)
1141220167:151245: rtc 464 int 0 125 (=125)
1141220167:651245: rtc 448 int 0 125 (=125)
1141220168:155246: rtc 464 int 0 125 (=125)
1141220168:655250: rtc 448 int 22 103 (=125)
1141220169:155280: rtc 464 int 125 0 (=125)
1141220169:655251: rtc 448 int 125 0 (=125)
1141220170:155251: rtc 464 int 125 0 (=125)
1141220170:655252: rtc 448 int 125 0 (=125)
1141220171:155253: rtc 464 int 125 0 (=125)
1141220171:655253: rtc 448 int 125 0 (=125)
1141220172:155288: rtc 464 int 125 0 (=125)
1141220172:655256: rtc 448 int 125 0 (=125)
1141220173:155258: rtc 464 int 125 0 (=125)
1141220173:655258: rtc 448 int 125 0 (=125)
1141220174:155259: rtc 464 int 125 0 (=125)
1141220174:655260: rtc 448 int 125 0 (=125)
1141220175:155262: rtc 464 int 125 0 (=125)
1141220175:655262: rtc 448 int 125 0 (=125)
1141220176:155263: rtc 464 int 125 0 (=125)
1141220176:655265: rtc 448 int 125 0 (=125)
1141220177:159266: rtc 464 int 125 0 (=125)
1141220177:659268: rtc 448 int 125 0 (=125)
1141220178:159268: rtc 464 int 125 0 (=125)
1141220178:659274: rtc 448 int 104 21 (=125)
1141220179:159272: rtc 464 int 0 125 (=125)
1141220179:659270: rtc 448 int 0 125 (=125)
1141220180:159272: rtc 464 int 0 125 (=125)
1141220180:659273: rtc 448 int 0 125 (=125)
1141220181:159274: rtc 464 int 0 125 (=125)
1141220181:659275: rtc 448 int 0 125 (=125)
1141220182:159276: rtc 464 int 0 125 (=125)
1141220182:659277: rtc 448 int 0 125 (=125)
1141220183:159283: rtc 464 int 0 125 (=125)
1141220183:659279: rtc 448 int 0 125 (=125)
1141220184:163288: rtc 464 int 0 123 (=123)  <-----
1141220184:663281: rtc 448 int 0 125 (=125)
1141220185:163283: rtc 464 int 0 125 (=125)
1141220185:667283: rtc 448 int 0 125 (=125)
1141220186:167285: rtc 464 int 0 125 (=125)
1141220186:667285: rtc 448 int 0 125 (=125)
1141220187:167289: rtc 464 int 0 125 (=125)
1141220187:667288: rtc 448 int 0 125 (=125)
1141220188:167289: rtc 464 int 0 125 (=125)
1141220188:667292: rtc 448 int 22 103 (=125)
1141220189:167291: rtc 464 int 125 0 (=125)
1141220189:667291: rtc 448 int 125 0 (=125)
1141220190:167292: rtc 464 int 125 0 (=125)
1141220190:667293: rtc 448 int 125 0 (=125)
1141220191:167292: rtc 464 int 125 0 (=125)

Kernel log highlights:

Kernel command line: ro root=/dev/md2 report_lost_ticks
...
time.c: Using 3.579545 MHz PM timer.
time.c: Detected 2009.284 MHz processor.
...
Using local APIC timer interrupts.
Detected 12.558 MHz APIC timer.
time.c: Lost 11 timer tick(s)! rip setup_boot_APIC_clock+0x117/0x11a)
Booting processor 1/2 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 4018.82 BogoMIPS (lpj=8037654)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 1(1) -> Node 0 -> Core 0
AMD Opteron(tm) Processor 246 stepping 0a
CPU 1: Syncing TSC to CPU 0.
CPU 1: synchronized TSC with CPU 0 (last diff -124 cycles, maxerr 1093 cycles)
Brought up 2 CPUs
Disabling vsyscall due to use of PM timer
time.c: Using PM based timekeeping.
testing NMI watchdog ... <4>time.c: Lost 17 timer tick(s)! rip __delay+0xa/0x10)
OK.
powernow-k8: Found 2 AMD Athlon 64 / Opteron processors (version 1.50.4)
powernow-k8: MP systems not supported by PSB BIOS structure
powernow-k8: MP systems not supported by PSB BIOS structure
...
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x55/0xd4)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x55/0xd4)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x55/0xd4)
time.c: Lost 1 timer tick(s)! rip default_idle+0x37/0x7a)
time.c: Lost 1 timer tick(s)! rip default_idle+0x37/0x7a)
time.c: Lost 2 timer tick(s)! rip default_idle+0x37/0x7a)
time.c: Lost 1 timer tick(s)! rip default_idle+0x37/0x7a)
time.c: Lost 2 timer tick(s)! rip default_idle+0x37/0x7a)
time.c: Lost 1 timer tick(s)! rip default_idle+0x37/0x7a)
time.c: Lost 1 timer tick(s)! rip default_idle+0x37/0x7a)
time.c: Lost 1 timer tick(s)! rip default_idle+0x37/0x7a)


Here's the output of trtc with idle=poll:

1141221151:371869: rtc 464 int 125 0 (=125)
1141221151:871857: rtc 448 int 125 0 (=125)
1141221152:371845: rtc 464 int 125 0 (=125)
1141221152:871833: rtc 448 int 125 0 (=125)
1141221153:371820: rtc 464 int 125 0 (=125)
1141221153:871808: rtc 448 int 125 0 (=125)
1141221154:371796: rtc 464 int 125 0 (=125)
1141221154:871784: rtc 448 int 125 0 (=125)
1141221155:371771: rtc 464 int 71 54 (=125)
1141221155:871759: rtc 448 int 0 125 (=125)
1141221156:371745: rtc 464 int 0 125 (=125)
1141221156:871734: rtc 448 int 0 125 (=125)
1141221157:371721: rtc 464 int 0 125 (=125)
1141221157:871709: rtc 448 int 0 125 (=125)
1141221158:371696: rtc 464 int 0 125 (=125)
1141221158:871685: rtc 448 int 0 125 (=125)
1141221159:371672: rtc 464 int 0 125 (=125)
1141221159:871660: rtc 448 int 0 125 (=125)
1141221160:371648: rtc 464 int 0 125 (=125)
1141221160:871635: rtc 448 int 0 125 (=125)
1141221161:371622: rtc 464 int 0 125 (=125)
1141221161:871610: rtc 448 int 0 125 (=125)
1141221162:371599: rtc 464 int 0 125 (=125)
1141221162:871586: rtc 448 int 0 125 (=125)
1141221163:371573: rtc 464 int 0 125 (=125)
1141221163:871561: rtc 448 int 0 125 (=125)
1141221164:371549: rtc 464 int 0 125 (=125)
1141221164:871537: rtc 448 int 0 125 (=125)
1141221165:371526: rtc 464 int 53 72 (=125)
1141221165:871510: rtc 448 int 125 0 (=125)
1141221166:371502: rtc 464 int 125 0 (=125)
1141221166:871488: rtc 448 int 125 0 (=125)
1141221167:371476: rtc 464 int 125 0 (=125)
1141221167:871471: rtc 448 int 125 0 (=125)
1141221168:371451: rtc 464 int 125 0 (=125)
1141221168:871439: rtc 448 int 125 0 (=125)
1141221169:371427: rtc 464 int 125 0 (=125)
1141221169:871415: rtc 448 int 125 0 (=125)
1141221170:371402: rtc 464 int 125 0 (=125)
1141221170:871390: rtc 448 int 125 0 (=125)
1141221171:371377: rtc 464 int 125 0 (=125)
1141221171:871365: rtc 448 int 125 0 (=125)
1141221172:371352: rtc 464 int 125 0 (=125)
1141221172:875382: rtc 448 int 123 0 (=123)  <-----
1141221173:375328: rtc 464 int 125 0 (=125)
1141221173:875340: rtc 448 int 125 0 (=125)

Kernel log highlights (idle=poll):

Kernel command line: ro root=/dev/md2 report_lost_ticks idle=poll
using polling idle threads.
...
time.c: Using 3.579545 MHz PM timer.
time.c: Detected 2009.264 MHz processor.
...
Using local APIC timer interrupts.
Detected 12.557 MHz APIC timer.
time.c: Lost 11 timer tick(s)! rip setup_boot_APIC_clock+0x117/0x11a)
Booting processor 1/2 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 4018.82 BogoMIPS (lpj=8037642)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 1(1) -> Node 0 -> Core 0
AMD Opteron(tm) Processor 246 stepping 0a
CPU 1: Syncing TSC to CPU 0.
CPU 1: synchronized TSC with CPU 0 (last diff -129 cycles, maxerr 1112 cycles)
Brought up 2 CPUs
Disabling vsyscall due to use of PM timer
time.c: Using PM based timekeeping.
testing NMI watchdog ... <4>time.c: Lost 29 timer tick(s)! rip __delay+0x8/0x10)
OK.
...
powernow-k8: Found 2 AMD Athlon 64 / Opteron processors (version 1.50.4)
powernow-k8: MP systems not supported by PSB BIOS structure
powernow-k8: MP systems not supported by PSB BIOS structure
...
time.c: Lost 3 timer tick(s)! rip poll_idle+0x14/0x19)
time.c: Lost 3 timer tick(s)! rip poll_idle+0x14/0x19)
time.c: Lost 1 timer tick(s)! rip poll_idle+0x14/0x19)
time.c: Lost 2 timer tick(s)! rip poll_idle+0xa/0x19)
time.c: Lost 1 timer tick(s)! rip poll_idle+0x14/0x19)
time.c: Lost 1 timer tick(s)! rip poll_idle+0x14/0x19)
time.c: Lost 1 timer tick(s)! rip poll_idle+0x14/0x19)
time.c: Lost 1 timer tick(s)! rip poll_idle+0x14/0x19)
time.c: Lost 1 timer tick(s)! rip poll_idle+0x14/0x19)
time.c: Lost 1 timer tick(s)! rip poll_idle+0x14/0x19)
time.c: Lost 1 timer tick(s)! rip poll_idle+0xa/0x19)
time.c: Lost 1 timer tick(s)! rip poll_idle+0x14/0x19)
time.c: Lost 1 timer tick(s)! rip poll_idle+0xa/0x19)
time.c: Lost 1 timer tick(s)! rip poll_idle+0x14/0x19)
time.c: Lost 1 timer tick(s)! rip poll_idle+0xa/0x19)
time.c: Lost 1 timer tick(s)! rip poll_idle+0x14/0x19)
time.c: Lost 2 timer tick(s)! rip poll_idle+0x14/0x19)
time.c: Lost 1 timer tick(s)! rip poll_idle+0x14/0x19)
time.c: Lost 1 timer tick(s)! rip poll_idle+0xa/0x19)
time.c: Lost 1 timer tick(s)! rip poll_idle+0x14/0x19)
time.c: Lost 3 timer tick(s)! rip poll_idle+0xa/0x19)
Losing some ticks... checking if CPU frequency changed.
time.c: Lost 1 timer tick(s)! rip poll_idle+0x14/0x19)
time.c: Lost 1 timer tick(s)! rip poll_idle+0xa/0x19)
time.c: Lost 1 timer tick(s)! rip poll_idle+0x14/0x19)
time.c: Lost 1 timer tick(s)! rip poll_idle+0xa/0x19)
time.c: Lost 1 timer tick(s)! rip poll_idle+0x14/0x19)
time.c: Lost 1 timer tick(s)! rip poll_idle+0xa/0x19)
time.c: Lost 1 timer tick(s)! rip poll_idle+0x14/0x19)
time.c: Lost 2 timer tick(s)! rip poll_idle+0x14/0x19)
time.c: Lost 3 timer tick(s)! rip poll_idle+0x14/0x19)
time.c: Lost 1 timer tick(s)! rip poll_idle+0x14/0x19)
time.c: Lost 2 timer tick(s)! rip poll_idle+0xa/0x19)
time.c: Lost 1 timer tick(s)! rip poll_idle+0x14/0x19)
time.c: Lost 3 timer tick(s)! rip poll_idle+0xa/0x19)
time.c: Lost 1 timer tick(s)! rip poll_idle+0xa/0x19)
time.c: Lost 2 timer tick(s)! rip poll_idle+0x14/0x19)


Thanks.

	Bill
