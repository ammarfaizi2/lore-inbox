Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751331AbVJQUZb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331AbVJQUZb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 16:25:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751336AbVJQUZb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 16:25:31 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:53381 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751331AbVJQUZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 16:25:30 -0400
Date: Mon, 17 Oct 2005 15:25:01 -0500
From: Robin Holt <holt@sgi.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Robin Holt <holt@sgi.com>, Andrew Morton <akpm@osdl.org>,
       Dave Hansen <haveblue@us.ibm.com>, Greg KH <greg@kroah.com>,
       ia64 list <linux-ia64@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hch@infradead.org, jgarzik@pobox.com,
       William Lee Irwin III <wli@holomorphy.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Carsten Otte <cotte@de.ibm.com>,
       Jack Steiner <steiner@americas.sgi.com>
Subject: Re: [Patch 2/3] Export get_one_pte_map.
Message-ID: <20051017202501.GB15670@lnx-holt.americas.sgi.com>
References: <20051014192111.GB14418@lnx-holt.americas.sgi.com> <20051014192225.GD14418@lnx-holt.americas.sgi.com> <20051014213038.GA7450@kroah.com> <20051017113131.GA30898@lnx-holt.americas.sgi.com> <1129549312.32658.32.camel@localhost> <20051017114730.GC30898@lnx-holt.americas.sgi.com> <Pine.LNX.4.61.0510171331090.2993@goblin.wat.veritas.com> <20051017151430.GA2564@lnx-holt.americas.sgi.com> <Pine.LNX.4.61.0510171644220.4773@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0510171644220.4773@goblin.wat.veritas.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2005 at 04:59:20PM +0100, Hugh Dickins wrote:
> Repeating a technical question (sorry, that now seems off-topic!):
> what do you expect to happen with PROT_WRITE, MAP_PRIVATE?

That would end up with a MAP_PRIVATE, PROT_WRITE, VM_RESERVED
mapping.  That does not make sense for this device, so I added
the following check to mspec_mmap()

        if ((vma->vm_flags & VM_SHARED) == 0)
                return -EINVAL;

Thanks,
Robin
