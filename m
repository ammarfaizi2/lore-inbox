Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265696AbUEZNbu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265696AbUEZNbu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 09:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265680AbUEZNbd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 09:31:33 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:20999 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S265649AbUEZNZP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 09:25:15 -0400
Message-ID: <40B49B3F.9090805@aitel.hist.no>
Date: Wed, 26 May 2004 15:27:27 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040509)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Buddy Lumpkin <b.lumpkin@comcast.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: why swap at all?
References: <S265582AbUEZNAL/20040526130011Z+1843@vger.kernel.org>
In-Reply-To: <S265582AbUEZNAL/20040526130011Z+1843@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Buddy Lumpkin wrote:

>>>Couple that with the fact that there are many pte's pointing at the same
>>>physical page (shared page) in many cases where many processes 
>>>
>>>are running
>>>on the system. Because all of the references to that page must be removed
>>>before the page can be evicted, there are some absolute 
>>>limitations in the
>>>rate that pages can be evicted from memory as the number of processes
>>>running on the system and the total amount of memory increases.
>>>
>>>      
>>>
>
>  
>
>>This is still many orders of magnitude faster than filling the page
>>from disk, and you typically don't reclaim much of mapped memory anyway.
>>    
>>
>
>This discussion went broke-minded again. Your still picturing that single
>IDE hard drive in your workstation and im talking about big iron, large
>databases, etc.. where the total amount of aggregate disk I/O is completely
>limited by the rate you can evict pages from the pagecache.
>  
>
The eviction speed should not be a limitation, unless the machine is
ill-configured. Some pages aren't dirty, and can be dropped instantly.
That is way faster than any storage solution.

Other pages have to be written out (to swap, or to some file because
it is a pending write.)  This is not a problem, because io out
is as fast as io in.  If you have big iron with a superfast array - sure,
your io comes in at tremendous speed.  But swap and other writes
go out at the same tremendous speed too.  So no problem.

Now if you have a big-iron machine with filesystems on a fast array
and swap on a single slow disk then you're in trouble.  But that
is a bad setup, not a kernel problem.

Helge Hafting
