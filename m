Return-Path: <linux-kernel-owner+w=401wt.eu-S1750906AbXAKRFV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750906AbXAKRFV (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 12:05:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750919AbXAKRFV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 12:05:21 -0500
Received: from smtp.osdl.org ([65.172.181.24]:47103 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750906AbXAKRFU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 12:05:20 -0500
Date: Thu, 11 Jan 2007 09:04:23 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Xavier Bestel <xavier.bestel@free.fr>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, Aubrey <aubreylee@gmail.com>,
       Hua Zhong <hzhong@gmail.com>, Hugh Dickins <hugh@veritas.com>,
       linux-kernel@vger.kernel.org, hch@infradead.org,
       kenneth.w.chen@intel.com, akpm@osdl.org, mjt@tls.msk.ru
Subject: Re: O_DIRECT question
In-Reply-To: <1168534362.7365.3.camel@bip.parateam.prv>
Message-ID: <Pine.LNX.4.64.0701110900090.3594@woody.osdl.org>
References: <6d6a94c50701101857v2af1e097xde69e592135e54ae@mail.gmail.com> 
 <Pine.LNX.4.64.0701101902270.3594@woody.osdl.org> 
 <Pine.LNX.4.64.0701101910110.3594@woody.osdl.org>  <45A5D4A7.7020202@yahoo.com.au>
  <Pine.LNX.4.64.0701110746360.3594@woody.osdl.org> <1168534362.7365.3.camel@bip.parateam.prv>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463790079-500503371-1168534899=:3594"
Content-ID: <Pine.LNX.4.64.0701110901480.3594@woody.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463790079-500503371-1168534899=:3594
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-ID: <Pine.LNX.4.64.0701110901481.3594@woody.osdl.org>



On Thu, 11 Jan 2007, Xavier Bestel wrote:

> Le jeudi 11 janvier 2007 à 07:50 -0800, Linus Torvalds a écrit :
> > > O_DIRECT is still crazily racy versus pagecache operations.
> > 
> > Yes. O_DIRECT is really fundamentally broken. There's just no way to fix 
> > it sanely.
> 
> How about aliasing O_DIRECT to POSIX_FADV_NOREUSE (sortof) ?

That is what I think some users could do. If the main issue with O_DIRECT 
is the page cache allocations, if we instead had better (read: "any") 
support for POSIX_FADV_NOREUSE, one class of reasons O_DIRECT usage would 
just go away.

See also the patch that Roy Huang posted about another approach to the 
same problem: just limiting page cache usage explicitly.

That's not the _only_ issue with O_DIRECT, though. It's one big one, but 
people like to think that the memory copy makes a difference when you do 
IO too (I think it's likely pretty debatable in real life, but I'm totally 
certain you can benchmark it, probably even pretty easily especially if 
you have fairly studly IO capabilities and a CPU that isn't quite as 
studly).

So POSIX_FADV_NOREUSE kind of support is one _part_ of the O_DIRECT 
picture, and depending on your problems (in this case, the embedded world) 
it may even be the *biggest* part. But it's not the whole picture.

		Linus
---1463790079-500503371-1168534899=:3594--
