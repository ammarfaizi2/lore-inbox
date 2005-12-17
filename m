Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751378AbVLQHNF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751378AbVLQHNF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 02:13:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751377AbVLQHNF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 02:13:05 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:50320
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751375AbVLQHND (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 02:13:03 -0500
Date: Fri, 16 Dec 2005 23:10:56 -0800 (PST)
Message-Id: <20051216.231056.124758189.davem@davemloft.net>
To: jbarnes@virtuousgeek.org
Cc: torvalds@osdl.org, dhowells@redhat.com, nickpiggin@yahoo.com.au,
       arjan@infradead.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       cfriesen@nortel.com, hch@infradead.org, matthew@wil.cx,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <200512161641.49571.jbarnes@virtuousgeek.org>
References: <Pine.LNX.4.64.0512161429500.3698@g5.osdl.org>
	<20051216.145306.132052494.davem@davemloft.net>
	<200512161641.49571.jbarnes@virtuousgeek.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jesse Barnes <jbarnes@virtuousgeek.org>
Date: Fri, 16 Dec 2005 16:41:49 -0800

> Note that under contention prefetching with a write bias can cause a lot 
> more cache line bouncing than a regular load into shared state (assuming 
> you do a load and test before you try the CAS).

If there is some test guarding the CAS, yes.

But if there isn't, for things like atomic increment and
decrement, where the CAS is unconditional, you'll always
eat the two bus transactions without the prefetch for write.
