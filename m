Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265537AbUEZMYq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265537AbUEZMYq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 08:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265540AbUEZMYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 08:24:45 -0400
Received: from smtp017.mail.yahoo.com ([216.136.174.114]:56695 "HELO
	smtp017.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265537AbUEZMYb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 08:24:31 -0400
Message-ID: <40B48C78.6040005@yahoo.com.au>
Date: Wed, 26 May 2004 22:24:24 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Buddy Lumpkin <b.lumpkin@comcast.net>
CC: "'John Bradford'" <john@grabjohn.com>,
       "'William Lee Irwin III'" <wli@holomorphy.com>, orders@nodivisions.com,
       linux-kernel@vger.kernel.org
Subject: Re: why swap at all?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Buddy Lumpkin wrote:
>>>3) once physical memory is full, file system I/O will only benefit from
>>>reads that incur a minor fault. All other file system operations 
>>>are bound
>>>by the rate you can reclaim pages from physical memory.
>>>
> 
> 
>>No, typically we can reclaim memory very quickly and the operations
>>are bound by the speed of the block device.
> 
> 
> So if all physical memory is full with either pagecache or anonymous memory,
> where are you going to put these operations that are bound by the speed of
> the block device?
> 
> You have to evict pages at the same rate your reading them in or writing to
> the filesystem else you have nowhere to put them. This means that the rate
> you can access the filesystem is governed by the rate you can evict pages
> from memory.
> 

... and the speed of the block device. The minimum of the two actually.
Usually we can reclaim memory *much* faster than the block device can
fill it. Didn't you read what I had said?

> Couple that with the fact that there are many pte's pointing at the same
> physical page (shared page) in many cases where many processes are running
> on the system. Because all of the references to that page must be removed
> before the page can be evicted, there are some absolute limitations in the
> rate that pages can be evicted from memory as the number of processes
> running on the system and the total amount of memory increases.
> 

This is still many orders of magnitude faster than filling the page
from disk, and you typically don't reclaim much of mapped memory anyway.

We are sort of spamming lkml now so let's get this finished up.

If you want to talk about memory management basics, there should
be some more helpful lists.
