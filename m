Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315517AbSGXCQa>; Tue, 23 Jul 2002 22:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316567AbSGXCQ3>; Tue, 23 Jul 2002 22:16:29 -0400
Received: from pizda.ninka.net ([216.101.162.242]:65460 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S315517AbSGXCQ3>;
	Tue, 23 Jul 2002 22:16:29 -0400
Date: Tue, 23 Jul 2002 19:09:03 -0700 (PDT)
Message-Id: <20020723.190903.50511601.davem@redhat.com>
To: trond.myklebust@fys.uio.no
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.27 fix potential spinlocking race.
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <15677.48609.62376.119269@charged.uio.no>
References: <15677.48609.62376.119269@charged.uio.no>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


   In case of socket transmission errors etc. kfree_skb(), and hence
   xprt_write_space() can potentially get called outside of a bh-safe
   context.

kfree_skb must occur within a BH context or better context.

When HW interrupt handlers free packets they use kfree_skb_irq() which
schedules a software interrupt to really perform the kfree_skb work.

Therefore kfree_skb must always be invoked in BH or better context.

I think we need to reevaluate this situation before we apply this
patch :-)
