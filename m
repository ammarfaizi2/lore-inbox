Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261231AbUKNB3l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbUKNB3l (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 20:29:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261230AbUKNB3l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 20:29:41 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:60351 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261231AbUKNB31
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 20:29:27 -0500
Message-ID: <4196B4E9.40502@pobox.com>
Date: Sat, 13 Nov 2004 20:29:13 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Thomas Spatzier <thomas.spatzier@de.ibm.com>
CC: linux-kernel@vger.kernel.org, Netdev <netdev@oss.sgi.com>
Subject: Re: [patch 4/10] s390: network driver.
References: <OF88EC0E9F.DE8FC278-ONC1256F4A.0038D5C0-C1256F4A.00398E11@de.ibm.com>
In-Reply-To: <OF88EC0E9F.DE8FC278-ONC1256F4A.0038D5C0-C1256F4A.00398E11@de.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Spatzier wrote:
> 
> 
> 
>>You should be using netif_carrier_{on,off} properly, and not drop the
>>packets.  When (if) link comes back, you requeue the packets to hardware
>>(or hypervisor or whatever).  Your dev->stop() should stop operation and
>>clean up anything left in your send/receive {rings | buffers}.
>>
> 
> 
> When we do not drop packets, but call netif_stop_queue the write queues
> of all sockets associated to the net device are blocked as soon as they
> get full. This causes problems with programs such as the zebra routing
> daemon. So we have to keep the netif queue running in order to not block
> any programs.

This is very, very wrong.  You are essentially creating in in-driver 
/dev/null simulator.  This does nothing but chew CPU cycles by having 
the driver drop packets, rather than allowing the system to work as it 
should.

Queues are DESIGNED to fill up under various conditions.

Would not the zebra routing software have the same problems with cable 
pull under an e1000 or tg3 gigabit NIC?


> We also had a look at some other drivers and the common behaviour seems to
> be that packets are lost if the network cable is pulled out.

Which drivers, specifically, are these?

The most popular drivers -- e1000, tg3, etc. -- do not do this, for very 
good reasons.

	Jeff


