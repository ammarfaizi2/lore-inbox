Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262128AbSIYWgs>; Wed, 25 Sep 2002 18:36:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262129AbSIYWgs>; Wed, 25 Sep 2002 18:36:48 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:44000 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S262128AbSIYWgr> convert rfc822-to-8bit; Wed, 25 Sep 2002 18:36:47 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: nf@hipac.org
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] NF-HIPAC: High Performance Packet Classification for Netfilter
Date: Thu, 26 Sep 2002 00:41:56 +0200
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200209260041.56374.nf@hipac.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

nf-hipac aims to become a drop-in replacement for the iptables packet 
filtering module. It implements a novel framework for packet classification 
which uses an advanced algorithm to reduce the number of memory lookups per 
packet. The module is ideal for environments where large rulesets and/or
high bandwidth networks are involved.

The algorithm code is designed in a way that it can be verified in userspace, 
so the algorithm code itself can be considered correct. We are not able to 
really verify the remaining files nfhp_mod.[ch] and the userspace tool 
(nf-hipac.[ch]), but they are tested in depth and shouldn't contain any 
critical bugs.

We have the results of some basic performance tests available on our web page. 
The test compares the performance of the iptables filter table to the 
performance of nf-hipac. Results are pretty impressive :-)

You can find the performance test results on our web page http://www.hipac.org
The releases can be downloaded from http://sourceforge.net/projects/nf-hipac/

Features:
    - optimized for high performance packet classification
      with moderate memory usage
    - completely dynamic:
        data structure isn't rebuild from scratch when inserting or
        deleting rules, so fast updates are possible
    - userspace tool syntax is very similar to the iptables syntax
    - kernel does not need to be patched
    - compatible to iptables: you can use iptables and nf-hipac at
      the same time:
        for example you could use the connection tracking module from
        iptables and match the states with nf-hipac
    - match support for:
        + source/destination ip
        + in/out interface
        + protocol (udp, tcp, icmp)
        + source/destination ports (udp, tcp)
        + icmp type
        + tcp flags
        + ttl
        + state match (conntrack module must be loaded)
   - /proc/net/nf-hipac:
        + algorithm statistics available via
            # cat /proc/net/nf-hipac
        + allows to dynamically limit the maximum memory usage
            # echo   >  /proc/net/nf-hipac

Enjoy,

+-----------------------+----------------------+
|   Michael Bellion     |     Thomas Heinz     |
| <mbellion@hipac.org>  |  <creatix@hipac.org> |
+-----------------------+----------------------+

