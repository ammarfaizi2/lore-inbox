Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267201AbUG1PJo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267201AbUG1PJo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 11:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267211AbUG1PJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 11:09:44 -0400
Received: from mailout06.sul.t-online.com ([194.25.134.19]:63661 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id S267201AbUG1PJj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 11:09:39 -0400
Message-ID: <4107C109.2070600@xeon2.local.here>
Date: Wed, 28 Jul 2004 17:06:49 +0200
From: kladit@t-online.de (Klaus Dittrich)
User-Agent: Mozilla Thunderbird 0.7+ (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Klaus Dittrich <kladit@t-online.de>,
       Jan-Frode Myklebust <janfrode@parallab.uib.no>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: dentry cache leak? Re: rsync out of memory 2.6.8-rc2
References: <20040726150615.GA1119@xeon2.local.here> <20040726123702.222ae654.akpm@osdl.org> <4105633C.3080204@xeon2.local.here> <20040726133846.604cef91.akpm@osdl.org> <41057A16.60801@xeon2.local.here> <20040726221420.GA8789@ii.uib.no> <4106BE6C.1030701@xeon2.local.here> <4106C3B7.10603@xeon2.local.here> <4106FF9F.5060609@yahoo.com.au>
In-Reply-To: <4106FF9F.5060609@yahoo.com.au>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-ID: TnNDOMZcZemjJ7saxONCpehfHOhrXWP8f1mcrxpHvoq0eCjcylCW4G
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:

> Klaus Dittrich wrote:
>
>> Klaus Dittrich wrote:
>
>
>>> I did a test with a value of 500. echo 500 > 
>>> /proc/sys/vm/vfs_cache_pressure.
>>>
>>> The highest numbers a cat /proc/sys/fs/dentry-state then showed during
>>> a du -s were
>>> 780721  750505  45      0       0       0
>>>
>>> The system survied. No processes were killed.
>>>
>>> With vfs_cache_pressure=100 a cat /proc/sys/fs/dentry-state showed
>>> numbers of about 1090000 before processes got killed.
>>>
>>> Hope that helps to narrow the region to look for what has changed.
>>>
>> PS. Two concurrent du -s however "kernel: Out of Memory: Killed 
>> process .." *
>> *
>
>
> Your vfs_cache_pressure probably wants to be higher than 500. Make it 
> 10000.

*No problems when using 10000.
But I think of this as workaround only.

I have read the "Scaling dcache with RCU" article from linuxjournal.com
to get some insight how things should work. Pretty complicated.

I added some printk statements in dcache.c to see what functions
actually get called to shink a dcache during a du -s.
The only one I found is prune_dcache().
Which events should trigger the use of d_invalidate() ?


**
*
