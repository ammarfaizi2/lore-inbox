Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267565AbUH2CEX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267565AbUH2CEX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 22:04:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267575AbUH2CEX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 22:04:23 -0400
Received: from mail-01.iinet.net.au ([203.59.3.33]:36484 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S267565AbUH2CEG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 22:04:06 -0400
Date: Sun, 29 Aug 2004 10:02:47 +0800 (WST)
From: Michael <quadfour@iinet.net.au>
X-X-Sender: quadfour@natalie
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.8.1 OOPS, processes hanging in D state, can reproduce
In-Reply-To: <1093740497.7078.15.camel@krustophenia.net>
Message-ID: <Pine.LNX.4.50.0408290951430.5632-100000@natalie>
References: <Pine.LNX.4.50.0408290659030.3632-100000@natalie>
 <1093740497.7078.15.camel@krustophenia.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Aug 2004, Lee Revell wrote:

> 
> On Sat, 2004-08-28 at 20:25, Michael wrote:
> > First post to the list, never found a kernel bug before :)
> > 
> 
> Your kernel is tainted, probably due to having a binary module loaded. 
> Please reproduce with an untainted kernel and repost.

I've removed the Nvidia binary module and rebooted so the kernel is no 
longer tainted. 

To mostly quote my previous post, with 2.6.8.1 and the 2.6.8 RC kernels, 
processes trying to make use of my IDE devices can intermittantly hang in 
the 'D' state. When this occurs there is a kernel OOPS in dmesg and in 
of everything. This occasion I am testing and reproducing the 
problem remotely and am not able to get the output of a Alt-SysRq-T 

I can reproduce this problem eventually doing one of the following.
Normally the first method reproduces the problem the quickest, though all
have caused this problem. 

1) Mounting an ISO (loopback) and/or copying a file from it.
2) Running lilo
3) Running mkinitrd

Any attempts to kill the hung process (with -9) fail, and attempting to
re-run the command that hung will just make more stuck processes. The OOPS
that appears in dmesg once the process hangs in the D state is as
follows, and other log information can be found here at
http://members.iinet.net.au/~quadfour/kernel/
 
