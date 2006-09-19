Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752017AbWISTrr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752017AbWISTrr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 15:47:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752010AbWISTrr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 15:47:47 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:32197
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1752009AbWISTrq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 15:47:46 -0400
Date: Tue, 19 Sep 2006 12:47:51 -0700 (PDT)
Message-Id: <20060919.124751.24100694.davem@davemloft.net>
To: kuznet@ms2.inr.ac.ru
Cc: master@sectorb.msk.ru, ak@suse.de, hawk@diku.dk,
       harry@atmos.washington.edu, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: Network performance degradation from 2.6.11.12 to 2.6.16.20
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060918220038.GB14322@ms2.inr.ac.ru>
References: <200609181850.22851.ak@suse.de>
	<20060918211759.GB31746@tentacle.sectorb.msk.ru>
	<20060918220038.GB14322@ms2.inr.ac.ru>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Date: Tue, 19 Sep 2006 02:00:38 +0400

> * I do not undestand what the hell dhcp needs timestamps for.

I can't even find a reference to SIOCGSTAMP in the
dhcp-2.0pl5 or dhcp3-3.0.3 sources shipped in Ubuntu.

But I will note that tpacket_rcv() expects to always get
valid timestamps in the SKB, it does a:

	if (skb->tstamp.off_sec == 0) { 
		__net_timestamp(skb);
		sock_enable_timestamp(sk);
	}

so that it can fill in the h->tp_sec and h->tp_usec
fields.
