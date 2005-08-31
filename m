Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964805AbVHaNko@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964805AbVHaNko (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 09:40:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964806AbVHaNko
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 09:40:44 -0400
Received: from gold.veritas.com ([143.127.12.110]:24225 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S964805AbVHaNkn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 09:40:43 -0400
Date: Wed, 31 Aug 2005 14:42:38 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Arjan van de Ven <arjan@infradead.org>
cc: Dave McCracken <dmccr@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [PATCH 1/1] Implement shared page tables
In-Reply-To: <1125489077.3213.12.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.61.0508311437070.16834@goblin.wat.veritas.com>
References: <7C49DFF721CB4E671DB260F9@[10.1.1.4]> 
 <Pine.LNX.4.61.0508311143340.15467@goblin.wat.veritas.com>
 <1125489077.3213.12.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 31 Aug 2005 13:40:42.0990 (UTC) FILETIME=[9535F8E0:01C5AE31]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Aug 2005, Arjan van de Ven wrote:
> On Wed, 2005-08-31 at 12:44 +0100, Hugh Dickins wrote:
> > I was going to say, doesn't randomize_va_space take away the rest of
> > the point?  But no, it appears "randomize_va_space", as it currently
> > appears in mainline anyway, is somewhat an exaggeration: it just shifts
> > the stack a little, with no effect on the rest of the va space.
> 
> it also randomizes mmaps

Ah, via PF_RANDOMIZE, yes, thanks: so long as certain conditions are
fulfilled - and my RLIM_INFINITY RLIMIT_STACK has been preventing it.

And mmaps include shmats: so unless the process specifies non-NULL
shmaddr to attach at, it'll choose a randomized address for that too
(subject to those various conditions).

Which is indeed a further disincentive against shared page tables.

Hugh
