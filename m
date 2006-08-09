Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932068AbWHIX64@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbWHIX64 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 19:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932076AbWHIX64
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 19:58:56 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:56964
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932065AbWHIX6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 19:58:55 -0400
Date: Wed, 09 Aug 2006 16:58:46 -0700 (PDT)
Message-Id: <20060809.165846.107940575.davem@davemloft.net>
To: a.p.zijlstra@chello.nl
Cc: tgraf@suug.ch, phillips@google.com, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC][PATCH 2/9] deadlock prevention core
From: David Miller <davem@davemloft.net>
In-Reply-To: <1155132440.12225.70.camel@twins>
References: <44D976E6.5010106@google.com>
	<20060809131942.GY14627@postel.suug.ch>
	<1155132440.12225.70.camel@twins>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Date: Wed, 09 Aug 2006 16:07:20 +0200

> Hmm, what does sk_buff::input_dev do? That seems to store the initial
> device?

You can run grep on the tree just as easily as I can which is what I
did to answer this question.  It only takes a few seconds of your
time to grep the source tree for things like "skb->input_dev", so
would you please do that before asking more questions like this?

It does store the initial device, but as Thomas tried so hard to
explain to you guys these device pointers in the skb are transient and
you cannot refer to them outside of packet receive processing.

The reason is that there is no refcounting performed on these devices
when they are attached to the skb, for performance reasons, and thus
the device can be downed, the module for it removed, etc. long before
the skb is freed up.
