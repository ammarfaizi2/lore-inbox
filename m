Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932119AbWAEUSW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119AbWAEUSW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 15:18:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932141AbWAEUSW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 15:18:22 -0500
Received: from smtp.osdl.org ([65.172.181.4]:19625 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932119AbWAEUSV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 15:18:21 -0500
Date: Thu, 5 Jan 2006 12:13:13 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Martin Bligh <mbligh@mbligh.org>
cc: Matt Mackall <mpm@selenic.com>, Arjan van de Ven <arjan@infradead.org>,
       Chuck Ebbert <76306.1226@compuserve.com>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@redhat.com>,
       Tim Schmielau <tim@physik3.uni-rostock.de>
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer  compilers
In-Reply-To: <43BD784F.4040804@mbligh.org>
Message-ID: <Pine.LNX.4.64.0601051208510.3169@g5.osdl.org>
References: <200601041959_MC3-1-B550-5EE2@compuserve.com> <43BC716A.5080204@mbligh.org>
 <1136463553.2920.22.camel@laptopd505.fenrus.org> <20060105170255.GK3356@waste.org>
 <43BD5E6F.1040000@mbligh.org> <Pine.LNX.4.64.0601051112070.3169@g5.osdl.org>
 <Pine.LNX.4.64.0601051126570.3169@g5.osdl.org> <43BD784F.4040804@mbligh.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 5 Jan 2006, Martin Bligh wrote:
> 
> Hmm. if you're just going to do it as binary on/off ...is it not pretty
> trivial to do a crude test implementation by booting the kernel, turning
> on profiling, running a bunch of different tests, then marking anything
> that never appears at all in profiling as rare?

Yes, I think "crude" is exactly where we want to start. It's much easier 
to then make it smarter later.

> Not saying it's a good long-term approach, but would it not give us enough
> data to know whether the whole approach was worthwhile?

Yes. And it's entirely possible that "crude" is perfectly fine even in the 
long run. I suspect this is very much a "5% of the work gets us 80% of the 
benefit", with a _very_ long tail with tons of more work to get very minor 
incremental savings..

> OTOH, do we have that much to gain anyway in kernel space? all we're doing is
> packing stuff down into the same cacheline or not, isn't it?
> As we have all pages pinned in memory, does it matter for any reason
> beyond that?

The cache effects are likely the biggest ones, and no, I don't know how 
much denser it will be in the cache. Especially with a 64-byte one.. 
(although 128 bytes is fairly common too).

There are some situations where we have TLB issues, but those are likely 
cases where we don't care about placement performance anyway (ie they'd
be in situations where you use the page-alloc-debug stuff, which is very 
expensive for _other_ reasons ;)

		Linus
