Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751161AbWBJGbH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbWBJGbH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 01:31:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbWBJGbH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 01:31:07 -0500
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:895 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751161AbWBJGbG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 01:31:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=av3OaloasExVxjtotXOACFgFZc/ffZgUpYJDdD2XvNguesE1r3oGt3sOKYOKOHsO8mxSURA9Rj3WHS6/9/al8XDb2BxWEVD1xlFr7fk/lFNVUHcDaswqTUYlM3kab5q3WTF769H2rWxMOBwPEDlhS+VzU826QfuIMSMDUxKP/QY=  ;
Message-ID: <43EC3326.4080706@yahoo.com.au>
Date: Fri, 10 Feb 2006 17:31:02 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux@horizon.com, linux-kernel@vger.kernel.org, sct@redhat.com,
       torvalds@osdl.org
Subject: Re: msync() behaviour broken for MS_ASYNC, revert patch?
References: <20060209071832.10500.qmail@science.horizon.com>	<20060209001850.18ca135f.akpm@osdl.org>	<43EAFEB9.2060000@yahoo.com.au>	<20060209004208.0ada27ef.akpm@osdl.org>	<43EB3801.70903@yahoo.com.au>	<20060209094815.75041932.akpm@osdl.org>	<43EC0A44.1020302@yahoo.com.au>	<20060209195035.5403ce95.akpm@osdl.org>	<43EC0F3F.1000805@yahoo.com.au>	<20060209201333.62db0e24.akpm@osdl.org>	<43EC16D8.8030300@yahoo.com.au>	<20060209204314.2dae2814.akpm@osdl.org>	<43EC1BFF.1080808@yahoo.com.au>	<20060209211356.6c3a641a.akpm@osdl.org>	<43EC24B1.9010104@yahoo.com.au>	<20060209215040.0dcb36b1.akpm@osdl.org>	<43EC2C9A.7000507@yahoo.com.au> <20060209221324.53089938.akpm@osdl.org>
In-Reply-To: <20060209221324.53089938.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:

>>and had no need for a MS_SYNC anywhere in the meantime.
>>If you did have the need for MS_SYNC, then kicking off the IO
>>ASAP is going to be more efficient.
> 
> 
> Of course these sorts of applications don't know what they'll be doing in
> the future.  Often the location of the next update is driven by something
> which came across the network.
> 

If there is no actual need for the application to start a write (eg
for data integrity) then why would it ever do that?

> 
> There's no need to do that.   Look:
> 
> msync(MS_ASYNC): propagate pte dirty flags into pagecache
> 
> LINUX_FADV_ASYNC_WRITE: start writeback on all pages in region which are
> dirty and which aren't presently under writeback.
> 
> LINUX_FADV_WRITE_WAIT: wait on writeback of all pages in range.
> 
> I think that covers all conceivable scenarios.  One thing per operation,
> leave the decisions and tuning up to the application.  And it gives us two
> operations which are also useful in association with regular write().
> 

Oh yeah it is easy if you want to define some more APIs and do
it in a Linux specific way.

But the main function of msync(MS_ASYNC) AFAIK is to *start* IO.
Why do we care so much if some application goes stupid with it?
Why not introduce a linux specific MS_flag to propogate pte dirty
bits?

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
