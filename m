Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268042AbUJHHgk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268042AbUJHHgk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 03:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268155AbUJHHgk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 03:36:40 -0400
Received: from sicdec1.epfl.ch ([128.178.50.33]:25250 "EHLO sicdec1.epfl.ch")
	by vger.kernel.org with ESMTP id S268042AbUJHHg1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 03:36:27 -0400
Message-ID: <1097220985.41664379b7c1b@imapwww.epfl.ch>
X-Imap-User: michel.mengis@epfl.ch
Date: Fri,  8 Oct 2004 09:36:25 +0200
From: michel.mengis@epfl.ch
To: linux <linux-kernel@vger.kernel.org>
Subject: Kernel 2.6.8 and DELL's DOTHAN Processor B0 (more informations)
References: <1097216489.416631e91faf9@imapwww.epfl.ch> <416634FE.60108@kolivas.org>
In-Reply-To: <416634FE.60108@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.6
X-Originating-IP: 128.178.9.34
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here I'm puting some more informations:

[root@localhost root]# cat cpuinfo.txt
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 13
model name      : Intel(R) Pentium(R) M processor 1.70GHz
stepping        : 6
cpu MHz         : 599.639
cache size      : 2048 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 mtrr pge mca cmov pat clflush
dts acpi mmx fxsr sse sse2 ss tm pbe tm2 est
bogomips        : 1183.74
------------------------------------------------------------------------------


2.6.8-1.521.poseidon.root: is my own built with latest acpi fix and the 3 dothan
patches...

[root@localhost root]# cat dmesg
Linux version 2.6.8-1.521.poseidon.root (gcc version 3.3.3 20040412 (Red Hat
Linux 3.3.3-7)) #1 Thu Oct 7 15:23:43 CEST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ffae000 (usable)
 BIOS-e820: 000000001ffae000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000feda0000 - 00000000fee00000 (reserved)
 BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
511MB LOWMEM available.
zapping low mappings.
On node 0 totalpages: 130990
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126894 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 DELL                                  ) @ 0x000fdf00
ACPI: RSDT (v001 DELL    CPi R   0x27d40903 ASL  0x00000061) @ 0x1fff0000
ACPI: FADT (v001 DELL    CPi R   0x27d40903 ASL  0x00000061) @ 0x1fff0400
ACPI: ASF! (v016 DELL    CPi R   0x27d40903 ASL  0x00000061) @ 0x1fff0800
ACPI: BOOT (v001 DELL    CPi R   0x27d40903 ASL  0x00000061) @ 0x1fff07c0
ACPI: DSDT (v001 INT430 SYSFexxx 0x00001001 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x808
Built 1 zonelists
Kernel command line: ro root=/dev/hda5 quiet acpi=on apm=off
mapped 4G/4G trampoline to ffff3000.
Initializing CPU#0
CPU 0 irqstacks, hard=023ca000 soft=023c9000
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 599.639 MHz processor.


As u can see at boottime the processor detected is only a 600Mhz instead 1.7Ghz.
on my D600 pentium M not Dothan, here it's written 1.6Ghz.

I think this is the reason that bring ACPI cpufreq checker to reduce the max
spped to 600mhz.

is there a fix ??


Quoting Con Kolivas <lkml@kolivas.org>:

> michel.mengis@epfl.ch wrote:
> >
> > Hi all,
> >
> > I have a lot of trouble to bring the kernel 2.6.8-1 to detect my dothan
> > processor.
> > It's a Pentium M Dothan B0 version, 1.7Ghz/600Mhz.
> > The BIOS is DELL's D800 Bios version 09.
> >
> > I added 3 patches:
> > cpufreq-speedstep-dothan-3.patch :add correct frequency table in
> speedstep.c
> > dothan-speedstep-fix.patch : add correct Level2 cache
> > bk-cpufreq.patch : from http://linux-dj.bkbits.net/cpufreq
> >
> > I added a lot of output in speedstep-centrino.c, acpi/processor.c to track
> the
> > problem.
> >
> > I notice that my computer is running always in the lowest speed evenif I'm
> > stressing it... All ouputs I added show me that Speedstep isn't the cause,
> > neither CPUFreq but while CPUFreq calls all notifiers, acpi/processor.c's
> > CPUFREQ_INCOMPATIBLE change the max speed to the lowest evenif during
> > cpufreq_acpi_cpu_init the max speed is well detected.
> > Seems to be like it's coz at boot time the kernel doesn't detect correctly
> the
> > max speed.
> > dmesg shows me that a 600Mhz processor has been detected only and not
> 1.7Ghz.
> > (on my D600 pentium M not dothan, it detects correctly 1.6Ghz)
> >
> > is there a fix for that ?
> > is it a known bug ?
> >
> > thx for all help I can get,
>
> Sounds like you've chosen powersave as the default power governor in
> your config. Change it to performance or modify it manually in
> /sys/devices.... cpufreq/scaling_governor
> (cant remember the exact position; you'll find it)
>
> cat the output of that file and see if it says powersave performance or
> ondemand. You can manually change it from one to the other, or set
> either powersave or performance in your config during kernel config.
>
> Cheers,
> Con
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


