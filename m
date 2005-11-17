Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965128AbVKQXoG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965128AbVKQXoG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 18:44:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965129AbVKQXoG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 18:44:06 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:58800
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S965128AbVKQXoF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 18:44:05 -0500
Date: Thu, 17 Nov 2005 15:43:23 -0800 (PST)
Message-Id: <20051117.154323.10862063.davem@davemloft.net>
To: hugh@veritas.com
Cc: akpm@osdl.org, nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/11] unpaged: unifdefed PageCompound
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.61.0511171931400.4563@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0511171925290.4563@goblin.wat.veritas.com>
	<Pine.LNX.4.61.0511171931400.4563@goblin.wat.veritas.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugh Dickins <hugh@veritas.com>
Date: Thu, 17 Nov 2005 19:32:40 +0000 (GMT)

> It looks like snd_xxx is not the only nopage to be using PageReserved as
> a way of holding a high-order page together: which no longer works, but
> is masked by our failure to free from VM_RESERVED areas.  We cannot fix
> that bug without first substituting another way to hold the high-order
> page together, while farming out the 0-order pages from within it.
> 
> That's just what PageCompound is designed for, but it's been kept under
> CONFIG_HUGETLB_PAGE.  Remove the #ifdefs: which saves some space (out-
> of-line put_page), doesn't slow down what most needs to be fast (already
> using hugetlb), and unifies the way we handle high-order pages.
> 
> Signed-off-by: Hugh Dickins <hugh@veritas.com>

I think this is a good change regardless of the VM_RESERVED issues.

I've been wanting to use this facility in some sparc64 bits in
the past, for example.  But since it was HUGETLB guarded that
wasn't possible.
