Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263338AbUCNJHt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 04:07:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263341AbUCNJHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 04:07:48 -0500
Received: from holomorphy.com ([207.189.100.168]:62988 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263338AbUCNJHq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 04:07:46 -0500
Date: Sun, 14 Mar 2004 01:07:24 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Ray Bryant <raybry@sgi.com>, ak@suse.de, lse-tech@lists.sourceforge.net,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: Hugetlbpages in very large memory machines.......
Message-ID: <20040314090724.GR655@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, Ray Bryant <raybry@sgi.com>,
	ak@suse.de, lse-tech@lists.sourceforge.net,
	linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
References: <40528383.10305@sgi.com> <20040313034840.GF4638@wotan.suse.de> <20040313184547.6e127b51.akpm@osdl.org> <40541A09.3050600@sgi.com> <20040314005737.7f57b8ad.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040314005737.7f57b8ad.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 14, 2004 at 12:57:37AM -0800, Andrew Morton wrote:
> Well that's just a dumb implementation.  hugetlb_prefault() doesn't need
> page_table_lock while it is zeroing the page: just drop it, test for
> -EEXIST returned from add_to_page_cache().
> In fact we need to do that anyway: the current code is buggy if some other
> process with a different mm gets in there and instantiates the page in the
> pagecache before this process does: hugetlb_prefault() will return -EEXIST
> instead of simply accepting the race and using the page which someone else
> put there.

Don't blame me. I didn't write the expand-on-mmap() code.


-- wli
