Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272547AbRIKTs4>; Tue, 11 Sep 2001 15:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272548AbRIKTsg>; Tue, 11 Sep 2001 15:48:36 -0400
Received: from s340-modem1093.dial.xs4all.nl ([194.109.164.69]:1159 "EHLO
	sjoerd.sjoerdnet") by vger.kernel.org with ESMTP id <S272547AbRIKTsa>;
	Tue, 11 Sep 2001 15:48:30 -0400
Date: Tue, 11 Sep 2001 21:47:54 +0200 (CEST)
From: Arjan Filius <iafilius@xs4all.nl>
X-X-Sender: <arjan@sjoerd.sjoerdnet>
Reply-To: Arjan Filius <iafilius@xs4all.nl>
To: Robert Love <rml@tech9.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Feedback on preemptible kernel patch
In-Reply-To: <1000071474.16805.20.camel@phantasy>
Message-ID: <Pine.LNX.4.33.0109112137140.4840-100000@sjoerd.sjoerdnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 9 Sep 2001, Robert Love wrote:

> On Sun, 2001-09-09 at 17:23, Arjan Filius wrote:
> > After my succes report i _do_ noticed something unusual:
> >
> > I'm not sure it's preempt related, but you wanted feedback :)
> >
> > Sep  9 23:08:02 sjoerd kernel: __alloc_pages: 0-order allocation failed (gfp=0x70/1).
> > Sep  9 23:08:02 sjoerd last message repeated 93 times
> > Sep  9 23:08:02 sjoerd kernel: cation failed (gfp=0x70/1).
> > Sep  9 23:08:02 sjoerd kernel: __alloc_pages: 0-order allocation failed (gfp=0x70/1).
> > Sep  9 23:08:02 sjoerd last message repeated 281 times
> >
> > This is at the very moment i make a ppp connection to internet, and
> > get/set the time with netdate (for the first time after a reboot).
> > I didn't see this a second time (yet).
> >
>
> damn, I was exciting we had solved everything :)
>
> actually, I am not confident of what could cause these results.  the
> 2.4.10-pre is going through another set of changes it should not, and
> one of them concerns exactly what you are reporting.
>
> SO, I suggest two options: try pre6.  I don't have patches yet, but I
> will diff them soon.  pre5 should apply fairly cleanly, anyhow.
>
> Even better, try 2.4.9-ac10.  It is what I use, and there seems to be
> less reported problems.  Plus, Alan is not messing with all the VM work
> Linus is playing with right now.  Patches for 2.4.9-ac10 are available.
>
> Both can be had at:
> http://tech9.net/rml/linux/
>
> I am curious if you see the error again, and what seems to cause it, but
> honestly there is too much work being done in 2.4.10-pre to figure
> things out.
>
> Nevertheless, I will look into it -- keep me posted.
>

It took some time, but here the results.

I do seem to have no problem at all with plain 2.4.10-pre6 and 2.4.9-ac10.

As adviced i tried the 2.4.9-ac10 with the preempt patch (without extra
lock-patch posted on lkm)
Just booted the system and i noticed various (4x) "invalid operand"'s, and
the 4 seconds from my systlog are below.

