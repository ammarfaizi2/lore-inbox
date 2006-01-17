Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932186AbWAQSZl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186AbWAQSZl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 13:25:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932324AbWAQSZl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 13:25:41 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:21653 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932186AbWAQSZk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 13:25:40 -0500
To: Christoph Hellwig <hch@infradead.org>
Cc: Nicholas Miell <nmiell@comcast.net>,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>,
       Ulrich Drepper <drepper@redhat.com>, Andrea Arcangeli <andrea@suse.de>,
       Badari Pulavarty <pbadari@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, hugh@veritas.com, dvhltc@us.ibm.com,
       linux-mm@kvack.org, blaisorblade@yahoo.it, jdike@addtoit.com
Subject: Re: differences between MADV_FREE and MADV_DONTNEED
References: <20051111174309.5d544de4.akpm@osdl.org>
	<43757263.2030401@us.ibm.com> <20060116130649.GE15897@opteron.random>
	<43CBC37F.60002@FreeBSD.org> <20060116162808.GG15897@opteron.random>
	<43CBD1C4.5020002@FreeBSD.org> <20060116172449.GL15897@opteron.random>
	<m1r777rgq4.fsf@ebiederm.dsl.xmission.com>
	<43CC3922.2070205@FreeBSD.org> <1137459847.2842.6.camel@entropy>
	<20060117124315.GA7754@infradead.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 17 Jan 2006 11:23:53 -0700
In-Reply-To: <20060117124315.GA7754@infradead.org> (Christoph Hellwig's
 message of "Tue, 17 Jan 2006 12:43:15 +0000")
Message-ID: <m1ek36r9vq.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> writes:

> On Mon, Jan 16, 2006 at 05:04:07PM -0800, Nicholas Miell wrote:
>> On Mon, 2006-01-16 at 16:24 -0800, Suleiman Souhlal wrote:
>> > Eric W. Biederman wrote:
>> > > As I recall the logic with DONTNEED was to mark the mapping of
>> > > the page clean so the page didn't need to be swapped out, it could
>> > > just be dropped.
>> > > 
>> > > That is why they anonymous and the file backed cases differ.
>> > > 
>> > > Part of the point is to avoid the case of swapping the pages out if
>> > > the application doesn't care what is on them anymore.
>> > 
>> > Well, imho, MADV_DONTNEED should mean "I won't need this anytime soon", 
>> > and MADV_FREE "I will never need this again".
>> > 
>> 
>> POSIX doesn't have a madvise(), but it does have a posix_madvise(), with
>> flags defined as follows:
>> 
>> POSIX_MADV_NORMAL
>>    Specifies that the application has no advice to give on its behavior
>> with respect to the specified range. It is the default characteristic if
>> no advice is given for a range of memory.
>> POSIX_MADV_SEQUENTIAL
>>    Specifies that the application expects to access the specified range
>> sequentially from lower addresses to higher addresses.
>> POSIX_MADV_RANDOM
>>    Specifies that the application expects to access the specified range
>> in a random order.
>> POSIX_MADV_WILLNEED
>>    Specifies that the application expects to access the specified range
>> in the near future.
>> POSIX_MADV_DONTNEED
>>    Specifies that the application expects that it will not access the
>> specified range in the near future.
>> 
>> Note that glibc forwards posix_madvise() directly to madvise(2), which
>> means that right now, POSIX conformant apps which use
>> posix_madvise(addr, len, POSIX_MADV_DONTNEED) are silently corrupting
>> data on Linux systems.
>
> Does our MAD_DONTNEED numerical value match glibc's POSIX_MADV_DONTNEED?
>
> In either case I'd say we should backout this patch for now.  We should
> implement a real MADV_DONTNEED and rename the current one to MADV_FREE,
> but that's 2.6.17 material.

We definitely need to check this.  I am fairly certain  I have seen this conversation
before.

Eric


