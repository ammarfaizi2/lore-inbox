Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261166AbUJYTek@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261166AbUJYTek (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 15:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261266AbUJYTcr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 15:32:47 -0400
Received: from holomorphy.com ([207.189.100.168]:62429 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261259AbUJYTad (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 15:30:33 -0400
Date: Mon, 25 Oct 2004 12:30:16 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@novell.com>,
       Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] statm: shared = rss - anon_rss
Message-ID: <20041025193016.GX17038@holomorphy.com>
References: <Pine.LNX.4.44.0410241644000.12023-100000@localhost.localdomain> <Pine.LNX.4.44.0410241647080.12023-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0410241647080.12023-100000@localhost.localdomain>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 24, 2004 at 04:49:48PM +0100, Hugh Dickins wrote:
> The third "shared" field of /proc/$pid/statm in 2.4 was a count of pages
> in the mm whose page_count is more than 1 (oddly, including pages shared
> just with swapcache).  That's too costly to calculate each time, so 2.6
> changed it to the total file-backed extent.  But Andrea knows apps and
> users surprised when (rss - shared) goes negative: we need to provide
> an rss-like statistic, close to the 2.4 interpretation.
> Something that's quick and easy to maintain accurately is mm->anon_rss,
> the count of anonymous pages in the mm.  Then shared = rss - anon_rss
> gives a pretty good and meaningful approximation to 2.4's intention:
> wli confirms that this will be useful to Oracle too.
> Where to show it?  I think it's best to treat this as a bugfix and show
> it in the third field of /proc/$pid/statm, after resident, as before -
> there's no evidence that the total file-backed extent was found useful.
> Albert would like other fields to revert to page counts, but that's a
> lot harder: if mprotect can change the category of a page, then it can't
> be accounted as simply as this.  Only go that route if real need shown.

The group maintaining the tools relying upon the properties of the
shared field of statm at Oracle has gone beyond code inspection of the
patches, and as of today has carried out runtime testing of your
patches and verified that it resolves the issue to their full
satisfaction during runtime operation of the tools.

-- wli
