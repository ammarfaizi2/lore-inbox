Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272493AbTHOX6z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 19:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272502AbTHOX6y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 19:58:54 -0400
Received: from fw.osdl.org ([65.172.181.6]:6097 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272493AbTHOX5s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 19:57:48 -0400
Date: Fri, 15 Aug 2003 16:43:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: Yaoping Ruan <yruan@cs.princeton.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel hangs up - possible sendfile() epoll() bug?
Message-Id: <20030815164334.1e37b5b8.akpm@osdl.org>
In-Reply-To: <3F3D672D.1AF660B6@cs.princeton.edu>
References: <3F3D672D.1AF660B6@cs.princeton.edu>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yaoping Ruan <yruan@cs.princeton.edu> wrote:
>
> Hi,
> 
> Recently we updated a user space web server to use the sendfile() and
> epoll() interface, and tried to measure the performance with SpecWeb99
> benchmark. As the load increases, e.g a SpecWeb99's target score of 600
> connection, the kernel sometimes hangs up without any logging
> information, and the only way left is to push the reset button to
> reboot.
> 
> We also made similar updates to use sendfile() and kevent() on FreeBSD
> and achieved a score of 1000 connections. Thus the possibility of
> application bug is low (also it is a user space server). Before the
> sendfile() and epoll() change, it was also fine but only could get a
> SpecWeb99 score of 500.
> 
> The kernel we were using was 2.4.21 with the epoll patch applied. Since
> the epoll man pages mention the interface is stabilized in 2.5.66, we
> also tried 2.5.66 but didn't see anything better. The machine is a PIII
> Xeon processor-based Intel server motherboard, with 2 CPU support but
> only 1 is used, Maxtor Diamond IDE disk, Promise Ultra DMA 66
> controller, and a single Netgear GA621 gigabit ethernet network adapter.
> 

Definitely a kernel bug.

Could you please test 2.6.0-test3?  If that has the same problem then
some initial steps would be:


- Boot the kernel with the "nmi_watchdog=1" option on the kernel boot
  command line.  (It needs to be an SMP-compiled kernel for this to work. 
  Or one which has the local APIC enabled in config)

- Make sure that /proc/sys/kernel/sysrq was set to `1' after booting.

- Can you still ping the machine after it hangs up?

- Type ALT-SYSRQ-T and/pr ALT-SYSRQ-P on the keyboard, see if you get a trace.

- ALT-SYSRQ-M may be interesting too (memory stats)

If the nmi watchdog doesn't generate a trace then the sysrq keys should do
so.

If the above does not provide us with enough information to solve the bug
then the next step would be for you to provide sufficient material for a
kernel developer to reproduce the problem.

Thanks.
