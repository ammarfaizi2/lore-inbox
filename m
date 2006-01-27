Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751346AbWA0SQM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346AbWA0SQM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 13:16:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751406AbWA0SQM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 13:16:12 -0500
Received: from dvhart.com ([64.146.134.43]:4999 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S1751346AbWA0SQL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 13:16:11 -0500
Message-ID: <43DA6369.5050108@mbligh.org>
Date: Fri, 27 Jan 2006 10:16:09 -0800
From: Martin Bligh <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Ray Bryant <raybry@mpdtxmail.amd.com>,
       Dave McCracken <dmccr@us.ibm.com>, Robin Holt <holt@sgi.com>,
       Hugh Dickins <hugh@veritas.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [PATCH/RFC] Shared page tables
References: <A6D73CCDC544257F3D97F143@[10.1.1.4]> <200601240210.04337.ak@suse.de> <1138086398.2977.19.camel@laptopd505.fenrus.org> <200601240818.28696.ak@suse.de>
In-Reply-To: <200601240818.28696.ak@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Tuesday 24 January 2006 08:06, Arjan van de Ven wrote:
> 
>>>The randomization is not for cache coloring, but for security purposes
>>>(except for the old very small stack randomization that was used
>>>to avoid conflicts on HyperThreaded CPUs). I would be surprised if the
>>>mmap made much difference because it's page aligned and at least
>>>on x86 the L2 and larger caches are usually PI.
>>
>>randomization to a large degree is more important between machines than
>>within the same machine (except for setuid stuff but lets call that a
>>special category for now). Imo prelink is one of the better bets to get
>>"all code for a binary/lib on the same 2 mb page",
> 
> 
> Probably yes.
> 
> 
>>all distros ship 
>>prelink nowadays anyway 
> 
> 
> SUSE doesn't use it.
> 
> 
>>(it's too much of a win that nobody can afford 
>>to not ship it ;) 
> 
> 
> KDE and some other people disagree on that. 
> 
> 
>>and within prelink the balance between randomization 
>>for security and 2Mb sharing can be struck best. In fact it needs know
>>about the 2Mb thing anyway to place it there properly and for all
>>binaries... the kernel just can't do that.
> 
> 
> Well, we first have to figure out if the shared page tables
> are really worth all the ugly code, nasty locking and other problems 
> (inefficient TLB flush etc.) I personally would prefer
> to make large pages work better before going down that path.

That needs defragmentation, etc, etc. etc. It also requires changes to 
userspace apps. Large pages are crippled right now, and it looks like 
they're going to stay that way. We need some sort of solution, and this 
is pretty clean and transparent, by comparison.

m.
