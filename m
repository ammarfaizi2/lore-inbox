Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268515AbRGXXPC>; Tue, 24 Jul 2001 19:15:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268513AbRGXXOw>; Tue, 24 Jul 2001 19:14:52 -0400
Received: from [62.116.8.197] ([62.116.8.197]:6528 "HELO ghanima.endorphin.org")
	by vger.kernel.org with SMTP id <S268515AbRGXXOj>;
	Tue, 24 Jul 2001 19:14:39 -0400
Date: Wed, 25 Jul 2001 01:14:32 +0200
From: clemens <therapy@endorphin.org>
To: linux-kernel@vger.kernel.org
Subject: no ICMP port unreachable for UDP packets
Message-ID: <20010725011432.A2405@ghanima.endorphin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

linux 2.4.7 doesn't reply with icmp port unreachable messages to udp packets
to an unbind udp port. strangely the icmp error message is only omitted for
eth0 but not for lo. (i assert it's only been omitted for non local
interfaces).
this behavior has confirmed for 2.4.7-pre8 and 2.4.7-final.

for both udp packets (from lo and from eth0) the icmp_send call in
net/ipv4/udp.c is reached, since UDP_INC_STATS_BH(UdpNoPorts) is called as
you can see from the increasing counter in /proc/net/snmp, 
so the reply packet must be drop somewhere in icmp_send.

this bug should be easily reproducable with nmap and tcpdump.

greets, clemens
