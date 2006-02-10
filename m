Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751091AbWBJEwT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091AbWBJEwT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 23:52:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751093AbWBJEwT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 23:52:19 -0500
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:13461 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751091AbWBJEwS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 23:52:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=T/zOqvS4sXUBES7ruthhA4I3yuYOASkpH9fnvjIyaJVqr+BzLsdSxByQYpXlNhcfqg0/76dRQ5OZ5wo9N83K5AKN3xELecKdzmEDtoTYhMy+da3qVz9AwKvb3Nn0tUIBWPuYRD1h34saNl5b9llSb3sCfE8WaDnglOumpeDcUSc=  ;
Message-ID: <43EC1BFF.1080808@yahoo.com.au>
Date: Fri, 10 Feb 2006 15:52:15 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux@horizon.com, linux-kernel@vger.kernel.org, sct@redhat.com
Subject: Re: msync() behaviour broken for MS_ASYNC, revert patch?
References: <20060209071832.10500.qmail@science.horizon.com>	<20060209001850.18ca135f.akpm@osdl.org>	<43EAFEB9.2060000@yahoo.com.au>	<20060209004208.0ada27ef.akpm@osdl.org>	<43EB3801.70903@yahoo.com.au>	<20060209094815.75041932.akpm@osdl.org>	<43EC0A44.1020302@yahoo.com.au>	<20060209195035.5403ce95.akpm@osdl.org>	<43EC0F3F.1000805@yahoo.com.au>	<20060209201333.62db0e24.akpm@osdl.org>	<43EC16D8.8030300@yahoo.com.au> <20060209204314.2dae2814.akpm@osdl.org>
In-Reply-To: <20060209204314.2dae2814.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
>>>Secondly, consider the behaviour of the above application if it is modifying
>>
>> > the same page relatively frequently (quite likely).  If MS_ASYNC starts I/O
>> > immediately, that page will get written 10, 100 or 1000 times per second. 
>> > If MS_ASYNC leaves it to pdflush, that page gets written once per 30
>> > seconds, so we do far much less I/O.
>> > 
>> > We just don't know.  It's better to leave it up to the application designer
>> > rather than lumping too many operations into the one syscall.
>>
>> Well it remains the same conceptual operation (asynchronously "schedule"
>> dirty pages for writeout). However it simply becomes more useful to start
>> the writeout immediately, given that's the (pretty explicit) hint that is
>> given to us.
> 
> 
> If you want to start the I/O now, fine, start the I/O now.
> 
> If you don't want to start I/O now, fine, don't start I/O now.
> 
> If msync() were to unconditionally start I/O, you don't get that option.
> 

Huh? Sure you do.

If you want to start the IO *now* without waiting on it, call msync(MS_ASYNC)
If you don't want to start the IO now, that's really easy, do nothing.
If you want to start the IO now and also wait for it to finish, call msync(MS_SYNC)

Presently, the first option is unavailable.

> It's pretty simple, isn't it?
> 

Yes.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
