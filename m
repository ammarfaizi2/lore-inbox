Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261647AbUBVCj0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 21:39:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261649AbUBVCj0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 21:39:26 -0500
Received: from mail-10.iinet.net.au ([203.59.3.42]:61629 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261647AbUBVCjR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 21:39:17 -0500
Message-ID: <403814E5.3070106@cyberone.com.au>
Date: Sun, 22 Feb 2004 13:33:09 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Fedyk <mfedyk@matchmail.com>
CC: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: Large slab cache in 2.6.1
References: <4037FCDA.4060501@matchmail.com> <4038014E.5070600@matchmail.com> <20040222012033.GC703@holomorphy.com> <40380DE2.4030702@matchmail.com>
In-Reply-To: <40380DE2.4030702@matchmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Mike Fedyk wrote:

> William Lee Irwin III wrote:
>
>> Mike Fedyk wrote:
>>
>>>> I have 1.5 GB of ram in this system that will be a Linux Terminal 
>>>> Server (but using Debian & VNC).  There's 600MB+ anonymous memory, 
>>>> 600MB+ slab cache, and 100MB page cache.  That's after turning off 
>>>> swap (it was 400MB into swap at the time).
>>>
>>
>>
>> On Sat, Feb 21, 2004 at 05:09:34PM -0800, Mike Fedyk wrote:
>>
>>> Here's my top slab users:
>>> dentry_cache      585455 763395    256   15    1 : tunables  120   
>>> 60 8 : slabdata  50893  50893      3
>>> ext3_inode_cache  686837 688135    512    7    1 : tunables   54   
>>> 27 8 : slabdata  98305  98305      0
>>> buffer_head        34095  78078     48   77    1 : tunables  120   
>>> 60 8 : slabdata   1014   1014      0
>>> vm_area_struct     42103  44602     64   58    1 : tunables  120   
>>> 60 8 : slabdata    769    769      0
>>> pte_chain          20964  43740    128   30    1 : tunables  120   
>>> 60 8 : slabdata   1458   1458      0
>>
>>
>>
>> Similar issue here; I ran out of filp's/whatever shortly after booting.
>
>
> So Nick Piggin's VM patches won't help with this?
>

Probably not.

The main thing they do is to try to be smarter about which active
mapped pages to evict. The slab shrinking balance is pretty well
unchanged.

However there is one path in try_to_free_pages that I've changed
to shrink the slab where it otherwise wouldn't. It is pretty
unlikely that would would be continually running into this path,
but testing is welcome, as always.

Stupid question: you didn't actually say what the problem is...
having 600MB slab cache and 400MB swap may not actually be a
problem provided the swap is not being used and the cache is.

I have an idea it might be worthwhile to try using inactive list
scanning as an input to slab pressure...

Nick

