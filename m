Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261303AbUKJHLE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261303AbUKJHLE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 02:11:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261249AbUKJHLE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 02:11:04 -0500
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:3407 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261303AbUKJHKe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 02:10:34 -0500
Message-ID: <4191BEE6.8000900@yahoo.com.au>
Date: Wed, 10 Nov 2004 18:10:30 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
CC: Robert Love <rml@novell.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] [PATCH] kmem_alloc (generic wrapper for kmalloc and	vmalloc)
References: <4191A4E2.7040502@gmx.net> <1100066597.18601.124.camel@localhost> <4191B5D8.3090700@gmx.net>
In-Reply-To: <4191B5D8.3090700@gmx.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Carl-Daniel Hailfinger wrote:
> Robert Love schrieb:
> 
>>On Wed, 2004-11-10 at 06:19 +0100, Carl-Daniel Hailfinger wrote:
>>
>>
>>>Hi,
>>>
>>>it seems there is a bunch of drivers which want to allocate memory as
>>>efficiently as possible in a wide range of allocation sizes. XFS and
>>>NTFS seem to be examples. Implement a generic wrapper to reduce code
>>>duplication.
>>>Functions have the my_ prefixes to avoid name clash with XFS.
>>
>>
>>No, no, no.  A good patch would be fixing places where you see this.
>>
>>Code needs to conscientiously decide to use vmalloc over kmalloc.  The
>>behavior is different and the choice needs to be explicit.
> 
> 
> Yes, but what do you suggest for the following problem:
> alloc(max_loop*sizeof(struct loop_device))
> 
> where sizeof(struct loop_device)==304 and 1<=max_loop<=16384
> 
> For the smallest allocation (304 bytes) vmalloc is clearly wasteful
> and for the largest allocation (~ 5 MBytes) kmalloc doesn't work.
> 

Can't you change it to use a hash or something?

Even a linked list if it is not performance critical.
