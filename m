Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262162AbUKQC3X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262162AbUKQC3X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 21:29:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262163AbUKQC3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 21:29:23 -0500
Received: from fw.osdl.org ([65.172.181.6]:13713 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262162AbUKQC3D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 21:29:03 -0500
Date: Tue, 16 Nov 2004 18:28:41 -0800
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: dhowells@redhat.com, hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Making compound pages mandatory
Message-Id: <20041116182841.4ff7f2e5.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0411161746110.2222@ppc970.osdl.org>
References: <2315.1100630906@redhat.com>
	<Pine.LNX.4.58.0411161746110.2222@ppc970.osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
>
> 
> 
> On Tue, 16 Nov 2004, David Howells wrote:
> > 
> > Do you have any objection to compound pages being made mandatory, even without
> > HUGETLB support?
> 
> I haven't really looked into it, so I cannot make an informed decision.  
> How big is the overhead? And what's the _point_, since we don't seem to 
> need them normally, but the code is there for people who _do_ need them? 

Yes, it's just the single pointer chase.  Probably that's the common case
now, because everyone will be enabling hugepages on lots of architectures.

But still, the non-compound code is well tested too, and leaving it in
place does make a little microoptimisation available to those who want it,
so I don't see a reason yet to make compound pages compulsory.

So I'd suggest that we make compound pages conditional on a new
CONFIG_COMPOUND_PAGE and make that equal to HUGETLB_PAGE || !MMU.
