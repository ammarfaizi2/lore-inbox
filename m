Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261701AbULJEcX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261701AbULJEcX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 23:32:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261707AbULJEcW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 23:32:22 -0500
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:23187 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261701AbULJEad (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 23:30:33 -0500
Message-ID: <41B92662.40600@yahoo.com.au>
Date: Fri, 10 Dec 2004 15:30:26 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
CC: Linus Torvalds <torvalds@osdl.org>, Hugh Dickins <hugh@veritas.com>,
       akpm@osdl.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-mm@kvack.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: page fault scalability patch V12 [0/7]: Overview and performance
 tests
References: <Pine.LNX.4.44.0411221457240.2970-100000@localhost.localdomain> <Pine.LNX.4.58.0411221343410.22895@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0411221419440.20993@ppc970.osdl.org> <Pine.LNX.4.58.0411221424580.22895@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0411221429050.20993@ppc970.osdl.org> <Pine.LNX.4.58.0412011539170.5721@schroedinger.engr.sgi.com> <41B8060A.4050402@yahoo.com.au> <Pine.LNX.4.58.0412090858420.10400@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.58.0412090858420.10400@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> On Thu, 9 Dec 2004, Nick Piggin wrote:
> 
> 
>>>For more than 8 cpus the page fault rate increases by orders
>>>of magnitude. For more than 64 cpus the improvement in performace
>>>is 10 times better.
>>
>>Those numbers are pretty impressive. I thought you'd said with earlier
>>patches that performance was about doubled from 8 to 512 CPUS. Did I
>>remember correctly? If so, where is the improvement coming from? The
>>per-thread RSS I guess?
> 
> 
> Right. The per-thread RSS seems to have made a big difference for high CPU
> counts. Also I was conservative in the estimates in earlier post since I
> did not have the numbers for the very high cpu counts.
> 

Ah OK.

> 
>>On another note, these patches are basically only helpful to new
>>anonymous page faults. I guess this is the main thing you are concerned
>>about at the moment, but I wonder if you would see improvements with
>>my patch to remove the ptl from the other types of faults as well?
> 
> 
> I can try that but I am frankly a bit sceptical since the ptl protects
> many other variables. It may be more efficient to have the ptl in these
> cases than doing the atomic ops all over the place. Do you have any number
> you could post? I believe I send you a copy of the code that I use for
> performance tests last week or so,
> 

Yep I have your test program. No real numbers because the biggest thing
I have to test on is a 4-way - there is improvement, but it is not so
impressive as your 512 way tests! :)

> 
>>The downside of my patch - well the main downsides - compared to yours
>>are its intrusiveness, and the extra cost involved in copy_page_range
>>which yours appears not to require.
> 
> 
> Is the patch known to be okay for ia64? I can try to see how it
> does.
> 

I think it just needs one small fix to the swapping code, and it should
be pretty stable. So in fact it would probably work for you as is (if you
don't swap), but I'd rather have something more stable before I ask you
to test. I'll try to find time to do that in the next few days.

> 
>>As I've said earlier though, I wouldn't mind your patches going in. At
>>least they should probably get into -mm soon, when Andrew has time (and
>>after the 4level patches are sorted out). That wouldn't stop my patch
>>(possibly) being merged some time after that if and when it was found
>>worthy...
> 
> 
> I'd certainly be willing to poke around and see how beneficial this is. If
> it turns out to accellerate other functionality of the vm then you
> have my full support.
> 

Great, thanks.
