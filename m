Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261386AbUB1LwU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 06:52:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261796AbUB1LwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 06:52:20 -0500
Received: from freedom.icomedias.com ([62.99.232.79]:10507 "EHLO
	freedom.grz.icomedias.com") by vger.kernel.org with ESMTP
	id S261386AbUB1LwS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 06:52:18 -0500
Subject: Re: Network error with Intel E1000 Adapter on update 2.4.25 ==> 2.6.3
Date: Sat, 28 Feb 2004 12:52:17 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <FA095C015271B64E99B197937712FD020B01BD@freedom.grz.icomedias.com>
X-MS-Has-Attach: 
Content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
X-MS-TNEF-Correlator: 
Thread-Topic: Network error with Intel E1000 Adapter on update 2.4.25 ==> 2.6.3
Thread-Index: AcP9U0fqhpAdnwOLQviDu+fAro6esQAiQlXw
From: "Martin Bene" <martin.bene@icomedias.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> When trying to update the kernel from 2.4.25 to 2.6.3 I run 
>> into a probelm:
>> While the driver for the onboard Intel E1000 network adapter 
>> loads OK, it
>> doesn't seem to find an interrupt for the interface - ifconfig shows:
>> eth0      Link encap:Ethernet  HWaddr 00:0E:A6:2D:7A:64
>>           BROADCAST MULTICAST  MTU:1500  Metric:1
>>           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>>           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
>>           collisions:0 txqueuelen:1000
>>           RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)
>>           Base address:0x9000 Memory:fc000000-fc020000
>> Board is an Asus PC-DL, Intel 875P Chipset, one Xeon 2.8Ghz 
>> CPU, Onboard
>> e1000 Network interface. Any idea how I can get the onboard 
>> NIC to work?

>full output of /var/log/dmesg || dmesg after bootup might help.

Some more information: 

* Update to 2.6.4-rc1 doesn't help, same situation as before.
* 2.4.25 finds/uses int 18
* Binary search shows that the problem first appears with 2.6.2-bk1; 2.6.2 works OK.

Further search shows that it's the e1000 driver update from 5.2.20 to 5.2.30.1 that breaks things for me. copying the older driver into a newer kernel works.

Hmm, changelog states what looks like a possible candidate: 

*   o Use pdev->irq rather than netdev->irq in preparation for MSI support.

Final information:

Backing out the pdev->irq <-> netdev->irq changes gives me ifconfig output with the correct interrupt listed; unfortunately, 
	ifconfig eth0 up 
still locks the machine, so that doesn't seem to be the only problem.

Bye, Martin
