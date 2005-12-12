Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751204AbVLLKrB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbVLLKrB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 05:47:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbVLLKrB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 05:47:01 -0500
Received: from smtp105.mail.sc5.yahoo.com ([66.163.169.225]:4996 "HELO
	smtp105.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751204AbVLLKrB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 05:47:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=lO2RRCK7++7uR0s9odB663ZCpjQWGiem9r+MM8NU3WRueuOgYdVQkuiV9wYJuiTnK7weqP9Y8Hwvlia0lbPOHW4WcJ/mLBqs70j88LAWLIJ2M5koyUdrqVUdwi3R//RPdRjFXz0oIwtDsGSHOPBWFj4upUjxkl9eRZWt04L6qbo=  ;
Message-ID: <439D5520.6000400@yahoo.com.au>
Date: Mon, 12 Dec 2005 21:46:56 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       David Gibson <david@gibson.dropbear.id.au>, Jens Axboe <axboe@suse.de>,
       "Michael S. Tsirkin" <mst@mellanox.co.il>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PageCompound avoid page[1].mapping
References: <Pine.LNX.4.61.0512092151240.28965@goblin.wat.veritas.com> <20051210070248.GE2838@holomorphy.com>
In-Reply-To: <20051210070248.GE2838@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> On Fri, Dec 09, 2005 at 09:56:42PM +0000, Hugh Dickins wrote:
> 
>>-	page[1].mapping = (void *)free_huge_page;
>>+	page[1].index = (unsigned long)free_huge_page;	/* set dtor */
>> 	for (i = 0; i < (HPAGE_SIZE/PAGE_SIZE); ++i)
>> 		clear_highpage(&page[i]);
>> 	return page;
> 
> 
> Hmm, ->lru would be nicer. What prompted the use of ->index?
> 

Yes, agreed. That would rid you of __page_count() too.

Send instant messages to your online friends http://au.messenger.yahoo.com 