Aug 29 09:08:22 natalie kernel: loop: loaded (max 8 devices)
Aug 29 09:08:22 natalie kernel: Unable to handle kernel paging request at 
virtual address fe83e000
Aug 29 09:08:22 natalie kernel:  printing eip:
Aug 29 09:08:22 natalie kernel: f89fb04b
Aug 29 09:08:22 natalie kernel: *pde = 00000000
Aug 29 09:08:22 natalie kernel: Oops: 0000 [#3]
Aug 29 09:08:22 natalie kernel: Modules linked in: loop ov511 ovcamchip 
dvb-bt8xx dst dvb-core bt878 v4l1-compat tuner bttv video-buf i2c-algo-bit 
v4l2-common btcx-risc videodev ipt_state ipt_REDIRECT ipt_MASQUERADE 
iptable_nat ip_conntrack iptable_filter ip_tables ppp_synctty ppp_async 
crc-ccitt ppp_generic slhc autofs4 lp parport_pc parport ipv6 es1371 
soundcore gameport ac97_codec af_packet ide-floppy ide-tape ide-cd cdrom 
floppy sk98lin i2c-core amd64-agp agpgart ehci-hcd uhci-hcd usbcore rtc 
ext3 jbd sd_mod sata_via sata_promise libata scsi_mod
Aug 29 09:08:22 natalie kernel: CPU:    0
Aug 29 09:08:22 natalie kernel: EIP:    0060:[pg0+945582155/1069326336]    
Not tainted VLI
Aug 29 09:08:22 natalie kernel: EIP:    0060:[<f89fb04b>]    Not tainted 
VLI
Aug 29 09:08:22 natalie kernel: EFLAGS: 00010216   (2.6.8.1-2mdk)
Aug 29 09:08:22 natalie kernel: EIP is at transfer_none+0x4b/0x90 [loop]
Aug 29 09:08:22 natalie kernel: eax: fe83e000   ebx: 00000800   ecx: 
00000200   edx: f7dba000
Aug 29 09:08:22 natalie kernel: esi: fe83e000   edi: f7dba000   ebp: 
f7217e64   esp: f7217e54
Aug 29 09:08:22 natalie kernel: ds: 007b   es: 007b   ss: 0068
Aug 29 09:08:22 natalie kernel: Process loop0 (pid: 5298, 
threadinfo=f7216000 task=f79232a0)
Aug 29 09:08:22 natalie kernel: Stack: f89fb000 00000000 00000800 f7217f68 
f7217eac f89fb5ca f747d000 00000000
Aug 29 09:08:22 natalie kernel:        c17d07c0 00000000 c16fb740 00000000 
00000800 00000000 00000000 00000000
Aug 29 09:08:22 natalie kernel:        c16fb740 f747d000 00000800 00001000 
c17d07c0 f7217f3c f7217f1c c013664f
Aug 29 09:08:22 natalie kernel: Call Trace:
Aug 29 09:08:22 natalie kernel:  [show_stack+117/144] show_stack+0x75/0x90
Aug 29 09:08:22 natalie kernel:  [<c0107025>] show_stack+0x75/0x90
Aug 29 09:08:22 natalie kernel:  [show_registers+281/400] 
show_registers+0x119/0x190
Aug 29 09:08:22 natalie kernel:  [<c0107179>] show_registers+0x119/0x190
Aug 29 09:08:22 natalie kernel:  [die+80/176] die+0x50/0xb0
Aug 29 09:08:22 natalie kernel:  [<c01072e0>] die+0x50/0xb0
Aug 29 09:08:22 natalie kernel:  [do_page_fault+896/1446] 
do_page_fault+0x360/0x5a6
Aug 29 09:08:22 natalie kernel:  [<c01179f0>] do_page_fault+0x360/0x5a6
Aug 29 09:08:22 natalie kernel:  [error_code+45/64] error_code+0x2d/0x40
Aug 29 09:08:22 natalie kernel:  [<c0106c8d>] error_code+0x2d/0x40
Aug 29 09:08:22 natalie kernel:  [pg0+945583562/1069326336] 
lo_read_actor+0x9a/0xd0 [loop]
Aug 29 09:08:22 natalie kernel:  [<f89fb5ca>] lo_read_actor+0x9a/0xd0 
[loop]
Aug 29 09:08:22 natalie kernel:  [file_read_actor+191/256] 
do_generic_mapping_read+0xdf/0x3f0
Aug 29 09:08:22 natalie kernel:  [<c013664f>] 
do_generic_mapping_read+0xdf/0x3f0
Aug 29 09:08:22 natalie kernel:  [filemap_nopage+504/864] 
generic_file_sendfile+0x48/0x60
Aug 29 09:08:22 natalie kernel:  [<c0136dd8>] 
generic_file_sendfile+0x48/0x60
Aug 29 09:08:22 natalie kernel:  [pg0+945583679/1069326336] 
do_lo_receive+0x3f/0x60 [loop]
Aug 29 09:08:22 natalie kernel:  [<f89fb63f>] do_lo_receive+0x3f/0x60 
[loop]
Aug 29 09:08:22 natalie kernel:  [pg0+945583875/1069326336] 
lo_receive+0xa3/0xb0 [loop]
Aug 29 09:08:22 natalie kernel:  [<f89fb703>] lo_receive+0xa3/0xb0 [loop]
Aug 29 09:08:22 natalie kernel:  [pg0+945583942/1069326336] 
do_bio_filebacked+0x36/0x60 [loop]
Aug 29 09:08:22 natalie kernel:  [<f89fb746>] do_bio_filebacked+0x36/0x60 
[loop]
Aug 29 09:08:22 natalie kernel:  [pg0+945584478/1069326336] 
loop_thread+0x6e/0xf0 [loop]
Aug 29 09:08:22 natalie kernel:  [<f89fb95e>] loop_thread+0x6e/0xf0 [loop]
Aug 29 09:08:22 natalie kernel:  [kernel_thread_helper+5/12] 
kernel_thread_helper+0x5/0xc
Aug 29 09:08:22 natalie kernel:  [<c0104279>] kernel_thread_helper+0x5/0xc
Aug 29 09:08:22 natalie kernel: Code: c1 fa 05 8b 4d 0c c1 e0 0c 8b 5d 20 
c1 e2 0c 2d 00 00 00 40 81 ea 00 00 00 40 01 f8 01 f2 85 c9 75 2e 89 d9 89 
d7 c1 e9 02 89 c6 <f3> a5 f6 c3 02 74 02 66 a5 f6 c3 01 74 01 a4 b8 00 e0 
ff ff 21

Regards
Michael Collard
