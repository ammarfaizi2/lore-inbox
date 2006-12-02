Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759454AbWLBPpU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759454AbWLBPpU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 10:45:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759457AbWLBPpU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 10:45:20 -0500
Received: from main.gmane.org ([80.91.229.2]:54495 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1759454AbWLBPpS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 10:45:18 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Helge Deller <deller@gmx.de>
Subject: Re: 2.6.19: skb_over_panic, followed by a BUG at net/core/skbuff.c:93
Date: Sat, 02 Dec 2006 16:40:54 +0100
Message-ID: <eks6q6$v3t$1@sea.gmane.org>
References: <45718AE9.8060202@dbservice.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: mnhm-590c0a4b.pool.einsundeins.de
User-Agent: KNode/0.10.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomas Carnecky wrote:

> I only have a screenshot with no backtrace, if you want to see the
> function names in the backtrace, please tell me what I need to do.
> 
> http://dbservice.com/ftpdir/tom/kernel-bug.jpg
> 
> I was running a 2.6.19-ge??? kernel before (I don't remember which
> version exactly) and it was running fine, today I upgraded to v2.6.19
> and now I have this crash. 2.6.18 works fine, too.
> 
> The bug happens when gentoo wants to bring up eth0 (starting the lo
> device works fine), even a simple 'ifconfig eth0 192.168.0.11' will
> crash the kernel.
> 
> The computer is a Shuttle XPC with an AMD 64bit CPU, network card is
> integrated in the nforce chipset.

I just faced the same problem, but on a HPPA (PARISC) box with 32bit kernel.
Just reported at the parisc-linux kernel mailing list as well:
http://lists.parisc-linux.org/pipermail/parisc-linux/2006-December/030810.html

Summary:

Just got a kernel crash with our git tree code.
Not sure if this is generic problem or related to parisc.
I didn't investigated any further. 
Just reporting here in case someone has an idea.
IPV6 and serial console were enabled.
Turning IPV6 off fixed it for me.

Helge
-----------
rtc-test rtc-test.0: setting the system clock to 2006-12-02 14:04:48
(1165068288)
Sending BOOTP requests . OK
IP-Config: Got BOOTP answer from 192.168.178.50, my address is
192.168.178.70
IP-Config: Complete:
      device=eth0, addr=192.168.178.70, mask=255.255.255.0,
gw=192.168.178.1,
     host=c3000, domain=box, nis-domain=(none),
     bootserver=192.168.178.50, rootserver=192.168.178.50, rootpath=
md: Autodetecting RAID arrays.
skb_over_panic: text:1045715c len:56 put:16 head:8fa40a80 data:8fa40a90
tail:8fa40ac8 end:8fa40ac0 dev:eth0
kernel BUG at net/core/skbuff.c:93!
Backtrace:
 [<103e4b44>] skb_over_panic+0x74/0x84
 [<10457164>] ndisc_send_rs+0x268/0x4ac
 [<1044d15c>] addrconf_dad_completed+0x84/0xd8
 [<1044d09c>] addrconf_dad_timer+0xe8/0x124
 [<10131360>] run_timer_softirq+0x140/0x1dc
 [<1012c7b0>] __do_softirq+0x60/0xcc
 [<101042f0>] do_softirq+0x38/0x48
 [<101084ac>] do_cpu_irq_mask+0xf0/0x11c
 [<1010b068>] intr_return+0x0/0xc
 [<102a19ac>] serial8250_console_putchar+0x34/0x108
 [<10127370>] vprintk+0x2b8/0x2f4
 [<10127368>] vprintk+0x2b0/0x2f4
 [<101270ac>] printk+0x20/0x2c
 [<10398220>] autostart_arrays+0x28/0xd4
 [<103960fc>] md_ioctl+0x44c/0x474
 [<1023e6bc>] blkdev_driver_ioctl+0x58/0x64

Kernel panic - not syncing: BUG!


