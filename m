Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262200AbUCIWvN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 17:51:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262252AbUCIWvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 17:51:13 -0500
Received: from fw.osdl.org ([65.172.181.6]:6846 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262200AbUCIWvJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 17:51:09 -0500
Date: Tue, 9 Mar 2004 14:53:09 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Anders K. Pedersen" <akp@cohaesio.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.3 userspace freeze
Message-Id: <20040309145309.79dfac9e.akpm@osdl.org>
In-Reply-To: <1078853795.7728.27.camel@akp.cohaesio.com>
References: <1078853795.7728.27.camel@akp.cohaesio.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Anders K. Pedersen" <akp@cohaesio.com> wrote:
>
> Last night I upgraded two of our webservers from Linux 2.4 to 2.6.3.
> During the night both of them rebooted spontanously (i.e. no indication
> of why in the log files) several times, so this morning I attached a
> serial console to capture the kernel messages, when they rebooted.
> 
> What I found was that all of a sudden my SSH connections to the server
> and the local vtys would freeze, and it would stop responding to TCP
> connections, while still responding to ICMP echo requests. Apparently
> all userspace processes just froze. After approximately 60 seconds, it
> logged "SOFTDOG: Initiating system reboot.", and rebooted. This was the
> only kernel message, except for the boot messages. This happened
> repeatedly on both servers.
> 
> Both servers run (mainly) Apache 1.3 and Sun Chili ASP (several hundred
> processes each), and the freezes seemed to happen during high load
> peaks.
> 
> I have attached the kernel .config (same on both servers) and the kernel
> boot messages including the software watchdog reboot message. Both
> servers are identical IBM xSeries 345 servers. I have other similar
> servers running 2.6.3 for other purposes without any problems (so far).
> 
> Any ideas on what's wrong, or how to find out, would be much
> appreciated.

It could be a kernel deadlock, or a memory leak, or a disk device driver
bug.

Would it be possible to run a `vmstat 1' somewhere and capture the last
thirty or so lines prior to the reboot?

