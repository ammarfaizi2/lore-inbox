Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261536AbVCHTI3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261536AbVCHTI3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 14:08:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261528AbVCHTHi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 14:07:38 -0500
Received: from alog0465.analogic.com ([208.224.222.241]:29312 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261521AbVCHTGc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 14:06:32 -0500
Date: Tue, 8 Mar 2005 14:04:47 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: kernel mmap() and friends.
Message-ID: <Pine.LNX.4.61.0503081403340.12268@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello mem-map gurus,

If one uses x = __get_dma_pages(GFP_KERNEL, nr), finds the physical
address with b = virt_to_bus(x), then attempts to mmap(,,b,,,) the result
_does_not_fail_, yet the user ends up with memory ...somewhere....
that is R/W able and WRONG.

Yet, if the code executes SetPageReserved(virt_to_page(x)), the
mmap() works and the user gets the CORRECT page(s).

I think that if mmap() needs a physical buffer to be reserved
then that's fine. However, silently returning some different
buffer is a BUG.

Is anyone aware of this BUG? Does anybody else care?

Cheers,
Dick Johnson
Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
