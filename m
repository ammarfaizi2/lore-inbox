Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264328AbUEIKcF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264328AbUEIKcF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 May 2004 06:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264331AbUEIKcF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 May 2004 06:32:05 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:37260 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S264328AbUEIKcC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 May 2004 06:32:02 -0400
Date: Sun, 9 May 2004 11:31:52 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Andrea Arcangeli <andrea@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rmap 24 pte_young first
In-Reply-To: <Pine.LNX.4.44.0405082350420.26698-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0405091114140.3587-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 May 2004, Hugh Dickins wrote:
> On Sat, 8 May 2004, Russell King wrote:
> > On Sat, May 08, 2004 at 11:39:32PM +0100, Hugh Dickins wrote:
> > > On Sat, 8 May 2004, Christoph Hellwig wrote:
> > > > 
> > > > stupid question - shouldn't the pte_young check simply move to
> > > > the beginning of ptep_test_and_clear_young?
> > > 
> > > I don't think that would be a good idea.
> > 
> > EAGAIN.

I think that should be -EEXIST.

> Hah!  Delightful refutation of my little lecture.  Thanks a lot for
> turning that up.  Hmm.  Well, I guess I need to research that one

Okay, the arch implementations of ptep_test_and_clear_young say
Christoph is right: the preliminary pte_young test should be buried
in there (in the SMP cases as in the UP cases), not out in rmap.c.

(Just in case anyone is in doubt, I'm absolutely not proposing a
preliminary pte_dirty test in the SMP ptep_test_and_clear_dirty.)

I'll leave it for now: it's much better dealt with when we get to
doing the (much more important) TLB flush after clearing young.

Andrew, please just ignore rmap 25 (billed as 24) "pte_young first".

Hugh

