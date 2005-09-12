Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751201AbVILH7E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbVILH7E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 03:59:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751203AbVILH7D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 03:59:03 -0400
Received: from ns.suse.de ([195.135.220.2]:34960 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751201AbVILH7B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 03:59:01 -0400
From: Andi Kleen <ak@suse.de>
To: "Jan Beulich" <JBeulich@novell.com>
Subject: Re: [discuss] [1/3] Add 4GB DMA32 zone
Date: Mon, 12 Sep 2005 09:58:55 +0200
User-Agent: KMail/1.8
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, discuss@x86-64.org
References: <43246267.mailL4R11PXCB@suse.de> <43254DF40200007800024E0D@emea1-mh.id2.novell.com>
In-Reply-To: <43254DF40200007800024E0D@emea1-mh.id2.novell.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509120958.55936.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 12 September 2005 09:44, Jan Beulich wrote:
> It seems a little strange to add individual zones one by one. I remember
> from an OS project I previously worked on that at some time our driver
> developers ran into one or more devices that were able to consume 31-bit
> physical addresses

That's likely the unnamed RAID controller with the broken firmware refered to 
below (they might actually have fixed the firmware now) But for block
devices it's not really needed anyways. From my experience and those
of other folks (IA64) the 4GB zone + a small fallback zone is a good 
compromise.

> (but not 32-bit ones, and don't ask me for details on 
> what exact devices these were, I never knew). I thus wonder whether it
> wouldn't make more sense to generalize the logic and allow drivers to
> specify to the allocator how many physical address bits they can deal
> with.

Because that would likely either impact the page allocation fast path
by having unsuited data structures for the normal case or make the code to 
allocate pages with arbitary boundaries really slow because the allocation
wouldn't be O(1). Didn't seem like a good tradeoff.

-Andi

