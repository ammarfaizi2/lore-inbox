Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268181AbUHFROR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268181AbUHFROR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 13:14:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268186AbUHFRMY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 13:12:24 -0400
Received: from anchor-post-30.mail.demon.net ([194.217.242.88]:42756 "EHLO
	anchor-post-30.mail.demon.net") by vger.kernel.org with ESMTP
	id S268195AbUHFRGq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 13:06:46 -0400
Message-ID: <4113BA65.8050901@lougher.demon.co.uk>
Date: Fri, 06 Aug 2004 18:05:41 +0100
From: Phillip Lougher <phillip@lougher.demon.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-GB; rv:1.2.1) Gecko/20030228
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: linuxram@us.ibm.com, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [PATCH] VFS readahead bug in 2.6.8-rc[1-3]
References: <Pine.LNX.4.44.0408052104420.2241-100000@dyn319181.beaverton.ibm.com> <411322E8.4000503@yahoo.com.au>
In-Reply-To: <411322E8.4000503@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Ram Pai wrote:
> 
>>
>> there is a check in __do_page_cache_readahead()  that validates this.
>> But it is still not guaranteed to work correctly against races.
>> The filesystem has to handle such out-of-bound requests gracefully.
>>
>> However with Nick's fix in do_generic_mapping_read() the filesystem is 
>> gauranteed to be called with out-of-bound index, if the file size is a 
>> multiple of 4k. Without the fix, the filesystem might get
>> called with out-of-bound index only in racy conditions.
>>
> 
> How's this?
> 

It doesn't work.  It correctly handles the case where *ppos is equal
to i_size on entry to the function (and this does work for files 0, 4k
and n * 4k in length), but it doesn't handle readahead inside the for
loop.  The check needs to be in the for loop.

