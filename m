Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265470AbUFZE7I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265470AbUFZE7I (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 00:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266365AbUFZE7I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 00:59:08 -0400
Received: from palrel13.hp.com ([156.153.255.238]:17866 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S265470AbUFZE7F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 00:59:05 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16605.653.502075.164097@napali.hpl.hp.com>
Date: Fri, 25 Jun 2004 21:58:53 -0700
To: Andi Kleen <ak@muc.de>
Cc: Terence Ripperda <tripperda@nvidia.com>, discuss@x86-64.org, tiwai@suse.de,
       linux-kernel@vger.kernel.org, andrea@suse.de
Subject: Re: 32-bit dma allocations on 64-bit platforms
In-Reply-To: <20040624185156.GA19559@colin2.muc.de>
References: <20040623234644.GC38425@colin2.muc.de>
	<20040624154429.GC8014@hygelac>
	<20040624185156.GA19559@colin2.muc.de>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Thu, 24 Jun 2004 20:51:56 +0200, Andi Kleen <ak@muc.de> said:

  Andi> A better IO_TLB_SHIFT would be 16 or 17.

Careful.  I see code like this:

		stride = (1 << (PAGE_SHIFT - IO_TLB_SHIFT));

You probably don't want IO_TLB_SHIFT > PAGE_SHIFT...  Increasing
io_tlb_nslabs should be no problem though (subject to memory
availability).  It can already by set via the "swiotlb" option.

I doubt swiotlb is the right thing here, though, given the bw-demands
of graphics.  Too bad Nvidia cards don't support > 32 bit
addressability and Intel chipsets don't support I/O MMUs...

	--david
