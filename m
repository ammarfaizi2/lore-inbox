Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267291AbSLELw6>; Thu, 5 Dec 2002 06:52:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267299AbSLELw6>; Thu, 5 Dec 2002 06:52:58 -0500
Received: from h-64-105-35-8.SNVACAID.covad.net ([64.105.35.8]:43211 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S267291AbSLELw5>; Thu, 5 Dec 2002 06:52:57 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Thu, 5 Dec 2002 03:57:53 -0800
Message-Id: <200212051157.DAA04682@adam.yggdrasil.com>
To: david@gibson.dropbear.id.au
Subject: Re: [RFC] generic device DMA implementation
Cc: davem@redhat.com, James.Bottomley@steeleye.com, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, miles@gnu.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Gibson wrote:
>Since, with James's approach you'd need a dma sync function (which
>might compile to NOP) in pretty much the same places you'd need
>map/sync calls, I don't see that it does make the source noticeably
>simpler.

        Because then you don't have to have a branch for
case where the platform *does* support consistent memory.

>>       If were to try the approach of using pci_{map,sync}_single
>> always (i.e., just writing the code not to use alloc_consistent),
>> that would have a performance cost on machines where using
>> consistent memory for writing small amounts of data is cheaper than
>> the cost of the cache flushes that would otherwise be required.
>
>Well, I'm only talking about the cases where we actually care about
>reducing the use of consistent memory.

        Then you're not fully weighing the benefits of this facility.
The primary beneficiaries of this facility are device drivers for
which we'd like to have the performance advantages of consistent
memory when available (at least on machines that always return
consistent memory) but which we'd also like to have work as
efficiently as possible on platforms that lack consistent memory or
have so little that we want the device driver to still work even when
no consistent memory is available.  That includes all PCI devices that
users of the inconsistent parisc machines want to use.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
