Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262095AbVBASPs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262095AbVBASPs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 13:15:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262087AbVBASPr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 13:15:47 -0500
Received: from alog0389.analogic.com ([208.224.222.165]:3456 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262095AbVBASMY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 13:12:24 -0500
Date: Tue, 1 Feb 2005 13:11:36 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Andreas Gruenbacher <agruen@suse.de>
cc: Paulo Marques <pmarques@grupopie.com>, Matt Mackall <mpm@selenic.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] lib/sort: Heapsort implementation of sort()
In-Reply-To: <1107280438.12050.118.camel@winden.suse.de>
Message-ID: <Pine.LNX.4.61.0502011303350.7089@chaos.analogic.com>
References: <2.416337461@selenic.com>  <1107191783.21706.124.camel@winden.suse.de>
 <41FE6B42.7010807@grupopie.com> <1107280438.12050.118.camel@winden.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Feb 2005, Andreas Gruenbacher wrote:

> On Mon, 2005-01-31 at 18:30, Paulo Marques wrote:
>> Andreas Gruenbacher wrote:
>>> [...]
>>>
>>> static inline void swap(void *a, void *b, int size)
>>> {
>>>         if (size % sizeof(long)) {
>>>                 char t;
>>>                 do {
>>>                         t = *(char *)a;
>>>                         *(char *)a++ = *(char *)b;
>>>                         *(char *)b++ = t;
>>>                 } while (--size > 0);
>>>         } else {
>>>                 long t;
>>>                 do {
>>>                         t = *(long *)a;
>>>                         *(long *)a = *(long *)b;
>>>                         *(long *)b = t;
>>>                         size -= sizeof(long);
>>>                 } while (size > sizeof(long));
>>
>> You forgot to increment a and b, and this should be "while (size);", no?
>
> Correct, yes.
>
>> Or better yet,
>>
>> static inline void swap(void *a, void *b, int size)
>> {
>> 	long tl;
>>          char t;
>>
>> 	while (size >= sizeof(long)) {
>>                  tl = *(long *)a;
>>                  *(long *)a = *(long *)b;
>>                  *(long *)b = tl;
>> 		a += sizeof(long);
>> 		b += sizeof(long);
>>                  size -= sizeof(long);
>> 	}
>> 	while (size) {
>>                  t = *(char *)a;
>>                  *(char *)a++ = *(char *)b;
>>                  *(char *)b++ = t;
>> 		size--;
>>          }
>> }
>>
>> This works better if the size is not a multiple of sizeof(long), but is
>> bigger than a long.
>
> In case size is not a multiple of sizeof(long) here, you'll have
> unaligned memory accesses most of the time anyway, so it probably
> doesn't really matter.
>
> Thanks,
> -- 
> Andreas Gruenbacher <agruen@suse.de>
> SUSE Labs, SUSE LINUX GMBH

This uses an GNU-ISM where you are doing pointer arithmetic
on a pointer-to-void. NotGood(tm) this is an example of
where there is absolutely no rationale whatsoever for
writing such code.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
