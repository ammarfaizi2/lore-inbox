Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262541AbUKVTjL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262541AbUKVTjL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 14:39:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262487AbUKVThl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 14:37:41 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:26782 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S262905AbUKVTf5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 14:35:57 -0500
Message-ID: <41A22A8B.8050703@tmr.com>
Date: Mon, 22 Nov 2004 13:06:03 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Nick Piggin <nickpiggin@yahoo.com.au>,
       Christoph Lameter <clameter@sgi.com>, akpm@osdl.org,
       Hugh Dickins <hugh@veritas.com>, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: page fault scalability patch V11 [0/7]: overview
References: <419E98E7.1080402@yahoo.com.au><Pine.LNX.4.44.0411061527440.3567-100000@localhost.localdomain> <Pine.LNX.4.58.0411191753130.2222@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0411191753130.2222@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Sat, 20 Nov 2004, Nick Piggin wrote:
> 
>>The per thread rss may wrap (maybe not 64-bit counters), but even so,
>>the summation over all threads should still end up being correct I
>>think.
> 
> 
> Yes. As long as the total rss fits in an int, it doesn't matter if any of
> them wrap. Addition is still associative in twos-complement arithmetic 
> even in the presense of overflows. 
> 
> If you actually want to make it proper standard C, I guess you'd have to 
> make the thing unsigned, which gives you the mod-2**n guarantees even if 
> somebody were to ever make a non-twos-complement machine.

I think other stuff breaks as well, I think I saw you post some example 
code using something like (a & -a) or similar within the last few 
months. Fortunately neither 1's comp or BCD are likeliy to return in 
hardware. Big-end vs. little-end is still an issue, though.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

