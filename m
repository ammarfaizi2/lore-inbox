Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268886AbUIXQkj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268886AbUIXQkj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 12:40:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268900AbUIXQiD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 12:38:03 -0400
Received: from smtp209.mail.sc5.yahoo.com ([216.136.130.117]:65402 "HELO
	smtp209.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S268929AbUIXQXy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 12:23:54 -0400
Message-ID: <41544876.4040302@yahoo.com.au>
Date: Sat, 25 Sep 2004 02:16:54 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Steven Pratt <slpratt@austin.ibm.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFC] Simplified Readahead
References: <4152F46D.1060200@austin.ibm.com> <20040923194216.1f2b7b05.akpm@osdl.org> <41543FE2.5040807@austin.ibm.com>
In-Reply-To: <41543FE2.5040807@austin.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Pratt wrote:
> Andrew Morton wrote:
> 
>> Steven Pratt <slpratt@austin.ibm.com> wrote:
>>  
>>
>>> would like to offer up an alternative simplified design which will 
>>> not only make the code easier to maintain,
>>>   
>>
>>
>> We won't know that until all functionality is in place.
>>  
>>
> Ok, but both you and Nick indicated that the queue congestion isn't 
> needed,

I would have thought that always doing the readahead would provide a
more graceful degradation, assuming the readahead algorithm is fairly
accurate, and copes with things like readahead thrashing (which we
hope is the case).

>> I do think we should skip the I/O for POSIX_FADV_WILLNEED against a
>> congested queue.  I can't immediately think of a good reason for skipping
>> the I/O for normal readahead.
>>  

I don't see why you should skip the readahead for FADVISE_WILLNEED
either. Presumably if someone needs this, they really need it. We
should aim for optimal behaviour when the apis are being used correctly...
