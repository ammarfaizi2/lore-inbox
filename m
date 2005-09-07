Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932078AbVIGJSk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbVIGJSk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 05:18:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbVIGJSk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 05:18:40 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18111 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751109AbVIGJSj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 05:18:39 -0400
Date: Wed, 7 Sep 2005 02:16:52 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Christiaan den Besten" <chris@scorpion.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Machine dies under heavy I/O or network-access ..?
Message-Id: <20050907021652.4f8a9616.akpm@osdl.org>
In-Reply-To: <049f01c5b215$91e7c4b0$3d64880a@speedy>
References: <049f01c5b215$91e7c4b0$3d64880a@speedy>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Christiaan den Besten" <chris@scorpion.nl> wrote:
>
> We have recently installed two new Usenet feeders, but are having issue's keeping them alive under 'heavy' load. Both are SuperMicro 
>  based models with onboard Intel GB NICS and have a Areca 16 ports SATA-II controller. Both are Dual Xeon 2.8 with 4G ram, swap 
>  disabled. Filesystems are tmpfs, ext3 and xfs.
> 
>  Using plain vanilla 2.6.12+ these machines will usually crash within an hour or so. With -mm patched kernels this timeframe 
>  increases somewhat (seen 5 days). ( Crash means: none of the processes are responding, but machines does reply ping requests ... ). 
>  I have not yet been able to connect a serial for logging, and the screen does not come out of screen blanking on keyboard access...
> 
>  These machines handle aprox 200mbit on eth0 and 400mbit on eth1, the Areca driver will write +/- 20Mb/s to the disks and sometimes 
>  have to read upto 60Mb/s as well (just to give an impression of what the load is .. )
> 
>  Today I noticed the following assertion in dmesg:
> 
>  ---
>  e1000: eth0: e1000_watchdog_task: NIC Link is Up 1000 Mbps Full Duplex
>  KERNEL: assertion (!sk->sk_forward_alloc) failed at net/core/stream.c (279)
>  KERNEL: assertion (!sk->sk_forward_alloc) failed at net/ipv4/af_inet.c (148)
>  ---

Add some swapspace.



Before it hangs, do

	echo 1 > /proc/sys/kernel/sysrq

and test that alt-sysrq-T produces output.

When it hangs, do alt-sysrq-p a few times and record the result.  Then do
alt-sysrq-t a few times and record the result.

You'll probably need a serial console to record the results.
