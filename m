Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272159AbRHVXKI>; Wed, 22 Aug 2001 19:10:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272157AbRHVXJ7>; Wed, 22 Aug 2001 19:09:59 -0400
Received: from pizda.ninka.net ([216.101.162.242]:30593 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S272159AbRHVXJm>;
	Wed, 22 Aug 2001 19:09:42 -0400
Date: Wed, 22 Aug 2001 16:09:44 -0700 (PDT)
Message-Id: <20010822.160944.08322757.davem@redhat.com>
To: gibbs@scsiguy.com
Cc: groudier@free.fr, axboe@suse.de, skraw@ithnet.com, phillips@bonn-fries.net,
        linux-kernel@vger.kernel.org
Subject: Re: With Daniel Phillips Patch 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200108222140.f7MLeUY17166@aslan.scsiguy.com>
In-Reply-To: <20010822223658.X932-100000@gerard>
	<200108222140.f7MLeUY17166@aslan.scsiguy.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Justin T. Gibbs" <gibbs@scsiguy.com>
   Date: Wed, 22 Aug 2001 15:40:30 -0600
   
   I've started looking through the network devices for bloat caused
   by the change in size of this type and I haven't found it anywhere.

Consider network drivers (most PCI ones) that keep track of:

	struct sk_buff *skb;
	dma_addr_t mapping;

pairs for each transmit packet.  With your suggested change,
their structures will increase 32-bits in size for each entry
when CONFIG_HIGHMEM on x86 or on a 64-bit platform.

I mean, just grep for dma_addr_t in structures of these networking
drivers to see where the wasted space would be.

Later,
David S. Miller
davem@redhat.com

