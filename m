Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318884AbSICRqy>; Tue, 3 Sep 2002 13:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318885AbSICRqy>; Tue, 3 Sep 2002 13:46:54 -0400
Received: from hdfdns01.hd.intel.com ([192.52.58.10]:56538 "EHLO
	mail1.hd.intel.com") by vger.kernel.org with ESMTP
	id <S318884AbSICRqw>; Tue, 3 Sep 2002 13:46:52 -0400
Message-ID: <288F9BF66CD9D5118DF400508B68C4460283E575@orsmsx113.jf.intel.com>
From: "Feldman, Scott" <scott.feldman@intel.com>
To: "'Jordi Ros'" <jros@ece.uci.edu>, "David S. Miller" <davem@redhat.com>
Cc: "Feldman, Scott" <scott.feldman@intel.com>, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org, haveblue@us.ibm.com, Manand@us.ibm.com,
       kuznet@ms2.inr.ac.ru,
       "Leech, Christopher" <christopher.leech@intel.com>
Subject: RE: TCP Segmentation Offloading (TSO)
Date: Tue, 3 Sep 2002 10:50:27 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jordi Ros wrote:

> What i am wondering is how come we only get a few percentage 
> improvement in throughput. Theoretically, since 64KB/1.5KB ~= 
> 40, we should get a throughput improvement of 40 times. 

You're confusing number of packets with throughput.  Cut the wire, and you
can't tell the difference with or without TSO.  It's the same amount of data
on the wire.  As David pointed out, the savings comes in how much data is
DMA'ed across the bus and how much the CPU is unburdened by the segmentation
task.  A 64K TSO would be one pseudo header and the rest payload.  Without
TSO you would add ~40 more headers.  That's the savings across the bus.
 
> Is there any other bottleneck in the system that prevents 
> us to see the 300% improvement? (i am assuming the card can 
> do tso at wire speed)

My numbers are against PCI 64/66Mhz, so that's limiting.  You're not going
to get much more that 940Mbps at 1GbE unidirectional.  That's why all of the
savings at unidirectional Tx are in CPU reduction.

-scott
