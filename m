Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263440AbUCTPG0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 10:06:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263442AbUCTPG0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 10:06:26 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:14804
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263440AbUCTPFc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 10:05:32 -0500
Date: Sat, 20 Mar 2004 16:06:21 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
Message-ID: <20040320150621.GO9009@dualathlon.random>
References: <20040320133025.GH9009@dualathlon.random> <20040320144022.GC2045@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040320144022.GC2045@holomorphy.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 20, 2004 at 06:40:22AM -0800, William Lee Irwin III wrote:
> On Sat, Mar 20, 2004 at 02:30:25PM +0100, Andrea Arcangeli wrote:
> > Anyways returning to the non-ram returned by ->nopage see the below
> > email exchange with Jens. the bug triggering of course is the
> > BUG_ON(!pfn_valid(page_to_pfn(new_page))).
> > If we want to return non-ram, we could, but I believe we should change
> > the API to return a pfn not a page_t * if we want to.
> 
> This would be very helpful for other reasons also. There's a general
> API issue with drivers that want or need to do this. The one I've

I'm afraid I'll have to teach ->nopage how to deal with non-ram with
this page_t API too (changing it to pfn sounds too intrusive in the
short term), it seems to me that alsa can return non-ram (in the nopage
callback there's a virt_to_page on some iomm region), and changing alsa
to use remap_file_pages sounds too intrusive too. 

So in short I believe alsa can corrupt memory randomly starting with
2.6.5-rc1, and it could only generate machine check crashes in previous
kernels.

So for the short term (i.e. next few weeks) we'll have to deal with
page_t still there...
