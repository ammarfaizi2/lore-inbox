Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131750AbRCaAVL>; Fri, 30 Mar 2001 19:21:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131756AbRCaAVB>; Fri, 30 Mar 2001 19:21:01 -0500
Received: from imo-m01.mx.aol.com ([64.12.136.4]:37844 "EHLO
	imo-m01.mx.aol.com") by vger.kernel.org with ESMTP
	id <S131750AbRCaAUs>; Fri, 30 Mar 2001 19:20:48 -0500
Date: Fri, 30 Mar 2001 19:17:35 -0500
From: puifunlau@cs.com
To: linux-kernel@vger.kernel.org
Subject: oops during kfree_skbmem
Mime-Version: 1.0
Message-ID: <52736207.12E4E41C.03465211@cs.com>
X-Mailer: Franklin Webmailer 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am reposting... the oops call stack didn't show up correctly.

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

The oops happened on a box running Linux 2.4.0 and libpcap-0.6.2 (which uses
AF_PACKET socket). The packet received was an arp request. I have syslog indicating
the kernel received the arp request. My pcap application captures arp packet as well.
 The calls leading to the oops :
    pcap_dispatch  ...
      sys_recvfrom ...
        kfree_skbmem ...free_block.

The oops is not recreatable on demand.  However, on another box running 2.4.0-test7,
there is a memory leak. Top reports memory used by my application stable at 0.3%,
but system memory usage keeps going up (reaching 250M used, 4M free before staying there).

Allen Lau

