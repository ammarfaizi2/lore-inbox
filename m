Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268230AbUHFTJk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268230AbUHFTJk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 15:09:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268234AbUHFTJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 15:09:40 -0400
Received: from smtp015.mail.yahoo.com ([216.136.173.59]:30314 "HELO
	smtp015.mail.yahoo.com") by vger.kernel.org with SMTP
	id S268230AbUHFTJi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 15:09:38 -0400
Message-ID: <4113D76E.9060906@yahoo.com.au>
Date: Sat, 07 Aug 2004 05:09:34 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040707 Debian/1.7-5
X-Accept-Language: en
MIME-Version: 1.0
To: Phillip Lougher <phillip@lougher.demon.co.uk>
CC: linuxram@us.ibm.com, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [PATCH] VFS readahead bug in 2.6.8-rc[1-3]
References: <Pine.LNX.4.44.0408052104420.2241-100000@dyn319181.beaverton.ibm.com> <411322E8.4000503@yahoo.com.au> <4113BA65.8050901@lougher.demon.co.uk>
In-Reply-To: <4113BA65.8050901@lougher.demon.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phillip Lougher wrote:
> Nick Piggin wrote:
> 
>> Ram Pai wrote:
>>
>>>
>>> there is a check in __do_page_cache_readahead()  that validates this.
>>> But it is still not guaranteed to work correctly against races.
>>> The filesystem has to handle such out-of-bound requests gracefully.
>>>
>>> However with Nick's fix in do_generic_mapping_read() the filesystem 
>>> is gauranteed to be called with out-of-bound index, if the file size 
>>> is a multiple of 4k. Without the fix, the filesystem might get
>>> called with out-of-bound index only in racy conditions.
>>>
>>
>> How's this?
>>
> 
> It doesn't work.  It correctly handles the case where *ppos is equal
> to i_size on entry to the function (and this does work for files 0, 4k
> and n * 4k in length), but it doesn't handle readahead inside the for
> loop.  The check needs to be in the for loop.
> 
> 

I don't quite follow. What is i_size, *ppos, and desc->count
required for your problem to trigger?
