Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267808AbUJONhJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267808AbUJONhJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 09:37:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267806AbUJONgU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 09:36:20 -0400
Received: from mxfep01.bredband.com ([195.54.107.70]:65449 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S267808AbUJONfW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 09:35:22 -0400
Subject: Re: 2.6.9-rc4: Aiee on amd64
From: Alexander Nyberg <alexn@dsv.su.se>
To: Harald Dunkel <harald.dunkel@t-online.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <416A98B3.7050805@t-online.de>
References: <416A98B3.7050805@t-online.de>
Content-Type: text/plain
Message-Id: <1097847309.630.6.camel@boxen>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 15 Oct 2004 15:35:09 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I installed 2.6.9-rc4 this morning, but it died at boot time
> (a lot of hex output and something about "Aiee" :-). I tried
> to redirect syslog to another host, but the error message did
> not show up in the foreign log files.
> 
> Any idea how to catch this message? The problem seems to be
> reproducable, and I would be glad to help.

You need to use netconsole, serial console or some other technique to
get the panic info over to another machine. Please mail again with info
on what you do to get the panic and the info that comes out of the panic
itself. I'm sending you the netconsole text.

-----------------------------------------------

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


