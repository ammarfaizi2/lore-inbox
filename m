Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265370AbUFWLPy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265370AbUFWLPy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 07:15:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265428AbUFWLPy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 07:15:54 -0400
Received: from [195.245.229.2] ([195.245.229.2]:63418 "EHLO ns.techas.lt")
	by vger.kernel.org with ESMTP id S265370AbUFWLPt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 07:15:49 -0400
Date: Wed, 23 Jun 2004 14:15:14 +0300
From: Roman Zagustin <zagustin@techas.lt>
X-Mailer: The Bat! (v2.10.03) Business
Reply-To: Roman Zagustin <zagustin@techas.lt>
X-Priority: 3 (Normal)
Message-ID: <1868025972.20040623141514@techas.lt>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: (networking) large static ARP kernel table does not work
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

1. The kernel does not match the static ip/mac records on large ARP
table.

2. I have an ethernet network segment of B class (mask /22)
I've noticed that kernel do not check the ip/mac combinations
staticaly entered by "arp -s ip mac", when the table is >800 entries.
With small table it works perfectly.

3. I suppose that it is a kernel problem.

4. The kernel version is:
root@stargate:/proc/net# cat /proc/version
Linux version 2.6.7-rc3-bk2 (root@stargate) (gcc version 3.2.3) #1 Thu Jun 10 14:59:21 EEST 2004
(I've tried 2.4.25 and other versions - the same result)

5.  I run ping to the server from the  172.16.3.230 computer.
Then I've changed the static mac record on the server:

arp -s 172.16.3.230 00:00:00:00:00:01

The MAC address of the 172.16.3.230 is really different!
And after that, the   172.16.3.230 computer is tlill able to access
the server.


root@stargate:/proc/net# arp -s 172.16.3.230 00:00:00:00:00:01
root@stargate:/proc/net# arp -n|grep 172.16.3.230
172.16.3.230             ether   00:00:00:00:00:01   CM                    eth3
root@stargate:/proc/net# arp -d 172.16.3.230
root@stargate:/proc/net# arp -s 172.16.3.230 00:00:00:00:00:01
root@stargate:/proc/net# tcpdump -i eth3 host 172.16.3.230
tcpdump: listening on eth3
13:20:54.511204 172.16.3.230 > 172.16.0.4: icmp: echo request
13:20:54.514237 172.16.0.4 > 172.16.3.230: icmp: echo reply
13:20:55.512436 172.16.3.230 > 172.16.0.4: icmp: echo request
13:20:55.512549 172.16.0.4 > 172.16.3.230: icmp: echo reply
13:20:56.513894 172.16.3.230 > 172.16.0.4: icmp: echo request
<skipped>

root@stargate:/proc/net# arp -n|wc -l
    823

Almost all records in arp table are static.
Because I need to prevent users from being able to access the server
with changed IP addresses (spoofed ip)
    

The server is router with firewall and traffic shaper.
And have enougth resources:

 14:02:36  up 12 days, 21:43,  2 users,  load average: 0.08, 0.09, 0.08
47 processes: 45 sleeping, 2 running, 0 zombie, 0 stopped
CPU states:   0.0% user   0.6% system   0.0% nice   0.0% iowait  99.3% idle
Mem:  1037116k av, 1025972k used,   11144k free,       0k shrd,  125624k buff
        74948k active,             748664k inactive
Swap:  136512k av,       0k used,  136512k free                  681800k cached


The problem appears only when the ARP table is very large.
Because with small table (about 200) it works as it should.
It does not depend on server load.

The linux distribution is Slackware 9.1.

There are no errors or warnings in system logs about the arp table.
The same problem was noticed on comletely different computer.
I know that this problem is common as I found some peope on INET
with the same trouble.
I do not want to use the iptables for checking every packet for
IP/MAC correspondence, because it will rise the load.


Thank you!

-- 
Best regards,
 Roman                          mailto:zagustin@techas.lt

