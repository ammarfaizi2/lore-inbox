Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262547AbUGICG7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262547AbUGICG7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 22:06:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262744AbUGICG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 22:06:59 -0400
Received: from smtp011.mail.yahoo.com ([216.136.173.31]:34970 "HELO
	smtp011.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262547AbUGICG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 22:06:58 -0400
Message-ID: <40EDFDBE.5040805@yahoo.com.au>
Date: Fri, 09 Jul 2004 12:06:54 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Peter Osterlund <petero2@telia.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Can't make use of swap memory in 2.6.7-bk19
References: <m2brir9t6d.fsf@telia.com> <40ECADF8.7010207@yahoo.com.au> <20040708023001.GN21066@holomorphy.com> <m2briq7izk.fsf@telia.com> <20040708193956.GO21066@holomorphy.com> <40EDED5D.80605@yahoo.com.au> <20040709015317.GR21066@holomorphy.com>
In-Reply-To: <20040709015317.GR21066@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> William Lee Irwin III wrote:
> 
>>>Oh, then I'm stuck in the GFP_WIRED quagmire after all. I guess since
>>>fixing it involves adding lines I'm in deep trouble.
> 
> 
> On Fri, Jul 09, 2004 at 10:57:01AM +1000, Nick Piggin wrote:
> 
>>Or just see if you can tighten up the conditions for OOM to
>>start with?
> 
> 
> You must not have seen the patches. the thread starts with Message-id:
> <0406231407.HbLbJbXaHbKbWa5aJb1a4aKb0a3aKb1a0a2aMbMbYa3aLbMb3aJbWaJbXaMbLb1a342@holomorphy.com>
> 
> They added a flag indicating wiredness or no to the gfp_mask, which was
> then propagated down the call chain and eventually passed as an argument
> to out_of_memory(). In turn, out_of_memory() used the flag to determine
> whether the nr_swap_pages > 0 check was relevant. i.e. they refined the
> OOM conditions based on the wiredness of the failing allocation. What
> probably got the stuff permavetoed was the stats reporting I did along
> with it that would have been trivial to drop while retaining the needed
> functional change. The patch was motivated by the nr_swap_pages > 0
> check deadlocking. The __GFP_WIRED business was done to discriminate
> the obvious deadlocking scenario from the false OOM mentioned here.
> 

No, I did see those patches. I'm not saying they're not worth
persuing; on the contrary, they look quite interesting. However,
it might worthwhile looking at more basic things first, for this
problem anyway.
