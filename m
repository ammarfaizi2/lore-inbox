Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269103AbUINB77@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269103AbUINB77 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 21:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269104AbUINB77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 21:59:59 -0400
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:2976 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S269103AbUINB75 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 21:59:57 -0400
Message-ID: <4146508F.9080700@yahoo.com.au>
Date: Tue, 14 Sep 2004 11:59:43 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [pagevec] resize pagevec to O(lg(NR_CPUS))
References: <20040909163929.GA4484@logos.cnet> <20040909155226.714dc704.akpm@osdl.org> <20040909230905.GO3106@holomorphy.com> <20040909162245.606403d3.akpm@osdl.org> <20040910000717.GR3106@holomorphy.com> <414133EB.8020802@yahoo.com.au> <20040910174915.GA4750@logos.cnet> <20040912045636.GA2660@holomorphy.com> <4143D07E.3030408@yahoo.com.au> <20040913222127.GA23588@logos.cnet>
In-Reply-To: <20040913222127.GA23588@logos.cnet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
>>Sure. And when you fill it with pages, they'll use up 32KB of dcache
>>by using a single 64B line per page. Now that you've blown the cache,
>>when you go to move those pages to another list, you'll have to pull
>>them out of L2 again one at a time.
>>
>>OK, so a 511 item pagevec is pretty unlikely. How about a 64 item one
>>with 128 byte cachelines, and you're touching two cachelines per
>>page operation? That's 16K.
> 
> 
> Nick, 
> 
> Note that you dont read/write data to the actual pages most of the 
> times pagevec's are used. The great majority is just page management code.  
> So we dont really blow the caches like you said.
> 

You're often pulling them off lists though which is what will do it.
Not the actual page, but the struct page.

> I agree we need more tests :) 
> 

Yep.