Sep 11 19:47:31 sjoerd kernel: klogd 1.3-3, log source = /proc/kmsg started.
Sep 11 19:47:31 sjoerd kernel: Inspecting /boot/System.map-2.4.9-ac10
Sep 11 19:47:31 sjoerd kernel: Loaded 13938 symbols from /boot/System.map-2.4.9-ac10.
Sep 11 19:47:31 sjoerd kernel: Symbols match kernel version 2.4.9.
Sep 11 19:47:31 sjoerd kernel: Loaded 584 symbols from 42 modules.
Sep 11 19:47:31 sjoerd kernel: IPv6 v0.8 for NET4.0
Sep 11 19:47:31 sjoerd kernel: IPv6 over IPv4 tunneling driver
Sep 11 19:47:31 sjoerd kernel: divert: not allocating divert_blk for non-ethernet device sit0
Sep 11 19:47:31 sjoerd kernel: divert: allocating divert_blk for eth0
Sep 11 19:47:31 sjoerd kernel: acenic.c: v0.81 04/20/2001  Jes Sorensen, linux-acenic@SunSITE.dk
Sep 11 19:47:31 sjoerd kernel:                             http://home.cern.ch/~jes/gige/acenic.html
Sep 11 19:47:31 sjoerd kernel: eth0: 3Com 3C985 Gigabit Ethernet at 0xdd800000, irq 11
Sep 11 19:47:31 sjoerd kernel:   Tigon II (Rev. 6), Firmware: 12.4.11, MAC: 00:60:08:f6:1d:5b
Sep 11 19:47:31 sjoerd kernel:   PCI cache line size set incorrectly (32 bytes) by BIOS/FW, correcting to 64
Sep 11 19:47:31 sjoerd kernel:   PCI bus width: 32 bits, speed: 33MHz, latency: 64 clks
Sep 11 19:47:31 sjoerd kernel:   Disabling PCI memory write and invalidate
Sep 11 19:47:31 sjoerd kernel: eth0: Firmware up and running
Sep 11 19:47:31 sjoerd kernel: eth0: Optical link UP (Full Duplex, Flow Control: TX RX)
Sep 11 19:47:31 sjoerd kernel: ip_conntrack (8192 buckets, 65536 max)
Sep 11 19:47:31 sjoerd kernel: ip_tables: (c)2000 Netfilter core team
Sep 11 19:47:31 sjoerd kernel: LOIN ICMP rate to high IN=lo OUT= MAC=00:00:00:00:00:00:00:00:00:00:00:00:08:00 SRC=127.0.0.1 DST=127.0.0.1 LEN=90 TOS=0x02 PREC=0xC0 TTL=255 ID=32406 PROTO=ICMP TYPE=3 CODE=3 [SRC=127.0.0.1 DST=127.0.0.1 LEN=62 TOS=0x02 PREC=0x00 TTL=64 ID=6694 DF PROTO=UDP SPT=32768 DPT=53 LEN=42 ]
Sep 11 19:47:31 sjoerd kernel: LOIN ICMP rate to high IN=lo OUT= MAC=00:00:00:00:00:00:00:00:00:00:00:00:08:00 SRC=127.0.0.1 DST=127.0.0.1 LEN=102 TOS=0x02 PREC=0xC0 TTL=255 ID=32413 PROTO=ICMP TYPE=3 CODE=3 [SRC=127.0.0.1 DST=127.0.0.1 LEN=74 TOS=0x02 PREC=0x00 TTL=64 ID=6783 DF PROTO=UDP SPT=32769 DPT=53 LEN=54 ]
Sep 11 19:47:31 sjoerd kernel: LOIN ICMP rate to high IN=lo OUT= MAC=00:00:00:00:00:00:00:00:00:00:00:00:08:00 SRC=127.0.0.1 DST=127.0.0.1 LEN=92 TOS=0x02 PREC=0xC0 TTL=255 ID=32421 PROTO=ICMP TYPE=3 CODE=3 [SRC=127.0.0.1 DST=127.0.0.1 LEN=64 TOS=0x02 PREC=0x00 TTL=64 ID=7284 DF PROTO=UDP SPT=32770 DPT=53 LEN=44 ]
Sep 11 19:47:31 sjoerd kernel: eth0: no IPv6 routers present
Sep 11 19:47:31 sjoerd kernel: LOIN ICMP rate to high IN=lo OUT= MAC=00:00:00:00:00:00:00:00:00:00:00:00:08:00 SRC=127.0.0.1 DST=127.0.0.1 LEN=102 TOS=0x02 PREC=0xC0 TTL=255 ID=32427 PROTO=ICMP TYPE=3 CODE=3 [SRC=127.0.0.1 DST=127.0.0.1 LEN=74 TOS=0x02 PREC=0x00 TTL=64 ID=7785 DF PROTO=UDP SPT=32770 DPT=53 LEN=54 ]
Sep 11 19:47:31 sjoerd kernel: device eth0 entered promiscuous mode
Sep 11 19:47:31 sjoerd kernel: invalid operand: 0000
Sep 11 19:47:31 sjoerd kernel: CPU:    0
Sep 11 19:47:31 sjoerd kernel: EIP:    0010:[do_anonymous_page+160/304]
Sep 11 19:47:31 sjoerd kernel: EFLAGS: 00010206
Sep 11 19:47:31 sjoerd kernel: eax: f54fc000   ebx: f7771e00   ecx: c023eee8   edx: c0001ff8
Sep 11 19:47:31 sjoerd kernel: esi: c289b37c   edi: f7632c00   ebp: f5519068   esp: f54fddd0
Sep 11 19:47:31 sjoerd kernel: ds: 0018   es: 0018   ss: 0018
Sep 11 19:47:31 sjoerd kernel: Process snort (pid: 2059, stackpage=f54fd000)
Sep 11 19:47:31 sjoerd kernel: Stack: 4001a000 00000000 f7632c00 f7771e00 c01236b1 f7771e00 f7632c00 f5519068
Sep 11 19:47:31 sjoerd kernel:        00000001 4001a000 4001a000 f7771e00 ffffffff 00000001 c012382e f7771e00
Sep 11 19:47:31 sjoerd kernel:        f7632c00 4001a000 00000001 f5519068 f54fc000 f7632c00 f7771e00 f7771e1c
Sep 11 19:47:31 sjoerd kernel: Call Trace: [do_no_page+49/336] [handle_mm_fault+94/240] [do_page_fault+407/1200] [do_page_fault+0/1200] [do_rw_disk+290/832]
Sep 11 19:47:31 sjoerd kernel:    [start_request+312/528] [start_request+405/528] [ide_do_request+711/800] [error_code+56/68] [file_read_actor+96/192] [do_generic_file_read+517/1264]
Sep 11 19:47:31 sjoerd kernel:    [generic_file_read+99/128] [file_read_actor+0/192] [sys_read+150/208] [system_call+51/56]
Sep 11 19:47:31 sjoerd kernel:
Sep 11 19:47:31 sjoerd kernel: Code: 0f 0b 89 f0 2b 05 ec 63 29 c0 69 c0 f1 f0 f0 f0 c1 f8 02 c1
Sep 11 19:47:31 sjoerd kernel:  <6>device eth0 left promiscuous mode
Sep 11 19:47:31 sjoerd kernel: device eth0 entered promiscuous mode
Sep 11 19:47:31 sjoerd kernel: eth0: Enabling Jumbo frame support
Sep 11 19:47:31 sjoerd kernel: Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Sep 11 19:47:31 sjoerd kernel: LOOUT REJECT UDP IN= OUT=lo SRC=127.0.0.1 DST=127.0.0.1 LEN=84 TOS=0x02 PREC=0x00 TTL=64 ID=0 DF PROTO=UDP SPT=605 DPT=111 LEN=64
Sep 11 19:47:31 sjoerd kernel: LOOUT REJECT UDP IN= OUT=lo SRC=127.0.0.1 DST=127.0.0.1 LEN=84 TOS=0x02 PREC=0x00 TTL=64 ID=0 DF PROTO=UDP SPT=607 DPT=111 LEN=64

