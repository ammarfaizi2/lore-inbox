Return-Path: <linux-kernel-owner+w=401wt.eu-S1030312AbXAKMpZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030312AbXAKMpZ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 07:45:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030313AbXAKMpZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 07:45:25 -0500
Received: from dtp.xs4all.nl ([80.126.206.180]:31559 "HELO abra2.bitwizard.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1030312AbXAKMpY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 07:45:24 -0500
Date: Thu, 11 Jan 2007 13:45:21 +0100
From: Erik Mouw <erik@harddisk-recovery.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Aubrey <aubreylee@gmail.com>, Hua Zhong <hzhong@gmail.com>,
       Hugh Dickins <hugh@veritas.com>, linux-kernel@vger.kernel.org,
       hch@infradead.org, kenneth.w.chen@intel.com, akpm@osdl.org,
       mjt@tls.msk.ru
Subject: Re: O_DIRECT question
Message-ID: <20070111124521.GN13675@harddisk-recovery.com>
References: <6d6a94c50701101857v2af1e097xde69e592135e54ae@mail.gmail.com> <Pine.LNX.4.64.0701101902270.3594@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701101902270.3594@woody.osdl.org>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 10, 2007 at 07:05:30PM -0800, Linus Torvalds wrote:
> I should have fought back harder. There really is no valid reason for EVER 
> using O_DIRECT. You need a buffer whatever IO you do, and it might as well 
> be the page cache. There are better ways to control the page cache than 
> play games and think that a page cache isn't necessary.

There is a valid reason: you really don't want to go through the page
cache when a hard drive has bad blocks. The only way to get fast
recovery and correct error reporting to userspace is by using O_DIRECT.

> So don't use O_DIRECT. Use things like madvise() and posix_fadvise() 
> instead. 

Both don't do what I want it to do: only read the sector I request you
to read and certainly do not try to outsmart me by doing some kind of
readahead.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
