Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261205AbVEKPiF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261205AbVEKPiF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 11:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261211AbVEKPiF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 11:38:05 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:28342 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261205AbVEKPh3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 11:37:29 -0400
Subject: Re: [Fastboot] kexec+kdump testing with 2.6.12-rc3-mm3
From: Badari Pulavarty <pbadari@us.ibm.com>
To: vgoyal@in.ibm.com
Cc: fastboot@lists.osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Morton Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050511025325.GA3638@in.ibm.com>
References: <1115769558.26913.1046.camel@dyn318077bld.beaverton.ibm.com>
	 <20050511025325.GA3638@in.ibm.com>
Content-Type: text/plain
Organization: 
Message-Id: <1115824847.26913.1061.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 11 May 2005 08:20:50 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-05-10 at 19:53, Vivek Goyal wrote:
> On Tue, May 10, 2005 at 04:59:18PM -0700, Badari Pulavarty wrote:
> > Hi,
> > 
> > I am using kexec+kdump on 2.6.12-rc3-mm3 and it seems to be working
> > fine on my 4-way P-III 8GB RAM machine. I did touch testing with
> > kexec+kdump and it worked fine. Then ran heavy IO load and forced
> > a panic and I was able to collect the dump. But I am not able to
> > analyze the dump to find out if I really got a valid dump or not :(
> > 
> 
> Copying to LKML.
> 
> Gdb can not open a file larger than 2GB. You have got 8GB RAM hence
> /proc/vmcore size must be similar. For testing purposes you can boot first
> kernel with mem=2G and then take dump and analyze with gdb.

Its better with mem=2G, but gdb is not really useful :(
I wanted to look at all the processes and their stacks..
It shows me only one stack (not quite right). So I can't
really use the dump for anything :(

(gdb) bt
#0  crash_get_current_regs (regs=0xc04ddbf8) at
arch/i386/kernel/crash.c:99
#1  0xc0117fe9 in crash_save_self () at arch/i386/kernel/crash.c:107
#2  0xc0141d14 in crash_kexec () at kernel/kexec.c:1032
#3  0xc0294a44 in __handle_sysrq (key=99, pt_regs=0xc04ddd44, tty=0x0,
    check_mask=99) at drivers/char/sysrq.c:410
#4  0xc0294b1d in handle_sysrq (key=Variable "key" is not available.
) at drivers/char/sysrq.c:438
#5  0xc029e5ab in receive_chars (up=0xc05672a0, status=0xc04ddcd4,
    regs=0xc04ddd44) at serial_core.h:395
#6  0xc029e906 in serial8250_interrupt (irq=4, dev_id=0xc0566bc0,
    regs=0xc04ddd44) at drivers/serial/8250.c:1212
#7  0xc0142995 in handle_IRQ_event (irq=4, regs=0xc04ddd44,
action=0xf7cebdc0)
    at kernel/irq/handle.c:87
#8  0xc0142aa5 in __do_IRQ (irq=4, regs=0xc04ddd44) at
kernel/irq/handle.c:172
#9  0xc01065a7 in do_IRQ (regs=0xc04ddd44) at arch/i386/kernel/irq.c:108
#10 0xc0104aaa in common_interrupt () at atomic.h:175
#11 0xf7a7d980 in ?? ()
#12 0x00000000 in ?? ()
#13 0xf6b50760 in ?? ()
#14 0xf62ce800 in ?? ()
#15 0x00000004 in ?? ()
#16 0xc04ddda8 in init_thread_union ()
#17 0xf62ce868 in ?? ()
#18 0x0000007b in ?? ()
#19 0xf490007b in ?? ()
#20 0xffffff04 in ?? ()
#21 0xc036c052 in tcp_clean_rtx_queue (sk=0xf62ce800,
seq_rtt_p=0xc04dddd4)
    at skbuff.h:677
#22 0xc036c9f0 in tcp_ack (sk=0xf62ce800, skb=Variable "skb" is not
available.
) at net/ipv4/tcp_input.c:2938
#23 0xc036f566 in tcp_rcv_established (sk=0xf62ce800, skb=0xf7995980,
    th=0xf1593a34, len=32) at net/ipv4/tcp_input.c:4285
#24 0xc03783d0 in tcp_v4_do_rcv (sk=0xf62ce800, skb=0xf7995980)
    at net/ipv4/tcp_ipv4.c:1676
#25 0xc0378cf2 in tcp_v4_rcv (skb=0xf7995980) at
net/ipv4/tcp_ipv4.c:1785
#26 0xc035c1f6 in ip_local_deliver (skb=0xf7995980) at
net/ipv4/ip_input.c:242
#27 0xc035c89c in ip_rcv (skb=Variable "skb" is not available.
) at dst.h:246
#28 0xc034031a in netif_receive_skb (skb=0xf7995980) at
net/core/dev.c:1713
#29 0xc03403d6 in process_backlog (backlog_dev=0xc600f52c,
budget=0xc04ddf3c)
    at net/core/dev.c:1746
#30 0xc034058e in net_rx_action (h=Variable "h" is not available.
) at net/core/dev.c:1795
#31 0xc0127432 in __do_softirq () at kernel/softirq.c:95
#32 0xc01274e8 in do_softirq () at kernel/softirq.c:129
#33 0xc01065ac in do_IRQ (regs=0xc04ddf94) at arch/i386/kernel/irq.c:110
#34 0xc0104aaa in common_interrupt () at atomic.h:175
#35 0xffffe000 in ?? ()
#36 0xc600c2e0 in ?? ()
#37 0xc0101fb0 in enable_hlt () at arch/i386/kernel/process.c:93
#38 0xc010209c in cpu_idle () at arch/i386/kernel/process.c:199
#39 0xc04de9b5 in start_kernel () at init/main.c:527
#40 0xc010020e in is386 () at arch/i386/kernel/head.S:327
#41 0x00000000 in ?? ()
#42 0x00000000 in ?? ()
#43 0x00000000 in ?? ()
#44 0x00000000 in ?? ()
#45 0x00000000 in ?? ()
#46 0x00000000 in ?? ()
#47 0x00000000 in ?? ()
#48 0x00000000 in ?? ()
#49 0x00000000 in ?? ()
#50 0x00000000 in ?? ()
#51 0x00000000 in ?? ()
#52 0x00000000 in ?? ()
#53 0x00000000 in ?? ()
#54 0x00000000 in ?? ()
#55 0x00000000 in ?? ()
#56 0x00000000 in ?? ()
#57 0x00000000 in ?? ()
#58 0x00000000 in ?? ()
#59 0x00000000 in ?? ()
#60 0x00000000 in ?? ()
...


> 
> But we need to work on some crash analysis tools like "crash" to be able
> to debug larger files. 

Is some one working on this too ?

> > BTW, what architectures kexec+kdump supported ? Does it work on
> > x86-64 ?
> > 
> 
> Kexec has been ported to x86-64 but not kdump.

:(


Thanks,
Badari

