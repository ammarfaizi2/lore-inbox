Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932082AbVJPXB5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932082AbVJPXB5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Oct 2005 19:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932083AbVJPXB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Oct 2005 19:01:57 -0400
Received: from mx1.redhat.com ([66.187.233.31]:8684 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932082AbVJPXB5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Oct 2005 19:01:57 -0400
Date: Sun, 16 Oct 2005 19:01:48 -0400
From: Dave Jones <davej@redhat.com>
To: Alan Hourihane <alanh@fairlite.demon.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.14-rc4 AGP performance fixes
Message-ID: <20051016230148.GB15602@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Alan Hourihane <alanh@fairlite.demon.co.uk>,
	linux-kernel@vger.kernel.org
References: <20051014094217.GA15871@fairlite.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051014094217.GA15871@fairlite.demon.co.uk>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 14, 2005 at 10:42:17AM +0100, Alan Hourihane wrote:
 > AGP allocation/deallocation is suffering major performance issues due to the 
 > nature of global_flush_tlb() being called on every change_page_attr() call.
 > 
 > For small allocations this isn't really seen, but when you start allocating
 > 50000 pages of AGP space, for say, texture memory, then things can take 
 > seconds to complete.
 > 
 > In some cases the situation is doubled or even quadrupled in the time due 
 > to SMP, or a deallocation, then a new reallocation. I've had a case of 
 > upto 20 seconds wait time to deallocate and reallocate AGP space.

Yikes.

 > This patch fixes the problem by making it the caller's responsibility to 
 > call global_flush_tlb(), and so removes it from every instance of mapping 
 > a page into AGP space until the time that all change_page_attr() changes 
 > are done.

I like the idea of minimising the flushes where we can, however the idea
of having stale entries in the TLB's, even for a short time gives me the jibblies
a little. If this does cause any problems, they're likely to be of a nature that
would be incredibly difficult to track down.
(We've been bitten on more than one occasion due to missing flushes in this driver).
Given the wide variety of hardware this driver supports, I'd like this
to sit in -mm for a while, just to be on the safe side.

If Andrew picks that up now, that gives us a while for testing before 2.6.15 closes
for features.

		Dave

