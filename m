Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264389AbRFYWfb>; Mon, 25 Jun 2001 18:35:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264425AbRFYWfV>; Mon, 25 Jun 2001 18:35:21 -0400
Received: from pizda.ninka.net ([216.101.162.242]:3456 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264389AbRFYWfP>;
	Mon, 25 Jun 2001 18:35:15 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15159.48229.326223.682824@pizda.ninka.net>
Date: Mon, 25 Jun 2001 15:34:13 -0700 (PDT)
To: Will <will@egregious.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] skb destructor enhancement idea
In-Reply-To: <20010625140613.A17207@egregious.net>
In-Reply-To: <20010618134644.A5938@egregious.net>
	<20010618145331.A32166@wacko.asicdesigners.com>
	<20010621161349.A27654@egregious.net>
	<20010625140613.A17207@egregious.net>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Will writes:
 > We are currently using this change in a low-level packet monitoring module so we can
 > allocate our own packet memory and get called back when the skb is done moving
 > through the stack. It seems like it should be useful to allow network drivers to
 > implement their own device-specific memory management and thus reduce mem copying
 > overhead, too.
 > 
 > Any driver people want to try it out and see if they can make their driver use it to
 > reduce copying?
 > 
 > Any comments on the idea in general?

I think the idea totally stinks.

It puts a new shared cache line (the spinlock) into the hot path of
SKB allocation and freeing on SMP.

Add an ifdef and the knobs you need to the skb struct directly just
like netfilter does.

Later,
David S. Miller
davem@redhat.com

