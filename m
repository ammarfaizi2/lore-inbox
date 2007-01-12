Return-Path: <linux-kernel-owner+w=401wt.eu-S932247AbXALRD3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932247AbXALRD3 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 12:03:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932292AbXALRD3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 12:03:29 -0500
Received: from mx33.mail.ru ([194.67.23.194]:1067 "EHLO mx33.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932247AbXALRD2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 12:03:28 -0500
Message-ID: <45A7BF53.2090006@inbox.ru>
Date: Fri, 12 Jan 2007 20:03:15 +0300
From: Viktor <vvp01@inbox.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20060212 Fedora/1.7.12-5
X-Accept-Language: en-us, ru, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Nick Piggin <nickpiggin@yahoo.com.au>, Aubrey <aubreylee@gmail.com>,
       Hua Zhong <hzhong@gmail.com>, Hugh Dickins <hugh@veritas.com>,
       linux-kernel@vger.kernel.org, hch@infradead.org,
       kenneth.w.chen@intel.com, akpm@osdl.org
Subject: Re: O_DIRECT question
References: <6d6a94c50701101857v2af1e097xde69e592135e54ae@mail.gmail.com>  <Pine.LNX.4.64.0701101902270.3594@woody.osdl.org>  <Pine.LNX.4.64.0701101910110.3594@woody.osdl.org>  <45A5D4A7.7020202@yahoo.com.au>  <Pine.LNX.4.64.0701110746360.3594@woody.osdl.org> <1168534362.7365.3.camel@bip.parateam.prv> <Pine.LNX.4.64.0701110900090.3594@woody.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0701110900090.3594@woody.osdl.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
>>>>O_DIRECT is still crazily racy versus pagecache operations.
>>>
>>>Yes. O_DIRECT is really fundamentally broken. There's just no way to fix 
>>>it sanely.
>>
>>How about aliasing O_DIRECT to POSIX_FADV_NOREUSE (sortof) ?
> 
> 
> That is what I think some users could do. If the main issue with O_DIRECT 
> is the page cache allocations, if we instead had better (read: "any") 
> support for POSIX_FADV_NOREUSE, one class of reasons O_DIRECT usage would 
> just go away.
> 
> See also the patch that Roy Huang posted about another approach to the 
> same problem: just limiting page cache usage explicitly.
> 
> That's not the _only_ issue with O_DIRECT, though. It's one big one, but 
> people like to think that the memory copy makes a difference when you do 
> IO too (I think it's likely pretty debatable in real life, but I'm totally 
> certain you can benchmark it, probably even pretty easily especially if 
> you have fairly studly IO capabilities and a CPU that isn't quite as 
> studly).
> 
> So POSIX_FADV_NOREUSE kind of support is one _part_ of the O_DIRECT 
> picture, and depending on your problems (in this case, the embedded world) 
> it may even be the *biggest* part. But it's not the whole picture.

>From 2.6.19 sources it looks like POSIX_FADV_NOREUSE is no-op there

> 		Linus

