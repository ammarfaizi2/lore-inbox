Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964841AbWJIUqA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964841AbWJIUqA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 16:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964844AbWJIUp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 16:45:59 -0400
Received: from gate.crashing.org ([63.228.1.57]:4809 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S964841AbWJIUp7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 16:45:59 -0400
Subject: Re: [patch 3/3] mm: fault handler to replace nopage and populate
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Thomas Hellstrom <thomas@tungstengraphics.com>
Cc: Nick Piggin <npiggin@suse.de>, Andrew Morton <akpm@osdl.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <452A50C2.9050409@tungstengraphics.com>
References: <20061009102635.GC3487@wotan.suse.de>
	 <1160391014.10229.16.camel@localhost.localdomain>
	 <20061009110007.GA3592@wotan.suse.de>
	 <1160392214.10229.19.camel@localhost.localdomain>
	 <20061009111906.GA26824@wotan.suse.de>
	 <1160393579.10229.24.camel@localhost.localdomain>
	 <20061009114527.GB26824@wotan.suse.de>
	 <1160394571.10229.27.camel@localhost.localdomain>
	 <20061009115836.GC26824@wotan.suse.de>
	 <1160395671.10229.35.camel@localhost.localdomain>
	 <20061009121417.GA3785@wotan.suse.de>
	 <452A50C2.9050409@tungstengraphics.com>
Content-Type: text/plain
Date: Tue, 10 Oct 2006 06:45:13 +1000
Message-Id: <1160426713.7752.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Wouldn't that confuse concurrent readers?
> 
> Could it be an option to make it safe for the fault handler to 
> temporarily drop the mmap_sem read lock given that some conditions TBD 
> are met?
> In that case it can retake the mmap_sem write lock, do the VMA flags 
> modifications, downgrade and do the pte modifications using a helper, or 
> even use remap_pfn_range() during the time the write lock is held?

If we return NOPAGE_REFAULT, then yes, we can drop the mmap sem, though
I 'm not sure we need that...

Ben.


