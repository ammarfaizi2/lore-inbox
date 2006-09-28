Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030253AbWI1RKQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030253AbWI1RKQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 13:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751955AbWI1RKQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 13:10:16 -0400
Received: from excu-mxob-2.symantec.com ([198.6.49.23]:62092 "EHLO
	excu-mxob-2.symantec.com") by vger.kernel.org with ESMTP
	id S1751954AbWI1RKN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 13:10:13 -0400
Date: Thu, 28 Sep 2006 18:09:33 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Neil Brown <neilb@suse.de>
cc: "J. Bruce Fields" <bfields@fieldses.org>, Andrew Morton <akpm@osdl.org>,
       nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [NFS] [PATCH 009 of 11] knfsd: Allow max size of NFSd payload
 to be configured.
In-Reply-To: <17691.19982.162616.572205@cse.unsw.edu.au>
Message-ID: <Pine.LNX.4.64.0609281752290.32574@blonde.wat.veritas.com>
References: <20060824162917.3600.patches@notabene> <1060824063716.5020@suse.de>
 <20060925212457.GK32762@fieldses.org> <17691.19982.162616.572205@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 28 Sep 2006 17:09:25.0839 (UTC) FILETIME=[D9C0D5F0:01C6E320]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Sep 2006, Neil Brown wrote:
> But are the pages that totalram is measure in, normal pages, of
> page_cache pages?  And is there a difference?

There's never yet been a difference, outside of some patches by bcrl.
But totalram_pages comes "before" any idea of page cache, so it's in
normal pages.

> Should we use PAGE_CACHE_SHIFT, or PAGE_SHIFT?

PAGE_SHIFT.

> And why do we have both if they are numerically identical?

Very irritating: the time I've wasted on "correcting" code for the
"difference" between them!  Yet there's still plenty wrong and I've
largely given up on it.

Probably never will be a difference: but the idea was that the page
cache might use >0-order pages (unclear what happens to swap cache).

I wish they'd waited for a working implementation before introducing
the distinction; but never quite felt like deleting all trace of it.

> 
> I'll submit a patch which uses
>         12 - PAGE_SHIFT
> in a little while.

I haven't seen your context; but "12 - PAGE_SHIFT" sounds like a
bad idea on all those architectures with PAGE_SHIFT 13 or more;
you'll be on much safer ground working with "PAGE_SHIFT - 12".

Hugh
