Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318711AbSICFEz>; Tue, 3 Sep 2002 01:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318710AbSICFEz>; Tue, 3 Sep 2002 01:04:55 -0400
Received: from meter.eng.uci.edu ([128.200.85.3]:57312 "EHLO meter.eng.uci.edu")
	by vger.kernel.org with ESMTP id <S318709AbSICFEx>;
	Tue, 3 Sep 2002 01:04:53 -0400
From: "Jordi Ros" <jros@ece.uci.edu>
To: "Feldman, Scott" <scott.feldman@intel.com>, <linux-kernel@vger.kernel.org>,
       "linux-net" <linux-net@vger.kernel.org>,
       "'Dave Hansen'" <haveblue@us.ibm.com>, <Manand@us.ibm.com>
Cc: <kuznet@ms2.inr.ac.ru>, "'David S. Miller'" <davem@redhat.com>,
       "Leech, Christopher" <christopher.leech@intel.com>
Subject: RE: TCP Segmentation Offloading (TSO)
Date: Mon, 2 Sep 2002 21:58:32 -0700
Message-ID: <JCEFIMMPGNNGFPMJJKINGEMHCDAA.jros@ece.uci.edu>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
In-Reply-To: <288F9BF66CD9D5118DF400508B68C4460283E564@orsmsx113.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One question regarding the throughput numbers,

what was the size of the packets built at the tcp layer (mss)?

i assume the mtu is ethernet 1500 Bytes, right? and that mss should be
something much bigger than mtu, which gives the performance improvement
shown in the numbers.

thanks,

jordi

-----Original Message-----
From: linux-net-owner@vger.kernel.org
[mailto:linux-net-owner@vger.kernel.org]On Behalf Of Feldman, Scott
Sent: Monday, September 02, 2002 10:45 AM
To: linux-kernel@vger.kernel.org; linux-net; 'Dave Hansen';
'Manand@us.ibm.com'
Cc: kuznet@ms2.inr.ac.ru; 'David S. Miller'; Leech, Christopher
Subject: TCP Segmentation Offloading (TSO)


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
-
To unsubscribe from this list: send the line "unsubscribe linux-net" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html



