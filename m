Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261826AbVBIOaN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261826AbVBIOaN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 09:30:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261827AbVBIOaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 09:30:13 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:18732 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261826AbVBIOaH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 09:30:07 -0500
Date: Wed, 9 Feb 2005 14:28:52 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: David Howells <dhowells@redhat.com>
cc: Christoph Hellwig <hch@infradead.org>,
       Anton Altaparmakov <aia21@cam.ac.uk>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: page_mkwrite seems broken
Message-ID: <Pine.LNX.4.61.0502091357001.6086@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Feb 2005, Hugh Dickins wrote in another thread:
> 
> Isn't this exactly what David Howells' page_mkwrite stuff in -mm's
> add-page-becoming-writable-notification.patch is designed for?
> 
> Though it looks a little broken to me as it stands (beyond the two
> fixup patches already there).  I've not found time to double-check
> or test, apologies in advance if I'm libelling, but...
> 
> (a) I thought the prot bits do_nopage gives a pte in a shared writable
>     mapping include write permission, even when it's a read fault:
>     that can't be allowed if there's a page_mkwrite.
> 
> (b) I don't understand how do_wp_page's "reuse" logic for whether it
>     can just go ahead and use the existing anonymous page, would have
>     any relevance to calling page_mkwrite on a shared writable page,
>     which must be used and not COWed however many references there are.

I have now looked further, and both points still seem valid to me:
the page_mkwrite calling code looks doubly broken.  (Tested?)

Nor has there been any movement on the points raised by Christoph,
that aops->page_mkwrite is redundant, and do_wp_page_mk_pte_writable
separation unhelpful.

I could probably put page_mkwrite to use in tmpfs (to eliminate its
unsatisfactory but never over-troubling shmem_recalc_inode), but not
as it currently stands.

Are you planning any movement on this, David?
Or should I have a go sometime?

Hugh
