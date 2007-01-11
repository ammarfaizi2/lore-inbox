Return-Path: <linux-kernel-owner+w=401wt.eu-S1750849AbXAKQpl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750849AbXAKQpl (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 11:45:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750850AbXAKQpl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 11:45:41 -0500
Received: from smtp.osdl.org ([65.172.181.24]:45903 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750848AbXAKQpk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 11:45:40 -0500
Date: Thu, 11 Jan 2007 08:45:02 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Roy Huang <royhuang9@gmail.com>
cc: Aubrey <aubreylee@gmail.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Andrew Morton <akpm@osdl.org>, Hua Zhong <hzhong@gmail.com>,
       Hugh Dickins <hugh@veritas.com>, linux-kernel@vger.kernel.org,
       hch@infradead.org, kenneth.w.chen@intel.com, mjt@tls.msk.ru
Subject: Re: O_DIRECT question
In-Reply-To: <afe668f90701110005ya2e8187pc6604c5aad24cc84@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0701110842480.3594@woody.osdl.org>
References: <6d6a94c50701101857v2af1e097xde69e592135e54ae@mail.gmail.com> 
 <Pine.LNX.4.64.0701101902270.3594@woody.osdl.org> 
 <6d6a94c50701102150w4c3b46d0w6981267e2b873d37@mail.gmail.com> 
 <20070110220603.f3685385.akpm@osdl.org>  <6d6a94c50701102245g6afe6aacxfcb2136baee5cbfa@mail.gmail.com>
  <20070110225720.7a46e702.akpm@osdl.org>  <45A5E1B2.2050908@yahoo.com.au> 
 <6d6a94c50701102354l7ab41a3bp4761566204f1d992@mail.gmail.com>
 <afe668f90701110005ya2e8187pc6604c5aad24cc84@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 11 Jan 2007, Roy Huang wrote:
>
> On a embedded systerm, limiting page cache can relieve memory
> fragmentation. There is a patch against 2.6.19, which limit every
> opened file page cache and total pagecache. When the limit reach, it
> will release the page cache overrun the limit.

I do think that something like this is probably a good idea, even on 
non-embedded setups. We historically couldn't do this, because mapped 
pages were too damn hard to remove, but that's obviously not much of a 
problem any more.

However, the page-cache limit should NOT be some compile-time constant. It 
should work the same way the "dirty page" limit works, and probably just 
default to "feel free to use 90% of memory for page cache".

		Linus
