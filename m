Return-Path: <linux-kernel-owner+w=401wt.eu-S932675AbXAKXBj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932675AbXAKXBj (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 18:01:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932817AbXAKXBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 18:01:39 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:48075 "EHLO iradimed.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932675AbXAKXBi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 18:01:38 -0500
Message-ID: <45A6C1D2.9020104@cfl.rr.com>
Date: Thu, 11 Jan 2007 18:01:38 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
MIME-Version: 1.0
To: Michael Tokarev <mjt@tls.msk.ru>
CC: Linus Torvalds <torvalds@osdl.org>, Viktor <vvp01@inbox.ru>,
       Aubrey <aubreylee@gmail.com>, Hua Zhong <hzhong@gmail.com>,
       Hugh Dickins <hugh@veritas.com>, linux-kernel@vger.kernel.org,
       hch@infradead.org, kenneth.w.chen@intel.com, akpm@osdl.org
Subject: Re: O_DIRECT question
References: <6d6a94c50701101857v2af1e097xde69e592135e54ae@mail.gmail.com> <Pine.LNX.4.64.0701101902270.3594@woody.osdl.org> <45A629E9.70502@inbox.ru> <Pine.LNX.4.64.0701110750520.3594@woody.osdl.org> <45A6704A.40205@tls.msk.ru>
In-Reply-To: <45A6704A.40205@tls.msk.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Jan 2007 23:02:07.0742 (UTC) FILETIME=[849AB9E0:01C735D4]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.6.1039-14930.000
X-TM-AS-Result: No--9.181300-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Tokarev wrote:
> Linus Torvalds wrote:
>> On Thu, 11 Jan 2007, Viktor wrote:
>>> OK, madvise() used with mmap'ed file allows to have reads from a file
>>> with zero-copy between kernel/user buffers and don't pollute cache
>>> memory unnecessarily. But how about writes? How is to do zero-copy
>>> writes to a file and don't pollute cache memory without using O_DIRECT?
>>> Do I miss the appropriate interface?
>> mmap()+msync() can do that too.
> 
> It can, somehow... until there's an I/O error.  And *that* is just terrbile.

The other problem besides the inability to handle IO errors is that 
mmap()+msync() is synchronous.  You need to go async to keep the 
pipelines full.

Now if someone wants to implement an aio version of msync and mlock, 
that might do the trick.  At least for MMU systems.  Non MMU systems 
just can't play mmap type games.

