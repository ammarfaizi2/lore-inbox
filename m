Return-Path: <linux-kernel-owner+w=401wt.eu-S1751356AbXAKSlg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751356AbXAKSlg (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 13:41:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbXAKSlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 13:41:36 -0500
Received: from pat.uio.no ([129.240.10.15]:58226 "EHLO pat.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751356AbXAKSlf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 13:41:35 -0500
Subject: Re: O_DIRECT question
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Xavier Bestel <xavier.bestel@free.fr>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Aubrey <aubreylee@gmail.com>,
       Hua Zhong <hzhong@gmail.com>, Hugh Dickins <hugh@veritas.com>,
       linux-kernel@vger.kernel.org, hch@infradead.org,
       kenneth.w.chen@intel.com, akpm@osdl.org, mjt@tls.msk.ru
In-Reply-To: <Pine.LNX.4.64.0701110900090.3594@woody.osdl.org>
References: <6d6a94c50701101857v2af1e097xde69e592135e54ae@mail.gmail.com>
	 <Pine.LNX.4.64.0701101902270.3594@woody.osdl.org>
	 <Pine.LNX.4.64.0701101910110.3594@woody.osdl.org>
	 <45A5D4A7.7020202@yahoo.com.au>
	 <Pine.LNX.4.64.0701110746360.3594@woody.osdl.org>
	 <1168534362.7365.3.camel@bip.parateam.prv>
	 <Pine.LNX.4.64.0701110900090.3594@woody.osdl.org>
Content-Type: text/plain
Date: Thu, 11 Jan 2007 13:41:15 -0500
Message-Id: <1168540875.6170.46.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-5.0, required=12.0, autolearn=disabled, UIO_MAIL_IS_INTERNAL=-5)
X-UiO-Scanned: CC5960E53CC0D720CF450FC87794508036D0B213
X-UiO-SPAM-Test: 141.211.133.154 spam_score -49 maxlevel 200 minaction 2 bait 0 blacklist 0 greylist 0 ratelimit 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2007-01-11 at 09:04 -0800, Linus Torvalds wrote:
> That is what I think some users could do. If the main issue with O_DIRECT 
> is the page cache allocations, if we instead had better (read: "any") 
> support for POSIX_FADV_NOREUSE, one class of reasons O_DIRECT usage would 
> just go away.

For NFS, the main feature of interest when it comes to O_DIRECT is
strictly uncached I/O. Replacing it with POSIX_FADV_NOREUSE won't help
because it can't guarantee that the page will be thrown out of the page
cache before some second process tries to read it. That is particularly
true if some dopey third party process has mmapped the file.

Trond

