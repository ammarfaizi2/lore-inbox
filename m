Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752255AbWAEWyt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752255AbWAEWyt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 17:54:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752253AbWAEWyt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 17:54:49 -0500
Received: from smtp-out.google.com ([216.239.45.12]:24575 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751148AbWAEWyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 17:54:49 -0500
Message-ID: <43BDA271.2020502@mbligh.org>
Date: Thu, 05 Jan 2006 14:49:21 -0800
From: Martin Bligh <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt Mackall <mpm@selenic.com>
CC: Linus Torvalds <torvalds@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       Chuck Ebbert <76306.1226@compuserve.com>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@redhat.com>,
       Tim Schmielau <tim@physik3.uni-rostock.de>
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer  compilers
References: <200601041959_MC3-1-B550-5EE2@compuserve.com> <43BC716A.5080204@mbligh.org> <1136463553.2920.22.camel@laptopd505.fenrus.org> <20060105170255.GK3356@waste.org> <43BD5E6F.1040000@mbligh.org> <Pine.LNX.4.64.0601051112070.3169@g5.osdl.org> <Pine.LNX.4.64.0601051126570.3169@g5.osdl.org> <20060105213442.GM3356@waste.org> <Pine.LNX.4.64.0601051402550.3169@g5.osdl.org> <20060105223656.GP3356@waste.org>
In-Reply-To: <20060105223656.GP3356@waste.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>>What I was proposing was something like, say, arch/i386/popularity.lst, 
>>>which would simply contain a list of the most popular n% of functions 
>>>sorted by popularity. As text, of course.
>>
>>I suspect that would certainlty work for pure function-based popularity, 
>>and yes, it has the advantage of being simple (especially for something 
>>that ends up being almost totally separated from the compiler: if we're 
>>using this purely to modify link scripts etc with special tools).
>>
>>But what about the unlikely/likely conditional hints that we currently do 
>>by hand? How are you going to sanely maintain a list of those without 
>>doing that in source code?
> 
> 
> Dunno. Those bits are all anonymous so marking them in situ is about
> the only way to go. But we can do better for whole functions.

Would also make it easier to rank it as a percentage, or group by
locality of reference to other functions, rather than just a binary
split of "rare" vs "not-rare".

Of course it's all very dependant on workload, which drivers you're 
using too, etc, etc. So a profile that's separate also makes it much
easier to tweak for one machine than the source base in general, which
theoretically represents everyone (and thus has little info ;-)).

Which also makes me think it's easier to mark hot functions than cold
ones, in a more general maintainance sense.

M.
