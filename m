Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264244AbUEHWjy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264244AbUEHWjy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 18:39:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264225AbUEHWjy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 18:39:54 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:20875 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S264244AbUEHWjp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 18:39:45 -0400
Date: Sat, 8 May 2004 23:39:32 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Christoph Hellwig <hch@infradead.org>
cc: Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rmap 24 pte_young first
In-Reply-To: <20040508232239.B12293@infradead.org>
Message-ID: <Pine.LNX.4.44.0405082332590.26651-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rmap 25 of course

On Sat, 8 May 2004, Christoph Hellwig wrote:
> On Sat, May 08, 2004 at 10:56:26PM +0100, Hugh Dickins wrote:
> >  
> > -	if (ptep_test_and_clear_young(pte))
> > +	if (pte_young(*pte) && ptep_test_and_clear_young(pte))
> 
> stupid question - shouldn't the pte_young check simply move to
> the beginning of ptep_test_and_clear_young?

I don't think that would be a good idea.  We're used to those
test_and_clear operations being atomic, putting an initial non-atomic
test inside would make it fundamentally non-atomic.  We know here that
it's not the end of the world if we miss a racing transition of the
young bit, but it wouldn't be good to hide and force that on others.

Hugh

