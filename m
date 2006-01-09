Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751321AbWAIUa2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbWAIUa2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 15:30:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbWAIUa1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 15:30:27 -0500
Received: from wproxy.gmail.com ([64.233.184.201]:15807 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751321AbWAIUa1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 15:30:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BT6saoNiHCjaz24/+QWyBCdsEGIzdiSGLtYpr0nA5dVu9iI0JnzCT2eyt6l2TjodqEq5HyHZ6AX1vc2LMJuTZ8lOl+BUu5tDb20jWEhpkPQa0NQjLfHTegi408gAl4v5fG9XIpOam490mR2zi6FnhgcS3nEO7v81+iA+RdLbrX4=
Message-ID: <9a8748490601091230g5ed68e07rc379e52ef06ec31a@mail.gmail.com>
Date: Mon, 9 Jan 2006 21:30:26 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Hugh Dickins <hugh@veritas.com>
Subject: Re: 2.6.15-mm
Cc: Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Doug Gilbert <dougg@torque.net>,
       James Bottomley <James.Bottomley@steeleye.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Mike Christie <michaelc@cs.wisc.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0601092005510.16057@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060107052221.61d0b600.akpm@osdl.org>
	 <9a8748490601070708p4353eb0ev9ea15edee132b13b@mail.gmail.com>
	 <9a8748490601090947i524d5f73uf5ccd06d8c693cae@mail.gmail.com>
	 <20060109175748.GD25102@redhat.com>
	 <9a8748490601091001y74fba5q2cd7e08a324701c3@mail.gmail.com>
	 <Pine.LNX.4.61.0601091819160.14800@goblin.wat.veritas.com>
	 <9a8748490601091048x46716e25u2fe2ebe9b5fbc9bb@mail.gmail.com>
	 <Pine.LNX.4.61.0601091857430.15219@goblin.wat.veritas.com>
	 <9a8748490601091139pf5fb6a0v3c8b3bcb41b85940@mail.gmail.com>
	 <Pine.LNX.4.61.0601092005510.16057@goblin.wat.veritas.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/9/06, Hugh Dickins <hugh@veritas.com> wrote:
> On Mon, 9 Jan 2006, Jesper Juhl wrote:
> > On 1/9/06, Hugh Dickins <hugh@veritas.com> wrote:
> > >
> > > Remove sg_rb_correct4mmap() and its nasty __put_page()s, which are liable
> > > to do quite the wrong thing.  Instead allocate pages with __GFP_COMP, then
> > > high-orders should be safe for exposure to userspace by sg_vma_nopage(),
> > > without any further manipulations.  Based on original patch by Nick Piggin.
> >
> > Unfortunately that patch doesn't change a thing (except some
> > addresses, but that's exected) :-(
>
> Okay, thanks for trying.  Maybe you need to revert to the 2.6.15
> drivers/scsi/sg.c for now (does that work for you in the 2.6.15-mm2
> kernel?), or you could first try this little patch on 2.6.15-mm2
> (either with or without my earlier patch - which will be wanted,
> but not so urgently).  I've not attempted to review the changes
> in detail, but this change (if no more) looks to be badly needed...
> And it's 2.6.15-git needing the fix, not just -mm.
>
>
> sg_page_malloc clear the data buffer, not that extent of mem_map.
>

Hugh, you're a genious!
I added your small patch on top of your previous one and now
2.6.15-mm2 doesn't crash any more  :-)

Thanks a lot.


2.6.15-mm2 still has a few other problems for me though, which I'll
report in a short while in sepperate threads - a lot easier to
investigate now that the box no longer crashes while running that
kernel :)

Thank you again for your work in fixing this problem.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
