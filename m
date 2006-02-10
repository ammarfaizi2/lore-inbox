Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751112AbWBJF30@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751112AbWBJF30 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 00:29:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751113AbWBJF30
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 00:29:26 -0500
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:45736 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751112AbWBJF3Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 00:29:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=NsJHSZcunxtY8NWh9gBDPkl1yRGpA5r58GbJiFDe+inObWDoBCKV2HcyAan3dCHHgBmqB/wNUsP2Cqbj9LgWlY2+ql2oreCZdeZg7zQa5BJIHZl4qH7BM1uHQyylFZSemVV97VaSOkIjLJuKaMqIX2N/Nmz+6ZmgdDKTElYCniw=  ;
Message-ID: <43EC24B1.9010104@yahoo.com.au>
Date: Fri, 10 Feb 2006 16:29:21 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux@horizon.com, linux-kernel@vger.kernel.org, sct@redhat.com
Subject: Re: msync() behaviour broken for MS_ASYNC, revert patch?
References: <20060209071832.10500.qmail@science.horizon.com>	<20060209001850.18ca135f.akpm@osdl.org>	<43EAFEB9.2060000@yahoo.com.au>	<20060209004208.0ada27ef.akpm@osdl.org>	<43EB3801.70903@yahoo.com.au>	<20060209094815.75041932.akpm@osdl.org>	<43EC0A44.1020302@yahoo.com.au>	<20060209195035.5403ce95.akpm@osdl.org>	<43EC0F3F.1000805@yahoo.com.au>	<20060209201333.62db0e24.akpm@osdl.org>	<43EC16D8.8030300@yahoo.com.au>	<20060209204314.2dae2814.akpm@osdl.org>	<43EC1BFF.1080808@yahoo.com.au> <20060209211356.6c3a641a.akpm@osdl.org>
In-Reply-To: <20060209211356.6c3a641a.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
>>If you want to start the IO *now* without waiting on it, call msync(MS_ASYNC)
>> If you don't want to start the IO now, that's really easy, do nothing.
>> If you want to start the IO now and also wait for it to finish, call msync(MS_SYNC)
> 
> 
> I've already explained the problems with the start-io-in-MS_ASYNC approach.
> 

But I've explained that they only matter for people using it in stupid ways.
fsync also poses a performance problem for programs that call it after every
write(2).

> 
>> Presently, the first option is unavailable.
> 
> 
> We need to patch the kernel either way.  There's no point in going back to
> either the known-problematic approach or to something half-assed.
> 

The system call indicates to the kernel that IO submission should be started.
The earlier the kernel does that, the better (because it is likely that an
MS_SYNC is coming soon).

I think the current way of just moving the dirty bits is half-assed.

Is a more efficient implementation know-problematic? What applications did
you observe problems with, can you remember? Because the current behaviour
is also known-problematic for linux@horizon.com (who are you anyway?)

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
