Return-Path: <linux-kernel-owner+w=401wt.eu-S1161120AbXALWfN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161120AbXALWfN (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 17:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161136AbXALWfM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 17:35:12 -0500
Received: from codepoet.org ([166.70.99.138]:33319 "EHLO codepoet.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161120AbXALWfK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 17:35:10 -0500
Date: Fri, 12 Jan 2007 15:35:09 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Michael Tokarev <mjt@tls.msk.ru>, Chris Mason <chris.mason@oracle.com>,
       dean gaudet <dean@arctic.org>, Viktor <vvp01@inbox.ru>,
       Aubrey <aubreylee@gmail.com>, Hua Zhong <hzhong@gmail.com>,
       Hugh Dickins <hugh@veritas.com>, linux-kernel@vger.kernel.org,
       hch@infradead.org, kenneth.w.chen@intel.com, akpm@osdl.org
Subject: Re: O_DIRECT question
Message-ID: <20070112223509.GA12512@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: andersen@codepoet.org,
	Linus Torvalds <torvalds@osdl.org>, Michael Tokarev <mjt@tls.msk.ru>,
	Chris Mason <chris.mason@oracle.com>, dean gaudet <dean@arctic.org>,
	Viktor <vvp01@inbox.ru>, Aubrey <aubreylee@gmail.com>,
	Hua Zhong <hzhong@gmail.com>, Hugh Dickins <hugh@veritas.com>,
	linux-kernel@vger.kernel.org, hch@infradead.org,
	kenneth.w.chen@intel.com, akpm@osdl.org
References: <Pine.LNX.4.64.0701110750520.3594@woody.osdl.org> <Pine.LNX.4.64.0701112351520.18431@twinlark.arctic.org> <Pine.LNX.4.64.0701120955440.3594@woody.osdl.org> <20070112202316.GA28400@think.oraclecorp.com> <45A7F396.4080600@tls.msk.ru> <45A7F4F2.2080903@tls.msk.ru> <45A7F7A7.1080108@tls.msk.ru> <Pine.LNX.4.64.0701121611370.3470@woody.osdl.org> <45A8038F.2040609@tls.msk.ru> <Pine.LNX.4.64.0701121705440.3470@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701121705440.3470@woody.osdl.org>
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Jan 12, 2007 at 05:09:09PM -0500, Linus Torvalds wrote:
> I suspect a lot of people actually have other reasons to avoid caches. 
> 
> For example, the reason to do O_DIRECT may well not be that you want to 
> avoid caching per se, but simply because you want to limit page cache 
> activity. In which case O_DIRECT "works", but it's really the wrong thing 
> to do. We could export other ways to do what people ACTUALLY want, that 
> doesn't have the downsides.

I was rather fond of the old O_STREAMING patch by Robert Love,
which added an open() flag telling the kernel to not keep data
from the current file in cache by dropping pages from the
pagecache before the current index.  O_STREAMING was very nice
for when you know you want to read a large file sequentially
without polluting the rest of the cache with GB of data that you
plan on only read once and discard.  It worked nicely at doing
what many people want to use O_DIRECT for.

Using O_STREAMING you would get normal read/write semantics since
you still had the pagecache caching your data, but only the
not-yet-written write-behind data and the not-yet-read read-ahead
data.  With the additional hint the kernel should drop free-able
pages from the pagecache behind the current position, because we
know we will never want them again.  I thought that was a very
nice way of handling things.

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
