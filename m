Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264837AbUEVCDj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264837AbUEVCDj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 22:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264862AbUEVCAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 22:00:21 -0400
Received: from fw.osdl.org ([65.172.181.6]:36558 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265173AbUEVB5K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 21:57:10 -0400
Date: Fri, 21 May 2004 18:56:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Dr. Ernst Molitor" <molitor@cfce.de>
Cc: linux-kernel@vger.kernel.org, Christophe Saout <christophe@saout.de>
Subject: Re: PROBLEM: Linux-2.6.6 with dm-crypt hangs on SMP boxes
Message-Id: <20040521185640.6bf88bdb.akpm@osdl.org>
In-Reply-To: <1085043539.18199.20.camel@felicia>
References: <1085043539.18199.20.camel@felicia>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Dr. Ernst Molitor" <molitor@cfce.de> wrote:
>
> [1.] Linux-2.6.6 caused full halts on two SMP boxes.
> [2.] I've been using Linux-2.4.20 with   cryptoloop/cryptoapi for 156
> days uptime; on two boxes, I have installed 2.6.6-rc3-bk5 (one box) and
> 2.6.6-bk5 (the other one), with dm-crypt on the partitions created with
> cryptoloop/cryptoapi. Both boxes ran like a charm, but both of them
> repeatedly came to a halt (no screen, no network connectivity, no
> reaction to keyboard or mouse activity: Need for hard reset) repeatedly.
> [3.] dm-crypt, loop device (maybe other things).
> In kern.log on the box with 2.6.6-bk5, I found the line
>   Incorrect TSC synchronization on an SMP system (see dmesg).
> with the 2.6.6 kernels, with 2.4.20, the message was
>  checking TSC synchronization across CPUs: passed.
> [4.] 2.6.6, 2.6.6-bk5

Are the machines using highmem? (What is in /proc/meminfo?)

Please add `nmi_watchdog=1' to the kernel boot command line and reboot.

After booting, do:

	echo 1 > /proc/sys/kernel/sysrq

After a machine hangs up, see if there is an NMI watchdog message on the
console.  If not, try typing ALT-sysrq-P.  If this generates a trace, type
it again until you capture the trace from the other CPU as well.  We'd need
to see both those traces.  A digital camera helps...

Thanks.
