Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261689AbSKTVza>; Wed, 20 Nov 2002 16:55:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261678AbSKTVza>; Wed, 20 Nov 2002 16:55:30 -0500
Received: from UNKNOWN-216-136-224-67.yahoo.com ([216.136.224.67]:10869 "HELO
	web14504.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S261689AbSKTVz1>; Wed, 20 Nov 2002 16:55:27 -0500
Message-ID: <20021120220233.24428.qmail@web14504.mail.yahoo.com>
Date: Wed, 20 Nov 2002 14:02:33 -0800 (PST)
From: Gautam P <gautam_gp82@yahoo.com>
Subject: Accessing # pkts received by kernel through eth0 - failing to get it right
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks
       I am trying to get the number of packets
received by the kernel through the eth0 (only nic card
on the P4 2.2 Ghz machine) in my kernel code (kernel
v2.4.18-3). However, I am not able to get the exact
number of packets received by the kernel, in fact I am
getting quite less packets if compared to the output
shown by tcpdump & tcptrace utility.   
  
       I am incrementing the tcp_pkt_count and
udp_pkt_count in ip_recv() function (in
net/ipv4/ip_input.c)  when the pkt received is tcp or
udp respectively. But the number of pkts received is
far less as compared to that shown by tcpdump and
tcptrace -l  utility. I even tried to put up a counter
in netif_rx() function (net/core/dev.c) for every
packet received (be it of whichever protocol) but
still the number of pkts rec'd is far less as compared
to what is shown by tcpdump/tcptrace.

    For e.g downloading a file of 37.8 MB in a LAN
through ftp from my machine to adjacent machine,  my
"total_received_pkts" variable in netif_rx() function
in net/core/dev.c file, shows 13930 packets for this
particular file download. The total_received_pkts
variable in netif_rx() is incremented everytime when a
pkt is received by eth0. Now, tcpdump/tcptrace shows
me that total transferred packets are 38752 for this
particular file and maximum segment size (or pkt size)
is 1448 bytes. [The LAN has MTU of 1500 bytes]. 
So there is a great difference (in # pkts received by
the kernel) between what the kernel is showing me and
what the tcpdump/tcptrace shows.  There is no
fragmentation involved on the LAN machines.   


      This makes my received bytes calculation too
wrong (because I am getting wrong number of received
pkts).

     Could anybody please tell me where I am getting
it wrong when the tcpdump/tcptrace utility prints it
right ? I have repeated the experiment several times
(with udp, tcp protocol) but I couldnt get the reason.

     I hope to get a reply.

     Thank you very much for your precious time!
Gautam.         

__________________________________________________
Do you Yahoo!?
Yahoo! Web Hosting - Let the expert host your site
http://webhosting.yahoo.com
