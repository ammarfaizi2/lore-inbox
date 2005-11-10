Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751690AbVKJDHp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751690AbVKJDHp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 22:07:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751693AbVKJDHo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 22:07:44 -0500
Received: from sccrmhc12.comcast.net ([63.240.77.82]:41131 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1751686AbVKJDHo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 22:07:44 -0500
From: kernel-stuff@comcast.net (Parag Warudkar)
To: Tony <tony.uestc@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Debug: sleeping function called from invalid context at mm/slab.c:2126
Date: Thu, 10 Nov 2005 03:07:32 +0000
Message-Id: <111020050307.1697.4372B974000B129D000006A1220073544600009A9B9CD3040A029D0A05@comcast.net>
X-Mailer: AT&T Message Center Version 1 (Dec 17 2004)
X-Authenticated-Sender: a2VybmVsLXN0dWZmQGNvbWNhc3QubmV0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm writing a net_device driver. I want to send a packet when the timer 
> is out. I get the following warning. It seems that I should not call 
> alloc_skb. Can anyone tell me how to get rid of this? Thanks in advance.
>

You are calling alloc_skb which in turn calls kmem_cache_alloc in interrupt context where things can't sleep and kmem_cache_alloc can sleep.  The reason for this is that you are passing GFP_KERNEL to alloc_skb. Try passing GFP_ATOMIC instead.

Other alternative is to may be use a precreated pool of skbs - may be this can be done in driver init function or any other safe context. But I don't know how much feasible that is in your situation.

HTH
Parag


