Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751708AbWAFAHh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751708AbWAFAHh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 19:07:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932308AbWAFAHh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 19:07:37 -0500
Received: from smtp-out.google.com ([216.239.45.12]:9342 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932303AbWAFAHg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 19:07:36 -0500
Message-ID: <43BDB381.6020701@mbligh.org>
Date: Thu, 05 Jan 2006 16:02:09 -0800
From: Martin Bligh <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Linus Torvalds <torvalds@osdl.org>, Matt Mackall <mpm@selenic.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Chuck Ebbert <76306.1226@compuserve.com>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@redhat.com>,
       Tim Schmielau <tim@physik3.uni-rostock.de>
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer  compilers
References: <200601041959_MC3-1-B550-5EE2@compuserve.com> <43BC716A.5080204@mbligh.org> <1136463553.2920.22.camel@laptopd505.fenrus.org> <20060105170255.GK3356@waste.org> <43BD5E6F.1040000@mbligh.org> <Pine.LNX.4.64.0601051112070.3169@g5.osdl.org> <Pine.LNX.4.64.0601051126570.3169@g5.osdl.org> <43BD784F.4040804@mbligh.org> <Pine.LNX.4.64.0601051208510.3169@g5.osdl.org> <Pine.LNX.4.64.0601051213270.3169@g5.osdl.org> <20060105233049.GA3441@elte.hu>
In-Reply-To: <20060105233049.GA3441@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I think the only sane solution [that would be endorsed by distributions] 
> is to allow users to reorder function sections runtime (per boot). That 
> is alot faster and more robust (from a production POV) than a full 
> recompilation of the kernel. Recompilation is always risky, it needs too 
> much context, and has too many tool dependencies - and is thus currently 
> untestable. 

<smhuch> - the sound of my eyeballs popping out and splatting against 
the opposite wall.

So ... recompilation is not testable, but boot time reordering of the 
code somehow is? ;-) Yes, I understand the distro toolchain issues, but 
it's still a scary solution ...

Personally, I'd think the sane thing is not to try to optimise by 
workload, but get 80% of the benefit by just reordering on a more 
generalized workload. Doing boot-time reordering for this on non-custom 
kernels just seems terrifying .. it's not that huge a benefit, surely?

> one problem are modules though - they could only be reordered within 
> themselves. On an average system which has ~100 modules loaded, the 
> average icache fragmentation is +100*128/2 == 6.4K [with 128 byte L1 
> cachelines], which can be significant (depending on the workload). OTOH, 
> modules do have strong internal cohesion - they contain functions that 
> belong together conceptually. So by reordering functions within modules 
> we'll likely be able to realize most of the icache savings possible. The 
> only exception would be workloads that utilize many modules at a high 
> frequency. Such workloads will likely trash the icache anyway.

I was thinking about that with modules earlier, and whether modular 
kernels would actually be faster because of that than a statically 
compiled one. But don't you get similar effects from the .o groupings by 
file we get? or does the linker not preserve those groupings?

M.
