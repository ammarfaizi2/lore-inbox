Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318345AbSIBRkr>; Mon, 2 Sep 2002 13:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318332AbSIBRkr>; Mon, 2 Sep 2002 13:40:47 -0400
Received: from hdfdns01.hd.intel.com ([192.52.58.10]:18129 "EHLO
	mail1.hd.intel.com") by vger.kernel.org with ESMTP
	id <S318327AbSIBRkq>; Mon, 2 Sep 2002 13:40:46 -0400
Message-ID: <288F9BF66CD9D5118DF400508B68C4460283E564@orsmsx113.jf.intel.com>
From: "Feldman, Scott" <scott.feldman@intel.com>
To: linux-kernel@vger.kernel.org, linux-net <linux-net@vger.kernel.org>,
       "'Dave Hansen'" <haveblue@us.ibm.com>,
       "'Manand@us.ibm.com'" <Manand@us.ibm.com>
Cc: kuznet@ms2.inr.ac.ru, "'David S. Miller'" <davem@redhat.com>,
       "Leech, Christopher" <christopher.leech@intel.com>
Subject: TCP Segmentation Offloading (TSO)
Date: Mon, 2 Sep 2002 10:45:08 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

TCP Segmentation Offloading (TSO) is enabled[1] in 2.5.33, along with an
enabled e1000 driver.  Other capable devices can be enabled ala e1000; the
driver interface (NETIF_F_TSO) is very simple.

So, fire up you favorite networking performance tool and compare the
performance gains between 2.5.32 and 2.5.33 using e1000.  I ran a quick test
on a dual P4 workstation system using the commercial tool Chariot:

Tx/Rx TCP file send long (bi-directional Rx/Tx)
  w/o TSO: 1500Mbps, 82% CPU
  w/  TSO: 1633Mbps, 75% CPU

Tx TCP file send long (Tx only)
  w/o TSO: 940Mbps, 40% CPU
  w/  TSO: 940Mbps, 19% CPU

A good bump in throughput for the bi-directional test.  The Tx-only test was
already at wire speed, so the gains are pure CPU savings.

I'd like to see SPECWeb results w/ and w/o TSO, and any other relevant
testing.  UDP framentation is not offloaded, so keep testing to TCP.

-scott

[1] Kudos to Alexey Kuznetsov for enabling the stack with TSO support, to
Chris Leech for providing the e1000 bits and a prototype stack, and to David
Miller for consultation.
