Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132674AbRC2FLk>; Thu, 29 Mar 2001 00:11:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132683AbRC2FLa>; Thu, 29 Mar 2001 00:11:30 -0500
Received: from imo-r18.mx.aol.com ([152.163.225.72]:25284 "EHLO
	imo-r18.mx.aol.com") by vger.kernel.org with ESMTP
	id <S132674AbRC2FLY>; Thu, 29 Mar 2001 00:11:24 -0500
From: PuiFunLau@cs.com
Message-ID: <d5.454c391.27f41dc1@cs.com>
Date: Thu, 29 Mar 2001 00:10:25 EST
Subject: kernel oops during kfree_skbmem
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: CompuServe 2000 32-bit sub 113
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I posted the following to tcpdump-workers. They think I should ask here...
I was almost certain the following kernel oops occurred during packet 
capture. 
The packet received was an arp request. Syslog indicated the kernel received 
the arp request. My pcap application captures arp packet as well.
The calls leading to the oops :
  pcap_dispatch  ...
    sys_recvfrom ...
      kfree_skbmem ...free_block.

The oops happened on a box running Linux 2.4.0 and libpcap-0.6.2 (which uses 
AF_PACKET 
socket). The decoded call stack of the oops is below. The oops does not 
happen all the time. 
However, on another box running 2.4.0-test7 and  the same application, there 
is a memory
leak. TOP reports memory used by my application stable at 0.3%, but system 
memory usage 
keeps going up (reaching 250M used, 4M free before staying there).

Does this look like a libpcap problem or skbmem problem? 
Are there two copies of the same packet when I do packet capture?

>>EIP; c012c504 <free_block+84/d8>   <=====
Trace; c011b77a <do_softirq+5a/88>
Trace; c012c82a <kfree+72/98>
Trace; c01d00fd <kfree_skbmem+25/80>
Trace; c01d024b <__kfree_skb+f3/f8>
Trace; c01d0d1d <skb_free_datagram+1d/24>
Trace; c0203a61 <packet_recvmsg+139/148>
Trace; c01cd441 <sock_recvmsg+41/b0>
Trace; c0203928 <packet_recvmsg+0/148>
Trace; c01ce2fd <sys_recvfrom+ad/108>

Allen Lau
