Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750785AbWIBEiy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbWIBEiy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Sep 2006 00:38:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbWIBEiy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Sep 2006 00:38:54 -0400
Received: from dsl-7-36.cofs.net ([68.142.7.36]:52538 "EHLO www.palei.com")
	by vger.kernel.org with ESMTP id S1750785AbWIBEix (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Sep 2006 00:38:53 -0400
Message-ID: <000f01c6ce49$affd37e0$3224050a@avilespaxp>
From: "Paul Aviles" <paul.aviles@palei.com>
To: <linux-kernel@vger.kernel.org>
Subject: e1000 Detected Tx Unit Hang
Date: Sat, 2 Sep 2006 00:38:50 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2869
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am getting "e1000: eth0: e1000_clean_tx_irq: Detected Tx Unit Hang" using 
stock 2.6.17.11, 2.6.17.5 or 2.6.17.4 kernels on centos 4.3.

The server is a Tyan GS10 and is connected to a Netgear GS724T Gig switch. I 
can easily reproduce the problem by trying to do a large ftp transfer to the 
server. It does not happen if the server is connected to a dummy 100 Mb 
switch, only when is connected to the Gig switch.
I have also tried the options line below disabling tso, tx and rx in the 
modprobe.conf without any luck.

options e1000 XsumRX=0 Speed=1000 Duplex=2 InterruptThrottleRate=0 
FlowControl=3 RxDescriptors=4096 TxDescriptors=4096 RxIntDelay=0 
TxIntDelay=0

in /var/log/kernel I get the following...

Sep  1 23:53:01 www kernel: e1000: eth0: e1000_clean_tx_irq: Detected Tx 
Unit Hang
Sep  1 23:53:01 www kernel:   Tx Queue             <0>
Sep  1 23:53:01 www kernel:   TDH                  <4c4>
Sep  1 23:53:01 www kernel:   TDT                  <4c9>
Sep  1 23:53:01 www kernel:   next_to_use          <4c9>
Sep  1 23:53:01 www kernel:   next_to_clean        <4c4>
Sep  1 23:53:01 www kernel: buffer_info[next_to_clean]
Sep  1 23:53:01 www kernel:   time_stamp           <ffff9c60>
Sep  1 23:53:01 www kernel:   next_to_watch        <4c4>
Sep  1 23:53:01 www kernel:   jiffies              <ffff9d96>
Sep  1 23:53:01 www kernel:   next_to_watch.status <0>
.
repeats the same as above a few times....
.
Sep  1 23:53:10 www kernel: NETDEV WATCHDOG: eth0: transmit timed out
Sep  1 23:53:13 www kernel: e1000: eth0: e1000_watchdog_task: NIC Link is Up 
1000 Mbps Full Duplex

then the server locks up, no response from the keyboard at all and must be 
forced down with a power kill.

Here is my driver info,

driver: e1000
version: 7.0.33-k2-NAPI
firmware-version: N/A
bus-info: 0000:02:01.0

What else could I check?

Regards,

Paul Aviles 



-- 
VGER BF report: U 0.5
