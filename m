Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750874AbWJQUzr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750874AbWJQUzr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 16:55:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750875AbWJQUzo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 16:55:44 -0400
Received: from sp604005mt.neufgp.fr ([84.96.92.11]:12285 "EHLO smtp.Neuf.fr")
	by vger.kernel.org with ESMTP id S1750831AbWJQUzh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 16:55:37 -0400
Date: Tue, 17 Oct 2006 22:54:04 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
Subject: Re: BUG: warning at kernel/softirq.c:141/local_bh_enable()
In-reply-to: <20061017201014.51060.qmail@web57802.mail.re3.yahoo.com>
To: John Philips <johnphilips42@yahoo.com>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Message-id: <453542EC.90509@cosmosbay.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 8BIT
References: <20061017201014.51060.qmail@web57802.mail.re3.yahoo.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Philips a écrit :
>> Which NIC driver is handling eth6 ?
> 
> Eric,
> 
> eth6 is a NatSemi DP83815 NIC

Well... lot of changes in drivers/net/natsemi.c between 2.4 and 2.6

Previous versions had a max_interrupt_work = 20;
RX_RING_SIZE is 32 for this NIC

But NAPI standard weight is 64, maybe you should try to lower it ? (so that an 
interrupt dont try to queue/dequeue too many packets at once)

/proc/sys/net/core/dev_weight
/proc/sys/net/core/netdev_budget

Eric
