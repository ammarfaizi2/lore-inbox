Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267908AbRGZM5l>; Thu, 26 Jul 2001 08:57:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267912AbRGZM5V>; Thu, 26 Jul 2001 08:57:21 -0400
Received: from samar.sasken.com ([164.164.56.2]:38899 "EHLO samar.sasken.com")
	by vger.kernel.org with ESMTP id <S267908AbRGZM5N>;
	Thu, 26 Jul 2001 08:57:13 -0400
Date: Thu, 26 Jul 2001 18:27:02 +0530 (IST)
From: Deepika Kakrania <deepika@sasken.com>
To: <linux-net@vger.rutgers.edu>
cc: <linux-kernel@vger.kernel.org>
Subject: CBQ is not limiting bandwidth!!!
Message-ID: <Pine.GSO.4.30.0107261754530.26764-100000@sunk2.sasi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


 Hi all,

   I am using CBQ to limit the packet transmission rate to some small
value(say 1Mbit...10Kbit) over an ethernet interface so that I can see
queue building up at output side (having the queue length >10 or so while
sending heavy traffic).

The set up I am using is something like this

  dst				router				src
  ----------    		 ---------- 		      ----------
  |	   |		  eth1   |	  |		      |	       |
  |	   |-------------------- |	  |-------------------|        |
  ---------			 ---------		      ---------
   178.18.0.1		178.18.0.2     178.19.0.1	178.19.0.2

  All 3 m/cs are connected thru' cross cables. The src m/c sends the
traffic to dst m/c using netperf.
  I am defining only one class at m/c router on interface eth1. The tc
rules set up for doing so are following.

 tc qdisc add dev eth1 root handle 1: cbq bandwidth 10Mbit cell 8 avpkt
1000 mpu 64

 tc class add dev eth1 parent 1:0 classud 1:1 cbq bandwidth 10Mbit rate
1kbit allot 1514 cell 8 weigth 100bit prio 5 maxburst 20 avpkt 1000

 tc filter add dev eth1 parent 1:0 protocol ip prio 100 u32 match ip dst
178.18.0.1 flowid 1:1

 But the result I get from netperf gives me the throughput of 6.81 Mbit
even after setting the rate to 1Kbit.

Another problem is that the queue length is 1 after enqueueing
the packet at any time even if I send the traffic using 'ping -f
178.18.0.1'.

Can anyone tell me what could be the problem? Am I missing something?

Thanks in advance.

regards,
Deepika

Ps: I am not subscribed to this mailing list so please reply to my
personal account.

----------------------------------------------------------------------------
 Deepika Kakrania
 Sasken Communication Technologies Limited

 Phone No:(080) 5578 300 Extn:8059
                5289906 (res)
 Email: deepika@sasi.com

