Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288486AbSADEiq>; Thu, 3 Jan 2002 23:38:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288487AbSADEig>; Thu, 3 Jan 2002 23:38:36 -0500
Received: from PHNX1-UBR2-4-hfc-0251-d1dae065.rdc1.az.coxatwork.com ([209.218.224.101]:63964
	"EHLO mail.labsysgrp.com") by vger.kernel.org with ESMTP
	id <S288486AbSADEiT>; Thu, 3 Jan 2002 23:38:19 -0500
Message-ID: <005001c194d9$b5793c40$6caaa8c0@kevin>
From: "Kevin P. Fleming" <kevin@labsysgrp.com>
To: <linux-kernel@vger.kernel.org>
Subject: How to debug very strange packet delivery problem?
Date: Thu, 3 Jan 2002 21:38:50 -0700
Organization: LSG, Inc.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got a machine that is just driving me nuts here... it's a RedHat 7.2
machine, upgraded to a 2.4.17 kernel (no kernel patches, just standard
kernel). The machine has an ethernet interface for it's local network, and a
ppp interface (using RedHat's pppd-2.4.1 RPM) to connect it to the corporate
WAN.

The machine runs fine, and other nodes on the local network (i.e. using the
ethernet interface) can communicate with it just fine. I can also bring up
the ppp link, and communicate with everything on the corporate WAN without
trouble. I can communicate _through_ this machine from nodes on the local
network to the corporate WAN just fine. But...

What I _cannnot_ do is initiate a connection from a node on the other side
of the ppp link (the corporate side) to this machine. There are at least
three daemon processes on this system I've tried to connect to: xinetd (for
telnet), bind and exim. None of these are using tcp_wrappers. The symptoms
are that the TCP SYN packet (to open the connection) arrives at the ppp0
interface (verified by using tcpdump on the ppp0 interface), but then is not
delivered to the waiting process on its open socket.

So far, I have done the following:

- reproduced the problem with iptables statically compiled, modular
compiiled and not included at all
- strace'd the daemon process(es) to see that they are stuck on a select()
(expected), and that the select() does not return when the packet arrives
- put in iptables rules to show when the packets get ACCEPTed (and they do,
the counters increase)
- watched the packets leave from the source machine with tcpdump on the
outbound interface, and the packets arrive intact at the problem machine
with tcpdump on the ppp interface
- disabled all sysctl settings that I had previously set
- rebooted countless times to try other variations :-)

Anyone have any idea where to proceed here? I'm sure it's something stupid
I've missed, as this is a pretty basic thing to not have working properly,
but I can't seem to find it.

