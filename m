Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262171AbTGAKpq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 06:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262123AbTGAKpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 06:45:46 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:39519 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id S262030AbTGAKpi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 06:45:38 -0400
Date: Tue, 1 Jul 2003 12:01:21 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: Andrea Arcangeli <andrea@suse.de>, <mel@csn.ul.ie>, <linux-mm@kvack.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: What to expect with the 2.6 VM
In-Reply-To: <20030630200237.473d5f82.akpm@digeo.com>
Message-ID: <Pine.LNX.4.44.0307011147460.1161-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Jun 2003, Andrew Morton wrote:
> Andrea Arcangeli <andrea@suse.de> wrote:
> > 
> > described this way it sounds like NOFAIL imply a deadlock condition.
> 
> NOFAIL is what 2.4 has always done, and has the deadlock opportunities
> which you mention.  The other modes allow the caller to say "don't try
> forever".

__GFP_NOFAIL is also very badly named: patently it can and does fail,
when PF_MEMALLOC or PF_MEMDIE or not __GFP_WAIT.  Or is the idea that
its users might as well oops when it does fail?  Should its users be
changed to use the less perniciously named __GFP_REPEAT, or should
__alloc_pages be changed to deadlock more thoroughly?

Hugh

