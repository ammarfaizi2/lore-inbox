Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261320AbUBTXXk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 18:23:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261414AbUBTXXk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 18:23:40 -0500
Received: from bi01p1.co.us.ibm.com ([32.97.110.142]:39365 "EHLO linux.local")
	by vger.kernel.org with ESMTP id S261320AbUBTXXj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 18:23:39 -0500
Date: Fri, 20 Feb 2004 08:17:38 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Daniel Phillips <phillips@arcor.de>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>
Subject: Re: Non-GPL export of invalidate_mmap_range
Message-ID: <20040220161738.GF1269@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20040216190927.GA2969@us.ibm.com> <200402201535.47848.phillips@arcor.de> <20040220140116.GD1269@us.ibm.com> <200402201800.12077.phillips@arcor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402201800.12077.phillips@arcor.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 20, 2004 at 06:00:32PM -0500, Daniel Phillips wrote:
> On Friday 20 February 2004 09:01, Paul E. McKenney wrote:
> > On Fri, Feb 20, 2004 at 03:37:26PM -0500, Daniel Phillips wrote:
> > > Actually, I erred there in that invalidate_mmap_range should not export
> > > the flag, because it never makes sense to pass in non-zero from a DFS.
> >
> > Doesn't vmtruncate() want to pass non-zero "all" in to
> > invalidate_mmap_range() in order to maintain compatibility with existing
> > Linux semantics?
> 
> That comes from inside.  The DFS's truncate interface should just be 
> vmtruncate.  If I missed something, please shout.

Agreed, the DFS's truncate interface should be vmtruncate().

Your earlier patch has a call to invalidate_mmap_range() within
vmtruncate(), which passes "1" to the last arg, so as to get
rid of all mappings to the truncated portion of the file.
So either invalidate_mmap_range() needs to keep the fourth arg
or needs to be a wrapper for an underlying function that
vmtruncate() can call, or some such.

The latter may be what you intended to do.

						Thanx, Paul
