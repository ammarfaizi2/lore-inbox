Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267517AbTACNIg>; Fri, 3 Jan 2003 08:08:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267518AbTACNIg>; Fri, 3 Jan 2003 08:08:36 -0500
Received: from robur.slu.se ([130.238.98.12]:10770 "EHLO robur.slu.se")
	by vger.kernel.org with ESMTP id <S267517AbTACNIf>;
	Fri, 3 Jan 2003 08:08:35 -0500
From: Robert Olsson <Robert.Olsson@data.slu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15893.36673.476788.286469@robur.slu.se>
Date: Fri, 3 Jan 2003 14:25:21 +0100
To: Steffen Persvold <sp@scali.com>
Cc: linux-kernel@vger.kernel.org, <davem@redhat.com>, netdev@oss.sgi.com
Subject: One-way Gigabit Ethernet TCP performance with Jumbo frames
In-Reply-To: <Pine.LNX.4.44.0301021329410.18738-200000@sp-laptop.isdn.scali.no>
References: <3E142D85.71FFA06C@digeo.com>
	<Pine.LNX.4.44.0301021329410.18738-200000@sp-laptop.isdn.scali.no>
X-Mailer: VM 6.92 under Emacs 19.34.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Steffen Persvold writes:
 > Hi all,
 > 
 > Lately I've been testing out two Gigabit Ethernet adapters on Pentium 4 
 > Xeon platforms; onboard Intel 82544GC (e1000 driver) and onboard Broadcom 
 > BCM5701 (tg3 driver), and I'm experiencing some wierd behaviour on 
 > one-way tests (ping-ping). The machines I'm testing is connected back to 
 > back (i.e no switch) and are fairly fast systems (Dual Xeon 2.4 GHz, 1GB 
 > memory) configured to use Jumbo frames (9000 bytes).


 > But, when running a one-way test (where one machine only sends, and the 
 > other only receives, i.e ping-ping) there is a serious dip in the 
 > performance curve at ~768 bytes and the bandwidth levels out at approx 
 > 60 MByte/sec (about half of peak) regadless of application and GbE device. 

 I've seen similar problems... and most of the times this seems due to 
 incorrect tuned mitigation. Think of what happens if you don't have TX-
 interrupts enough to clean your TX-ring. Which means your app. can not
 fill it at full speed -- and as long you have RX traffic it contributes 
 with interrupts so the problem is not visile. 

 If you test IP-forwarding with RX soly on one interface and TX soly on the
 other and routing between them. You'll see drops at the qdisc in such case.

 Cheers.
						--ro




