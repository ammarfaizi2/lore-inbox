Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751927AbWIRVXQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751927AbWIRVXQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 17:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751926AbWIRVXP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 17:23:15 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:21392
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751924AbWIRVXP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 17:23:15 -0400
Date: Mon, 18 Sep 2006 14:22:47 -0700 (PDT)
Message-Id: <20060918.142247.14844785.davem@davemloft.net>
To: kuznet@ms2.inr.ac.ru
Cc: ak@suse.de, master@sectorb.msk.ru, hawk@diku.dk,
       harry@atmos.washington.edu, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: Network performance degradation from 2.6.11.12 to 2.6.16.20
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060918210321.GA4780@ms2.inr.ac.ru>
References: <20060918162847.GA4863@ms2.inr.ac.ru>
	<200609181850.22851.ak@suse.de>
	<20060918210321.GA4780@ms2.inr.ac.ru>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Date: Tue, 19 Sep 2006 01:03:21 +0400

> 1. It even does not disable possibility to record timestamp inside
>    driver, which Alan was afraid of. The sequence is:
> 
> 	if (!skb->tstamp.off_sec)
>                 net_timestamp(skb);
> 
> 2. Maybe, netif_rx() should continue to get timestamp in netif_rx().
> 
> 3. NAPI already introduced almost the same inaccuracy. And it is really
>    silly to waste time getting timestamp in netif_receive_skb() a few
>    moments before the packet is delivered to a socket.
> 
> 4. ...but clock source, which takes one of top lines in profiles
>    must be repaired yet. :-)

Ok, ok, but don't we have queueing disciplines that need the timestamp
even on ingress?
