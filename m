Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263809AbTDDQPf (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 11:15:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263803AbTDDQHc (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 11:07:32 -0500
Received: from holomorphy.com ([66.224.33.161]:48017 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263802AbTDDQDy (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 11:03:54 -0500
Date: Fri, 4 Apr 2003 08:14:57 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@digeo.com>, Dave McCracken <dmccr@us.ibm.com>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: objrmap and vmtruncate
Message-ID: <20030404161457.GE993@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@digeo.com>,
	Dave McCracken <dmccr@us.ibm.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <Pine.LNX.4.44.0304041453160.1708-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0304041453160.1708-100000@localhost.localdomain>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 04, 2003 at 03:34:48PM +0100, Hugh Dickins wrote:
> I see you're going for locking the page around page_convert_anon,
> to guard page->mapping against truncation.  Nice thought,
> but the words "tip" and "iceberg" spring to mind.
> Truncating a sys_remap_file_pages file?  You're the first to
> begin to consider such an absurd possibility: vmtruncate_list
> still believes vm_pgoff tells it what needs to be done.
> I propose that we don't change vmtruncate_list, zap_page_range, ...
> at all for this: let it unmap inappropriate pages, even from a
> VM_LOCKED vma, that's just a price userspace pays for the
> privilege of truncating a sys_remap_file_pages file.

Hmm, aren't the file offset calculations wrong for sys_remap_file_pages()
even before objrmap?


-- wli
