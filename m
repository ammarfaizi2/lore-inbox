Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263443AbUCTP1f (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 10:27:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263444AbUCTP1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 10:27:34 -0500
Received: from holomorphy.com ([207.189.100.168]:32392 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263443AbUCTP1d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 10:27:33 -0500
Date: Sat, 20 Mar 2004 07:27:30 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
Message-ID: <20040320152730.GF2045@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
References: <20040320133025.GH9009@dualathlon.random> <20040320144022.GC2045@holomorphy.com> <20040320150621.GO9009@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040320150621.GO9009@dualathlon.random>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 20, 2004 at 04:06:21PM +0100, Andrea Arcangeli wrote:
> I'm afraid I'll have to teach ->nopage how to deal with non-ram with
> this page_t API too (changing it to pfn sounds too intrusive in the
> short term), it seems to me that alsa can return non-ram (in the nopage
> callback there's a virt_to_page on some iomm region), and changing alsa
> to use remap_file_pages sounds too intrusive too. 
> So in short I believe alsa can corrupt memory randomly starting with
> 2.6.5-rc1, and it could only generate machine check crashes in previous
> kernels.
> So for the short term (i.e. next few weeks) we'll have to deal with
> page_t still there...

I've developed an interest in drivers recently, so I may be able to do
some of the footwork here in a timely fashion if we want to go the pfn-
based API route. That actually sounded like the less intrusive of the
two methods I mentioned as well as easily mergeable within a stable
series. OTOH, if there are objections, it may have to wait.

I don't believe devolving larger swaths of the fault path to drivers
would be very difficult to restructure drivers to use. The hard parts
are that it would be time-consuming and would likely merit a support
API exported by architectures to make driver writers' lives easier (i.e.
not introduce more bugs than it resolves) that would need to be agreed
upon, or at least backed by a feature request survey. And, of course,
it would need an implementation for every architecture, which could be
difficult to arrange for the less documented and/or less frequently
updated architectures if features the core doesn't already rely upon
would be required. And that's a certainty, since the core not
understanding the needs of those drivers would be the primary motive
for the more intrusive approach.


-- wli
