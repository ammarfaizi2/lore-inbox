Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751266AbVJPAEM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266AbVJPAEM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 20:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbVJPAEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 20:04:12 -0400
Received: from smtp209.mail.sc5.yahoo.com ([216.136.130.117]:39504 "HELO
	smtp209.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751266AbVJPAEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 20:04:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=GoYKmQcPEttLgi7jIg1YWz5A/0iF42jBZXr+oj11BnwhemHABncyIHCGZfuFnbbq2mZ4dSX0SVxV5fFStn72If/ykiFuBX4GCFP0gWT4G8qeQmZJalVzAu16KvS6yifyTkX7+J+sRsxZ1HaT2bRCtSrlYVixu6G7D9ndIKYOmw8=  ;
Message-ID: <43519905.40902@yahoo.com.au>
Date: Sun, 16 Oct 2005 10:04:21 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050914 Debian/1.7.11-1
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>, hugh@veritas.com,
       paulus@samba.org, anton@samba.org, akpm@osdl.org, andrea@suse.de,
       linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
Subject: Re: Possible memory ordering bug in page reclaim?
References: <E1EQgxs-00061G-00@gondolin.me.apana.org.au> <Pine.LNX.4.64.0510150945460.23590@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510150945460.23590@g5.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> I agree, however, that it looks like PG_dirty is racy. Probably not in 
> practice, but still.
> 
> So I'd suggest adding a smp_wmb() into set_page_dirty, and the rmb where 
> Nick suggested.
> 
> So I'd suggest a patch something more like this.. Marking the dirty/count 
> cases unlikely too in mm/page-writeback.c, since we should have tested for 
> these conditions optimistically outside the lock.
> 

As Dave suggested, I think there is too much other code that depends on
these atomics to be barriers for us to change it (at least not in this
patch! :)).


> Comments? Nick, did you have some test-case that you think might actually 
> have been impacted by this?
> 

I guess your vmscan.c hunks are slightly nicer, though I might put
'cannot_free' right at the end, because it will be a very uncommon case.

And no, I don't have a test case. In fact, I wouldn't be surprised if
nobody anywhere has ever hit it :) I was just browsing code...

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
