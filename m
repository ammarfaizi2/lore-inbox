Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263511AbTEMVxt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 17:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263516AbTEMVxt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 17:53:49 -0400
Received: from holomorphy.com ([66.224.33.161]:19901 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263511AbTEMVxr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 17:53:47 -0400
Date: Tue, 13 May 2003 15:06:26 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, akpm@digeo.com,
       mjbligh@us.ibm.com
Subject: Re: [RFC][PATCH] Fix for latent bug in vmtruncate()
Message-ID: <20030513220626.GA29926@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Paul E. McKenney" <paulmck@us.ibm.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, akpm@digeo.com,
	mjbligh@us.ibm.com
References: <20030513135807.E2929@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030513135807.E2929@us.ibm.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 13, 2003 at 01:58:07PM -0700, Paul E. McKenney wrote:
> The vmtruncate() function shifts down by PAGE_CACHE_SHIFT, then
> calls vmtruncate_list(), which deals in terms of PAGE_SHIFT
> instead.  Currently, no harm done, since PAGE_CACHE_SHIFT and
> PAGE_SHIFT are identical.  Some day they might not be, hence
> this patch.
> I also took the liberty of modifying a hand-coded "if" that
> seems to optimize for files that are not mapped to instead
> use unlikely().

pgoff describes a file offset in the same units used to map files
with (the size of an area covered by a PTE), which is PAGE_SIZE (in
mainline; elsewhere it's called MMUPAGE_SIZE and I had to fix this
already for my tree). When they differ this would lose the offset into
the PAGE_CACHE_SIZE-sized file page; hence, well-spotted.


-- wli
