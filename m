Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752170AbWAETxu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752170AbWAETxu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 14:53:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752185AbWAETxu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 14:53:50 -0500
Received: from smtp-out.google.com ([216.239.45.12]:17343 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1752170AbWAETxu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 14:53:50 -0500
Message-ID: <43BD784F.4040804@mbligh.org>
Date: Thu, 05 Jan 2006 11:49:35 -0800
From: Martin Bligh <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Matt Mackall <mpm@selenic.com>, Arjan van de Ven <arjan@infradead.org>,
       Chuck Ebbert <76306.1226@compuserve.com>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@redhat.com>,
       Tim Schmielau <tim@physik3.uni-rostock.de>
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer  compilers
References: <200601041959_MC3-1-B550-5EE2@compuserve.com> <43BC716A.5080204@mbligh.org> <1136463553.2920.22.camel@laptopd505.fenrus.org> <20060105170255.GK3356@waste.org> <43BD5E6F.1040000@mbligh.org> <Pine.LNX.4.64.0601051112070.3169@g5.osdl.org> <Pine.LNX.4.64.0601051126570.3169@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0601051126570.3169@g5.osdl.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Thu, 5 Jan 2006, Linus Torvalds wrote:
> 
>>That way the "profile data" actually follows the source code, and is thus 
>>actually relevant to an open-source project. Because we do _not_ start 
>>having specially optimized binaries. That's against the whole point of 
>>being open source and trying to get users to get more deeply involved with 
>>the project.
> 
> 
> Btw, having annotations obviously works, although it equally obviously 
> will limit the scope of this kind of profile data. You won't get the same 
> kind of granularity, and you'd only do the annotations for cases that end 
> up being very clear-cut. But having an automated feedback cycle for adding 
> (and removing!) annotations should make it pretty maintainable in the long 
> run, although the initial annotations migh only end up being for really 
> core code.
> 
> There's a few papers around that claim that programmers are often very 
> wrong when they estimate probabilities for different code-paths, and that 
> you absolutely need automation to get it right. I believe them. But the 
> fact that you need automation doesn't automatically mean that you should 
> feed the compiler a profile-data-blob.

Hmm. if you're just going to do it as binary on/off ...is it not pretty 
trivial to do a crude test implementation by booting the kernel, turning
on profiling, running a bunch of different tests, then marking anything
that never appears at all in profiling as rare?

Not saying it's a good long-term approach, but would it not give us 
enough data to know whether the whole approach was worthwhile? I suspect
(on random gut-feel) we never call at over 50% of the functions we have
(an even easier hypothesis to test)

OTOH, do we have that much to gain anyway in kernel space? all we're 
doing is packing stuff down into the same cacheline or not, isn't it?
As we have all pages pinned in memory, does it matter for any reason
beyond that?

M.
