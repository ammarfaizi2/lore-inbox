Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267474AbUIJPHl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267474AbUIJPHl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 11:07:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267460AbUIJPHl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 11:07:41 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:47487 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S267474AbUIJPHg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 11:07:36 -0400
Date: Fri, 10 Sep 2004 16:07:21 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: Andrea Arcangeli <andrea@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       <arjanv@redhat.com>, Chris Wedgwood <cw@f00f.org>,
       LKML <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/3] Separate IRQ-stacks from 4K-stacks option
In-Reply-To: <593560000.1094826651@[10.10.2.4]>
Message-ID: <Pine.LNX.4.44.0409101555510.16784-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Sep 2004, Martin J. Bligh wrote:
> 
> I agree about killing anything but 4K stacks though - having the single
> page is very compelling - not only can we allocate it easier, but we can
> also use cache-hot pages from the hot list.

I think we all agree that's a promising future, and a good discipline.
But I'm not the only one to doubt we're there yet.

Chris's patch seems eminently sensible to me.  Why should having separate
interrupt stack depend on whether you're configured for 4K or 8K stacks?

Wasn't Andrea worried, a couple of months back, about nested interrupts
overflowing the 4K interrupt stack?  He was trying to work out how to
have an 8K interrupt stack even with the 4K task stack, proposed thread
info at both top and bottom of stack; but his "current" still looked to
me like it'd be significantly more costly than the present one.

I'm all for Chris's patch.

Hugh

