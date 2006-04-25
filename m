Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932154AbWDYUTV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbWDYUTV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 16:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbWDYUTU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 16:19:20 -0400
Received: from mx2.q9.com ([216.220.35.253]:56547 "EHLO mx2.q9.com")
	by vger.kernel.org with ESMTP id S1751325AbWDYUTU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 16:19:20 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Disappearing ARP in /proc/net/arp
Date: Tue, 25 Apr 2006 16:19:18 -0400
Message-ID: <413FEEF1743111439393FB76D0221E48046911D1@leopard.zoo.q9networks.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Disappearing ARP in /proc/net/arp
thread-index: AcZopYgg2W6jVP0aTmyJlJdpvclr0Q==
From: "Jari Takkala" <Jari.Takkala@Q9.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We are running kernel 2.6.9-22.0.2.EL (CentOS 4) and a custom built
2.4.29 kernel on a few dozen Dell 850's. These are functioning as
firewall's and in some we publish a large number (greater than 75) ARP
entries using 'arp -Ds <IP> <iface> pub'.

I have noticed that one entry is intermittently missing from the output
of /proc/net/arp when we have greater than 10 published ARP entries.
This seems to be a display issue as the kernel continues to reply to ARP
who-has on the network (as confirmed with tcpdump). The entry which is
missing varies and seems to alternate between a fixed number of IP's
among the 75 or so ARP entries. I have not been able to find a bug-fix
for this in either the kernel source or on the mailing list.

To reproduce:

- Publish greater than 10 ARP entries.
- View output of 'arp -n' or 'cat /proc/net/arp'
	- Repeat until one published entry will be missing.

On average I have been able to repeat this problem within 1 minute by
comparing output from 'grep "0xc" /proc/net/arp' every 2 seconds.

Regards,

Jari
