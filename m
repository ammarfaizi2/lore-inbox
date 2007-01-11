Return-Path: <linux-kernel-owner+w=401wt.eu-S1030298AbXAKMO2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030298AbXAKMO2 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 07:14:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030299AbXAKMO1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 07:14:27 -0500
Received: from mx28.mail.ru ([194.67.23.67]:1396 "EHLO mx28.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030298AbXAKMO1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 07:14:27 -0500
Message-ID: <45A629E9.70502@inbox.ru>
Date: Thu, 11 Jan 2007 15:13:29 +0300
From: Viktor <vvp01@inbox.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20060212 Fedora/1.7.12-5
X-Accept-Language: en-us, ru, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Aubrey <aubreylee@gmail.com>, Hua Zhong <hzhong@gmail.com>,
       Hugh Dickins <hugh@veritas.com>, linux-kernel@vger.kernel.org,
       hch@infradead.org, kenneth.w.chen@intel.com, akpm@osdl.org,
       mjt@tls.msk.ru
Subject: Re: O_DIRECT question
References: <6d6a94c50701101857v2af1e097xde69e592135e54ae@mail.gmail.com> <Pine.LNX.4.64.0701101902270.3594@woody.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0701101902270.3594@woody.osdl.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Thu, 11 Jan 2007, Aubrey wrote:
> 
>>Now, my question is, is there a existing way to mount a filesystem
>>with O_DIRECT flag? so that I don't need to change anything in my
>>system. If there is no option so far, What is the right way to achieve
>>my purpose?
> 
> 
> The right way to do it is to just not use O_DIRECT. 
> 
> The whole notion of "direct IO" is totally braindamaged. Just say no.
> 
> 	This is your brain: O
> 	This is your brain on O_DIRECT: .
> 
> 	Any questions?
> 
> I should have fought back harder. There really is no valid reason for EVER 
> using O_DIRECT. You need a buffer whatever IO you do, and it might as well 
> be the page cache. There are better ways to control the page cache than 
> play games and think that a page cache isn't necessary.
> 
> So don't use O_DIRECT. Use things like madvise() and posix_fadvise() 
> instead. 

OK, madvise() used with mmap'ed file allows to have reads from a file
with zero-copy between kernel/user buffers and don't pollute cache
memory unnecessarily. But how about writes? How is to do zero-copy
writes to a file and don't pollute cache memory without using O_DIRECT?
Do I miss the appropriate interface?

> 		Linus
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