Sep 11 19:48:43 sjoerd : time=1000230523  unable to read "uptime"   ^I../SRC/dqs_load_avg.c 239 /usr/sbin/dqs_execd sjoerd.sjoerdnet
Sep 11 19:48:43 sjoerd kernel: invalid operand: 0000
Sep 11 19:48:43 sjoerd kernel: CPU:    0
Sep 11 19:48:43 sjoerd kernel: EIP:    0010:[filemap_nopage+284/1168]
Sep 11 19:48:43 sjoerd kernel: EFLAGS: 00010206
Sep 11 19:48:43 sjoerd kernel: eax: c2658524   ebx: 00000001   ecx: c023eee8   edx: c0001ff8
Sep 11 19:48:43 sjoerd kernel: esi: c297d838   edi: 00000015   ebp: c2658524   esp: f4169b3c
Sep 11 19:48:43 sjoerd kernel: ds: 0018   es: 0018   ss: 0018
Sep 11 19:48:43 sjoerd kernel: Process sh (pid: 2708, stackpage=f4169000)
Sep 11 19:48:43 sjoerd kernel: Stack: 40016000 f77153c0 f4372500 f4a67740 00000019 f7b173b8 f7715478 f77153c0
Sep 11 19:48:43 sjoerd kernel:        f4439f40 c0123720 f4372500 40016000 00000001 400162a8 f4a67740 ffffffff
Sep 11 19:48:43 sjoerd kernel:        00000001 c012382e f4a67740 f4372500 400162a8 00000001 f409a058 f4168000
Sep 11 19:48:43 sjoerd kernel: Call Trace: [do_no_page+160/336] [handle_mm_fault+94/240] [do_page_fault+407/1200] [do_page_fault+0/1200] [kunmap_high+86/128]
Sep 11 19:48:43 sjoerd kernel:    [file_read_actor+145/192] [update_atime+68/80] [do_generic_file_read+1246/1264] [do_munmap+86/608] [update_atime+68/80] [error_code+56/68]
Sep 11 19:48:43 sjoerd kernel:    [clear_user+46/64] [padzero+28/32] [load_elf_interp+619/704] [load_elf_binary+1927/2672] [load_elf_binary+0/2672] [kunmap_high+86/128]
Sep 11 19:48:43 sjoerd kernel:    [file_read_actor+145/192] [search_binary_handler+152/496] [do_execve+380/496] [do_execve+403/496] [sys_execve+47/96] [system_call+51/56]
Sep 11 19:48:43 sjoerd kernel:
Sep 11 19:48:43 sjoerd kernel: Code: 0f 0b 89 f0 2b 05 ec 63 29 c0 69 c0 f1 f0 f0 f0 c1 f8 02 c1

