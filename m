Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275778AbRJQMVR>; Wed, 17 Oct 2001 08:21:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275789AbRJQMVH>; Wed, 17 Oct 2001 08:21:07 -0400
Received: from park.nikhef.nl ([192.16.199.192]:17047 "EHLO park.nikhef.nl")
	by vger.kernel.org with ESMTP id <S275778AbRJQMUy>;
	Wed, 17 Oct 2001 08:20:54 -0400
Date: Wed, 17 Oct 2001 14:21:25 +0200 (MET DST)
From: Joris van Rantwijk <jorisvr@nikhef.nl>
To: linux-kernel@vger.kernel.org
Subject: acenic failure with highmem in 2.4.12
Message-ID: <Pine.SUN.3.95.1011017140054.21824A-100000@bilbo.nikhef.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

When I enable the Acenic network driver in combination with high
memory set to 4Gb, the driver fails during boot and prints:

eth0: Firmware NOT running!

This happens with 2.4.12 as well as with 2.4.12-ac3, but 2.4.11 was
working fine even with high memory enabled. With high memory disabled,
the problem disappears and everything works fine.

A diff on acenic.c between 2.4.11 and 2.4.12 reveals that the acenic
driver now does pci_unmap_single() calls which were previously suppressed
by an #ifdef. It thus seems that these are the cause of the problem,
but I don't understand how or why.

Details:
dual Pentium-III with 1 Gb SDRAM.
3Com 3C985 Gigabit Ethernet, Tigon II (Rev. 6), Firmware: 12.4.11
SMP enabled in kernel.

Any ideas ?

Thanks,
  Joris.

