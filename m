Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262012AbVDRKEh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262012AbVDRKEh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 06:04:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262014AbVDRKEh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 06:04:37 -0400
Received: from mailfe10.swipnet.se ([212.247.155.33]:45559 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S262012AbVDRKE2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 06:04:28 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Subject: Re: Need some help to debug a freeze on 2.6.11
From: Alexander Nyberg <alexn@dsv.su.se>
To: Ehud Shabtai <eshabtai.lkml@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <68b6a2bc050418000619a552de@mail.gmail.com>
References: <68b6a2bc050418000619a552de@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 18 Apr 2005 12:04:26 +0200
Message-Id: <1113818666.357.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm running Linux on my laptop and it sometimes freezes (about once a
> week). The only thing which seems to work when it's stuck is SysRq (I
> can reboot with SysRq+O), however, I'm in X and I don't have a serial
> port on my laptop so I can't see any of the outputs of the SysRq
> options.
> 
> After a reboot I don't see anything in my logs about the crash.
> 
> Can anyone suggest how to get some information about my freeze?

Sounds like a job for Documentation/networking/netconsole.txt



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