Sep 11 19:48:45 sjoerd kernel:  invalid operand: 0000
Sep 11 19:48:45 sjoerd kernel: CPU:    0
Sep 11 19:48:45 sjoerd kernel: EIP:    0010:[do_wp_page+604/912]
Sep 11 19:48:45 sjoerd kernel: EFLAGS: 00010206
Sep 11 19:48:45 sjoerd kernel: eax: c1004520   ebx: c1000010   ecx: c1000010   edx: c0001ff8
Sep 11 19:48:45 sjoerd kernel: esi: c25c0ff8   edi: c25984ec   ebp: 51e5a065   esp: f4001ed4
Sep 11 19:48:45 sjoerd kernel: ds: 0018   es: 0018   ss: 0018
Sep 11 19:48:45 sjoerd kernel: Process oracle (pid: 2718, stackpage=f4001000)
Sep 11 19:48:45 sjoerd kernel: Stack: 093e1a6c f4a678c0 ffffffff 00000001 c0123861 f4a678c0 f4024380 093e1a6c
Sep 11 19:48:45 sjoerd kernel:        f4016f84 51e5a065 f4000000 f4024380 f4a678c0 f4a678dc c0110ca7 f4a678c0
Sep 11 19:48:45 sjoerd kernel:        f4024380 093e1a6c 00000001 f4000000 00000007 c0110b10 bfffca1c f4a678dc
Sep 11 19:48:45 sjoerd kernel: Call Trace: [handle_mm_fault+145/240] [do_page_fault+407/1200] [do_page_fault+0/1200] [dput+25/416] [fput+116/224]
Sep 11 19:48:45 sjoerd kernel:    [filp_close+156/176] [sys_close+93/144] [error_code+56/68]
Sep 11 19:48:45 sjoerd kernel:
Sep 11 19:48:45 sjoerd kernel: Code: 0f 0b 89 f0 29 c8 69 c0 f1 f0 f0 f0 c1 f8 02 c1 e0 0c 0b 05

Sep 11 19:53:04 sjoerd kernel: invalid operand: 0000
Sep 11 19:53:04 sjoerd kernel: CPU:    0
Sep 11 19:53:04 sjoerd kernel: EIP:    0010:[filemap_nopage+284/1168]
Sep 11 19:53:04 sjoerd kernel: EFLAGS: 00010206
Sep 11 19:53:04 sjoerd kernel: eax: c23c8b9c   ebx: 00000001   ecx: c023eee8   edx: c0001ff8
Sep 11 19:53:04 sjoerd kernel: esi: c297d838   edi: 00000015   ebp: c23c8b9c   esp: f34a5b3c
Sep 11 19:53:04 sjoerd kernel: ds: 0018   es: 0018   ss: 0018
Sep 11 19:53:04 sjoerd kernel: Process qmail-remote (pid: 3084, stackpage=f34a5000)
Sep 11 19:53:04 sjoerd kernel: Stack: 40016000 f77153c0 f35da900 f3b70d40 00000019 f7b173b8 f7715478 f77153c0
Sep 11 19:53:04 sjoerd kernel:        f484e240 c0123720 f35da900 40016000 00000001 400162a8 f3b70d40 ffffffff
Sep 11 19:53:04 sjoerd kernel:        00000001 c012382e f3b70d40 f35da900 400162a8 00000001 f34c4058 f34a4000
Sep 11 19:53:04 sjoerd kernel: Call Trace: [do_no_page+160/336] [handle_mm_fault+94/240] [do_page_fault+407/1200] [do_page_fault+0/1200] [kunmap_high+86/128]
Sep 11 19:53:04 sjoerd kernel:    [file_read_actor+145/192] [update_atime+68/80] [do_generic_file_read+1246/1264] [do_munmap+86/608] [update_atime+68/80] [error_code+56/68]
Sep 11 19:53:04 sjoerd kernel:    [clear_user+46/64] [padzero+28/32] [load_elf_interp+619/704] [load_elf_binary+1927/2672] [load_elf_binary+0/2672] [search_binary_handler+152/496]
Sep 11 19:53:04 sjoerd kernel:    [do_execve+380/496] [do_execve+403/496] [sys_execve+47/96] [system_call+51/56]
Sep 11 19:53:04 sjoerd kernel:
Sep 11 19:53:04 sjoerd kernel: Code: 0f 0b 89 f0 2b 05 ec 63 29 c0 69 c0 f1 f0 f0 f0 c1 f8 02 c1


I rebooted the the same patched kernel with the mem=850M option (no
highmem used then), and i'm running it for a few hours but doesn't complain with
any special kernel message. And seems runs _just fine_.



Greetings,


-- 
Arjan Filius
mailto:iafilius@xs4all.nl

