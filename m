Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318729AbSICHcp>; Tue, 3 Sep 2002 03:32:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318725AbSICHcp>; Tue, 3 Sep 2002 03:32:45 -0400
Received: from meter.eng.uci.edu ([128.200.85.3]:31469 "EHLO meter.eng.uci.edu")
	by vger.kernel.org with ESMTP id <S318722AbSICHcn>;
	Tue, 3 Sep 2002 03:32:43 -0400
From: "Jordi Ros" <jros@ece.uci.edu>
To: "David S. Miller" <davem@redhat.com>
Cc: <scott.feldman@intel.com>, <linux-kernel@vger.kernel.org>,
       <linux-net@vger.kernel.org>, <haveblue@us.ibm.com>, <Manand@us.ibm.com>,
       <kuznet@ms2.inr.ac.ru>, <christopher.leech@intel.com>
Subject: RE: TCP Segmentation Offloading (TSO)
Date: Tue, 3 Sep 2002 00:26:13 -0700
Message-ID: <JCEFIMMPGNNGFPMJJKINIEMJCDAA.jros@ece.uci.edu>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
In-Reply-To: <20020902.235244.64832172.davem@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What i am wondering is how come we only get a few percentage improvement in
throughput. Theoretically, since 64KB/1.5KB ~= 40, we should get a
throughput improvement of 40 times. That would be the case of udp
transmiting in one direction, in the case of tcp transmiting in one
direction (which is the one you have implemented), since in average we have
(at most) 1 ack every 2 data packets, we should theoretically obtain a
throughput improvement of (40+20)/(1+20) = 3 (this comes from: without tso
we send 40 packets and receive 20 acks, this is, the cpu processes 60
packets; whereas with tso we send 1 packet and receive 20 acks, this is, the
cpu processes 21 packets).
However, we don't see in the numbers obtained neither an increase of
throughput of 300% nor a decrease in cpu utilization of such magnitude. Is
there any other bottleneck in the system that prevents us to see the 300%
improvement? (i am assuming the card can do tso at wire speed)

thank you,

jordi





These improvement should be reflected in terms of cpu offloading and

-----Original Message-----
From: linux-net-owner@vger.kernel.org
[mailto:linux-net-owner@vger.kernel.org]On Behalf Of David S. Miller
Sent: Monday, September 02, 2002 11:53 PM
To: jros@ece.uci.edu
Cc: scott.feldman@intel.com; linux-kernel@vger.kernel.org;
linux-net@vger.kernel.org; haveblue@us.ibm.com; Manand@us.ibm.com;
kuznet@ms2.inr.ac.ru; christopher.leech@intel.com
Subject: Re: TCP Segmentation Offloading (TSO)


   From: "Jordi Ros" <jros@ece.uci.edu>
   Date: Mon, 2 Sep 2002 21:58:32 -0700

   i assume the mtu is ethernet 1500 Bytes, right? and that mss should be
   something much bigger than mtu, which gives the performance improvement
   shown in the numbers.

The performance improvement comes from the fact that the card
is given huge 64K packets, then the card (using the given ip/tcp
headers as a template) spits out 1500 byte mtu sized packets.

Less data DMA'd to the device per normal-mtu packet and less
per-packet data structure work by the cpu is where the improvement
comes from.
-
To unsubscribe from this list: send the line "unsubscribe linux-net" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html



