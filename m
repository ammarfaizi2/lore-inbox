Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262455AbVCBVvA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262455AbVCBVvA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 16:51:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261402AbVCBVtS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 16:49:18 -0500
Received: from mailfe10.swipnet.se ([212.247.155.33]:25002 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S262562AbVCBVfP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 16:35:15 -0500
X-T2-Posting-ID: icQHdNe7aEavrnKIz+aKnQ==
Subject: Re: Strange crashes of kernel v2.6.11
From: Alexander Nyberg <alexn@dsv.su.se>
To: Steffen Michalke <StMichalke@web.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1109787428.6828.14.camel@pinky.local>
References: <1109787428.6828.14.camel@pinky.local>
Content-Type: text/plain
Date: Wed, 02 Mar 2005 22:34:52 +0100
Message-Id: <1109799292.15072.9.camel@boxen>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I recently upgraded from linux kernel v2.6.10 to v2.6.11.
> Some programs like evolution 2.0 and leafnode2 crash the whole system
> immediatedly now.

You mean when you run evolution the box hangs up completely? (you can't
kill X, switch to another console etc.)

If that is the case, we need the console output when that happens, it
will indicate what goes wrong. Make sure you boot with nmi_watchdog=1
I'm sending you the recommended solution, requires two computers:

===============================================

started by Ingo Molnar <mingo@redhat.com>, 2001.09.17
2.6 port and netpoll api by Matt Mackall <mpm@selenic.com>, Sep 9 2003

Please send bug reports to Matt Mackall <mpm@selenic.com>

This module logs kernel printk messages over UDP allowing debugging of
problem where disk logging fails and serial consoles are impractical.

It can be used either built-in or as a module. As a built-in,
netconsole initializes immediately after NIC cards and will bring up
the specified interface as soon as possible. While this doesn't allow
capture of early kernel panics, it does capture most of the boot
process.

It takes a string configuration parameter "netconsole" in the
following format:


netconsole=[src-port]@[src-ip]/[<dev>],[tgt-port]@<tgt-ip>/[tgt-macaddr]

   where
        src-port      source for UDP packets (defaults to 6665)
        src-ip        source IP to use (interface address)
        dev           network interface (eth0)
        tgt-port      port for logging agent (6666)
        tgt-ip        IP address for logging agent
        tgt-macaddr   ethernet MAC address for logging agent (broadcast)

Examples:

 linux netconsole=4444@10.0.0.1/eth1,9353@10.0.0.2/12:34:56:78:9a:bc

  or

 insmod netconsole netconsole=@/,@10.0.0.2/

Built-in netconsole starts immediately after the TCP stack is
initialized and attempts to bring up the supplied dev at the supplied
address.

The remote host can run either 'netcat -u -l -p <port>' or syslogd.

WARNING: the default target ethernet setting uses the broadcast
ethernet address to send packets, which can cause increased load on
other systems on the same ethernet segment.

NOTE: the network device (eth1 in the above case) can run any kind
of other network traffic, netconsole is not intrusive. Netconsole
might cause slight delays in other traffic if the volume of kernel
messages is high, but should have no other impact.

Netconsole was designed to be as instantaneous as possible, to
enable the logging of even the most critical kernel bugs. It works
from IRQ contexts as well, and does not enable interrupts while
sending packets. Due to these unique needs, configuration can not
be more automatic, and some fundamental limitations will remain:
only IP networks, UDP packets and ethernet devices are supported.


