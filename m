Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268176AbUHTOw2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268176AbUHTOw2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 10:52:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268183AbUHTOw1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 10:52:27 -0400
Received: from brmx1.fl.icn.siemens.com ([12.147.96.32]:17111 "EHLO
	brmx1.boca.ssc.siemens.com") by vger.kernel.org with ESMTP
	id S268176AbUHTOvE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 10:51:04 -0400
Message-ID: <7A25937D23A1E64C8E93CB4A50509C2A0310F332@stca204a.bus.sc.rolm.com>
From: "Bloch, Jack" <jack.bloch@siemens.com>
To: linux-kernel@vger.kernel.org
Cc: "Laxman, Amruth" <amruth.laxman@siemens.com>
Subject: IP stack question
Date: Fri, 20 Aug 2004 07:50:56 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have the following situation.

I am running a SuSE 2.4.19 Kernel on an SMP machine. I am using the bonding
driver. I have a BOND1 device created with IP address 10.77.67.125 and MAC
address 00:10:18:06:CF:B8.  BOND1 consists of ETH2 and ETH6 in active
standby mode with ETH2 being the active slave and ETH6 being standby. I see
periods of duplicate messages being received by my application. I traced it
down to the fact that the messages are indeed being received by both ETH2
and ETH6 (since ETH6 has the same MAC/IP combination, it does pass messages
up the stack). Further analysis has shown that soem messages coming from the
active bond have a garbage sour address in the MAC header. The source
address seems to be an ASCII representation of the actual MAC address, that
is,   30303A31303A (00:10:). This causes the Ethernet switch to overwrite
its learning tables and subsequent messages for that MAC/IP are broadcast
and received by both chips. I put some tracepoints in the bonding drivers
transmit routine and see that the bad address is in the SKB at the time of
transmission. I would like to know if similar problems have been seen. My
assumtion is that this message arrives  at the bonding driver already "bad"
from the IP stack. The fat that I have bonding allows the error to be seen.
Without bonding, this error would not be noticed.

Please CC me directly on any responses.



Regards,


Jack Bloch


Siemens 
