Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272165AbRHWACF>; Wed, 22 Aug 2001 20:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272166AbRHWABz>; Wed, 22 Aug 2001 20:01:55 -0400
Received: from mail.scsiguy.com ([63.229.232.106]:30982 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S272165AbRHWABj>; Wed, 22 Aug 2001 20:01:39 -0400
Message-Id: <200108230001.f7N01eY19346@aslan.scsiguy.com>
To: "David S. Miller" <davem@redhat.com>
cc: groudier@free.fr, axboe@suse.de, skraw@ithnet.com, phillips@bonn-fries.net,
        linux-kernel@vger.kernel.org
Subject: Re: With Daniel Phillips Patch 
In-Reply-To: Your message of "Wed, 22 Aug 2001 16:09:44 PDT."
             <20010822.160944.08322757.davem@redhat.com> 
Date: Wed, 22 Aug 2001 18:01:40 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Consider network drivers (most PCI ones) that keep track of:
>
>	struct sk_buff *skb;
>	dma_addr_t mapping;
>
>pairs for each transmit packet.  With your suggested change,
>their structures will increase 32-bits in size for each entry
>when CONFIG_HIGHMEM on x86 or on a 64-bit platform.

They already increase by 32bits on IA64.  A driver should use a
fixed sized type for a fixed sized address that corresponds to its
capabilities.  There is no guarantee of the size of dma_addr_t.
It is opaque and should be able to represent all dma (or I would prefer
bus) addresses in the system.  The examples I've seen where people
assume it to be 32bits in size are, well, broken.

--
Justin
