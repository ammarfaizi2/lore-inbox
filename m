Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263467AbUGMHIP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263467AbUGMHIP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 03:08:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263540AbUGMHIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 03:08:15 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:39303 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S263467AbUGMHIO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 03:08:14 -0400
Date: Tue, 13 Jul 2004 08:08:05 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rmaplock 1/6 PageAnon in mapping
In-Reply-To: <20040712214842.5c200de0.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44.0407130755420.5920-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jul 2004, Andrew Morton wrote:
> Hugh Dickins <hugh@veritas.com> wrote:
> >
> > Replace the PG_anon page->flags bit by setting the lower bit of the
> >  pointer in page->mapping when it's anon_vma: PAGE_MAPPING_ANON bit.
> 
> This is likely to cause conniptions in various quarters.  Is there no
> alternative?

I've little doubt barriers would provide an alternative;
but I'm hopeless with barriers, so couldn't manage it myself;
and not alone in finding them difficult; and surely more expensive.

> It might make things more palatable to hide the setting, clearing testing
> amd masking of this bit behind some set of wrapper functions.  Maybe.

Conniptious in some quarters that the name shouts too.  But where does it
appear?  In mm.h, the inlines to hide it from wider gaze.  And just four
times in rmap.c.  I'd have been happier to say three times, but even so,
I don't think burying it deeper helps anyone.

Hugh

