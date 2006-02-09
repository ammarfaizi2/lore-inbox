Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422898AbWBIMi3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422898AbWBIMi3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 07:38:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422900AbWBIMi3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 07:38:29 -0500
Received: from smtp209.mail.sc5.yahoo.com ([216.136.130.117]:46963 "HELO
	smtp209.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1422898AbWBIMi3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 07:38:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=qtuJNJD+MhSssolyjbp/YTshbIjIXfGqMuC2stDP5epEahaOTXjtAPUw50aFW+xYapXJvU1p2Zc6LZGD8ysWedfMnfCvDPzvRARb0I8NF0pzCc5XouPVZyoI3Yetd9WZxawIZpDMkbzXaIg8J/Kt5r+PJk6iJ8g0oAkFKIPyewM=  ;
Message-ID: <43EB37C5.4060003@yahoo.com.au>
Date: Thu, 09 Feb 2006 23:38:29 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux@horizon.com, linux-kernel@vger.kernel.org, sct@redhat.com
Subject: Re: msync() behaviour broken for MS_ASYNC, revert patch?
References: <20060209071832.10500.qmail@science.horizon.com>	<20060209001850.18ca135f.akpm@osdl.org>	<43EAFEB9.2060000@yahoo.com.au> <20060209004208.0ada27ef.akpm@osdl.org>
In-Reply-To: <20060209004208.0ada27ef.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
>>Andrew Morton wrote:
>>
>>
>>>2.4:
>>>
>>>	MS_ASYNC: dirty the pagecache pages, start I/O
>>>	MS_SYNC: dirty the pagecache pages, start I/O, wait on I/O
>>>
>>>2.6:
>>>
>>>	MS_ASYNC: dirty the pagecache pages
>>>	MS_SYNC: dirty the pagecache pages, start I/O, wait on I/O.
>>>
>>>So you're saying that doing the I/O in that 25-100msec window allowed your
>>>app to do more pipelining.
>>>
>>>I think for most scenarios, what we have in 2.6 is better: it gives the app
>>>more control over when the I/O should be started. 
>>
>>How so?
>>
> 
> 
> Well, for example you might want to msync a number of disjoint parts of the
> mapping, then write them all out in one hit.
> 

That should still be pretty efficient with 2.4 like behaviour? pdflush
does write them out in file offset order doesn't it?

> Or you may not actually _want_ to start the I/O now - you just want pdflush
> to write things back in a reasonable time period, so you don't have unsynced
> data floating about in memory for eight hours.  That's a quite reasonable
> application of msync(MS_ASYNC).
> 

I think data integrity requirements should be handled by MS_SYNC.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
