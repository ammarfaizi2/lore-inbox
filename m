Return-Path: <linux-kernel-owner+w=401wt.eu-S1161137AbXALWtK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161137AbXALWtK (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 17:49:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161143AbXALWtJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 17:49:09 -0500
Received: from smtp.osdl.org ([65.172.181.24]:41790 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161137AbXALWtI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 17:49:08 -0500
Date: Fri, 12 Jan 2007 14:47:48 -0800
From: Andrew Morton <akpm@osdl.org>
To: andersen@codepoet.org
Cc: Linus Torvalds <torvalds@osdl.org>, Michael Tokarev <mjt@tls.msk.ru>,
       Chris Mason <chris.mason@oracle.com>, dean gaudet <dean@arctic.org>,
       Viktor <vvp01@inbox.ru>, Aubrey <aubreylee@gmail.com>,
       Hua Zhong <hzhong@gmail.com>, Hugh Dickins <hugh@veritas.com>,
       linux-kernel@vger.kernel.org, hch@infradead.org,
       kenneth.w.chen@intel.com
Subject: Re: O_DIRECT question
Message-Id: <20070112144748.6c4bb19e.akpm@osdl.org>
In-Reply-To: <20070112223509.GA12512@codepoet.org>
References: <Pine.LNX.4.64.0701110750520.3594@woody.osdl.org>
	<Pine.LNX.4.64.0701112351520.18431@twinlark.arctic.org>
	<Pine.LNX.4.64.0701120955440.3594@woody.osdl.org>
	<20070112202316.GA28400@think.oraclecorp.com>
	<45A7F396.4080600@tls.msk.ru>
	<45A7F4F2.2080903@tls.msk.ru>
	<45A7F7A7.1080108@tls.msk.ru>
	<Pine.LNX.4.64.0701121611370.3470@woody.osdl.org>
	<45A8038F.2040609@tls.msk.ru>
	<Pine.LNX.4.64.0701121705440.3470@woody.osdl.org>
	<20070112223509.GA12512@codepoet.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jan 2007 15:35:09 -0700
Erik Andersen <andersen@codepoet.org> wrote:

> On Fri Jan 12, 2007 at 05:09:09PM -0500, Linus Torvalds wrote:
> > I suspect a lot of people actually have other reasons to avoid caches. 
> > 
> > For example, the reason to do O_DIRECT may well not be that you want to 
> > avoid caching per se, but simply because you want to limit page cache 
> > activity. In which case O_DIRECT "works", but it's really the wrong thing 
> > to do. We could export other ways to do what people ACTUALLY want, that 
> > doesn't have the downsides.
> 
> I was rather fond of the old O_STREAMING patch by Robert Love,

That was an akpmpatch whcih I did for the Digeo kernel.  Robert picked it
up to dehackify it and get it into mainline, but we ended up deciding that
posix_fadvise() was the way to go because it's standards-based.

It's a bit more work in the app to use posix_fadvise() well.  But the
results will be better.  The app should also use sync_file_range()
intelligently to control its pagecache use.

The problem with all of these things is that the application needs to be
changed, and people often cannot do that.  If we want a general way of
stopping particular apps from swamping pagecache then it'd really need to
be an externally-imposed thing - probably via additional accounting and a
new rlimit.

