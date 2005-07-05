Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262011AbVGEX0h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262011AbVGEX0h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 19:26:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262007AbVGEX0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 19:26:37 -0400
Received: from mail7.mclink.it ([195.110.128.94]:25103 "EHLO mail7.mclink.it")
	by vger.kernel.org with ESMTP id S262011AbVGEX0E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 19:26:04 -0400
Message-ID: <42CB1707.6000205@mclink.it>
Date: Wed, 06 Jul 2005 01:25:59 +0200
From: Carlo Scarfoglio <mi2332@mclink.it>
User-Agent: Mozilla/5.0 (compatible; MSIE 5.5; Windows 98)
X-Accept-Language: it, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: realtime-preempt-2.6.12-final-V0.7.51-01 compile error and more problems
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compilation stops at this point:

make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
   CHK     include/linux/compile.h
   CHK     usr/initramfs_list
   CC      net/ipv4/netfilter/ip_conntrack_proto_tcp.o
net/ipv4/netfilter/ip_conntrack_proto_tcp.c: In function 
`tcp_print_conntrack':
net/ipv4/netfilter/ip_conntrack_proto_tcp.c:333: error: `tcp_lock' 
undeclared (first use in this function)
net/ipv4/netfilter/ip_conntrack_proto_tcp.c:333: error: (Each undeclared 
identifier is reported only once
net/ipv4/netfilter/ip_conntrack_proto_tcp.c:333: error: for each 
function it appears in.)
net/ipv4/netfilter/ip_conntrack_proto_tcp.c:333: warning: type defaults 
to `int' in declaration of `type name'
etc. etc..

Most likely it depends on the redefinition of DECLARE_RWLOCK in lockhelp.h


More problems....

Patch 7.50-48 has been the first rt kernel that compiled and booted 
cleanly on my system.

I'm testing the rt kernels because I want to use jack as my system sound 
mixer/router
and to record lp's with my ice1712-based sound card. I have no rt 
requrements, of course,
but I want to get rid of xruns. Kernel 2.6.12 vanilla is quite good 
already (a big improvement
over previous kernels) but still ...

Patch 7.50-48 been running for two days now and seems pretty stable but:

1) My logs are filled with Apic errors all like this

Jul  5 04:30:01 linux kernel: APIC error on CPU0: 02(02)

every 2 seconds, or minute, at random. I've never seen these messages 
before with vanilla kernels,
so it's a bit weird.

2) Whenever I play an mp3 or watch a movie (through jack) I get 
thousands of times these errors in the logs

Jul  5 20:45:56 linux kernel: `IRQ 8'[828] is being piggy. 
need_resched=0, cpu=0
Jul  5 20:45:56 linux kernel: Read missed before next interrupt
Jul  5 20:45:56 linux kernel: wow!  That was a 12 millisec bump
Jul  5 20:45:56 linux kernel: bug in rtc_read(): called in state S_IDLE!
Jul  5 20:45:56 linux kernel: `IRQ 8'[828] is being piggy. 
need_resched=0, cpu=0
Jul  5 20:45:56 linux kernel: Read missed before next interrupt
Jul  5 20:45:56 linux kernel: wow!  That was a 3 millisec bump
Jul  5 20:45:56 linux kernel: bug in rtc_read(): called in state S_IDLE!

This is a known issue, RTC  interrupts are missed. I have noticed it 
many times when ntp is
running. It stops working after a few minutes of playing when the the 
error exceeds 500 PPM.
But I thought that ntp compared external reference clocks to the system 
timer, so the system
was missing int 0, not int 8.  My mobo has a crappy timer anyway. I had 
to reduce the tick to 9934
in order to allow ntp to run.

3) I had to disable polling of the cpu temperature by kacpid because 
whenever it did the sound
stopped for 1-3 seconds. The polling took longer and longer after a few 
hours of uptime.
The nice thing is, it caused no xruns. Kernel 2.6.12 vanilla has the 
same problem, though.

4) Xruns occur every 10-60 minutes even when the system is practically 
idle (no playback
or recording). When copying large files (between sata disks on two 
sil3112 controllers)
xruns frequency is much higher.  When sound is used xruns occur every 2 
or 20 minutes.


This is a nForce2-mobo (Abit NF7-S V 2.0), Athlon 2800, 1 GB Ram, 
Terratec DMX6Fire,
nVidia 4200 video card, 2 sil3112 sata controllers with 3 disks,etc. 
SuSE 9.1 with KDE 3.4 and
uptodate jack, xmms, mplayer, sound libraries and recording apps.

If more details are needed or I can perform some tests, feel free to ask.

Cheers,

		Carlo Scarfoglio



