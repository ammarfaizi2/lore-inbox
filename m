Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266598AbUG0VGf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266598AbUG0VGf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 17:06:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266609AbUG0VGf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 17:06:35 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:22440 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id S266598AbUG0VGc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 17:06:32 -0400
Message-ID: <4106C3B7.10603@xeon2.local.here>
Date: Tue, 27 Jul 2004 23:05:59 +0200
From: kladit@t-online.de (Klaus Dittrich)
User-Agent: Mozilla Thunderbird 0.7+ (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Klaus Dittrich <kladit@t-online.de>
CC: Jan-Frode Myklebust <janfrode@parallab.uib.no>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: dentry cache leak? Re: rsync out of memory 2.6.8-rc2
References: <20040726150615.GA1119@xeon2.local.here> <20040726123702.222ae654.akpm@osdl.org> <4105633C.3080204@xeon2.local.here> <20040726133846.604cef91.akpm@osdl.org> <41057A16.60801@xeon2.local.here> <20040726221420.GA8789@ii.uib.no> <4106BE6C.1030701@xeon2.local.here>
In-Reply-To: <4106BE6C.1030701@xeon2.local.here>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-ID: GEHDr8ZQoeHX0hmNYSLnVGEfMHOxkdlXaSkFwpXLhgstI3b78mdO6V
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Klaus Dittrich wrote:

> Jan-Frode Myklebust wrote:
>
>> On Mon, Jul 26, 2004 at 11:39:34PM +0200, Klaus Dittrich wrote:
>>  
>>
>>>>> cat /proc/sys/vm/vfs_cache_pressure shows 100.
>>>>>       
>>>>
>>
>> What about trying to increase the vfs_cache_pressure which seemed
>> to solve what to me looks like a similar problem:
>>
>>     http://groups.google.com/groups?hl=en&lr=&ie=UTF-8&safe=off&threadm=2m9Oo-Oo-17%40gated-at.bofh.it&rnum=1&prev=/groups%3Fhl%3Den%26ie%3DUTF-8%26safe%3Doff%26q%3Djan%2Bfrode%2Boom%2Bdsmc%26spell%3D1 
>>
>>
>>     http://groups.google.com/groups?hl=en&lr=&ie=UTF-8&safe=off&threadm=2mdfi-3cC-11%40gated-at.bofh.it&rnum=2&prev=/groups%3Fq%3Djanfrode%2Boom%2Bdsmc%26ie%3DUTF-8%26hl%3Den%26btnG%3DGoogle%2BSearch 
>>
>>
>>
>>  -jf
>>  
>>
> I did a test with a value of 500. echo 500 > 
> /proc/sys/vm/vfs_cache_pressure.
>
> The highest numbers a cat /proc/sys/fs/dentry-state then showed during
> a du -s were
> 780721  750505  45      0       0       0
>
> The system survied. No processes were killed.
>
> With vfs_cache_pressure=100 a cat /proc/sys/fs/dentry-state showed
> numbers of about 1090000 before processes got killed.
>
> Hope that helps to narrow the region to look for what has changed.
>
PS. Two concurrent du -s however "kernel: Out of Memory: Killed process .."
