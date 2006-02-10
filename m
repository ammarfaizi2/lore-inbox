Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751253AbWBJNS7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253AbWBJNS7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 08:18:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbWBJNS7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 08:18:59 -0500
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:20064 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751253AbWBJNS6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 08:18:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=jwZdiJR9KAnFlnYmjF4OXzoyRIkfVW89U0mHrwfLshHy+XWmShM8dI6s5hvMkIoC7ZLIrNcsM6iU2CpwhSM8+jhR78cWrfQn2EymtO5aDTmRNMFhD9dtBR/hy3YL3YHl6WB7M7FQmZUhj0ccaoFAQrrsTMjC5cdwSpp9lH4V2N4=  ;
Message-ID: <43EC92BE.7080409@yahoo.com.au>
Date: Sat, 11 Feb 2006 00:18:54 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: linux@horizon.com
CC: akpm@osdl.org, linux-kernel@vger.kernel.org, sct@redhat.com,
       torvalds@osdl.org
Subject: Re: msync() behaviour broken for MS_ASYNC, revert patch?
References: <20060210080013.6572.qmail@science.horizon.com>
In-Reply-To: <20060210080013.6572.qmail@science.horizon.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux@horizon.com wrote:

>>That's what MS_ASYNC already does.
> 
> 
> Yes, in violation of the SuS spec.  That's what msync(0) already does,
> too, so the linux-specific extension already exists.
> 
> The standard description of MS_INVALIDATE is very confusing and poorly
> worded, but I think it's designed for a model where mmap() copies rather
> than playing page table tricks, and the OS has to copy the dirty pages
> back and forth between the buffer cache "by hand".  Looked at that way,
> the MS_INVALIDATE wording seems to be intended as something of a "commit
> memory writes back to the file system level" operation.
> 
> Which could also be expected to cause the traditional 30-second sync
> timeout to start applying to the written data.  In the current Linux

Yes as we already have something that does the pte->page work (I'd agree
with your interpretation of MS_INVALIDATE), then we definitely have room
to make MS_ASYNC more efficient for applications like yours that use it
properly.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
