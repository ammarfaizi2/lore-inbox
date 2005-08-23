Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932388AbVHWUnl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932388AbVHWUnl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 16:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932396AbVHWUnl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 16:43:41 -0400
Received: from gold.veritas.com ([143.127.12.110]:15679 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S932393AbVHWUnk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 16:43:40 -0400
Date: Tue, 23 Aug 2005 21:45:36 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Ulrich Drepper <drepper@redhat.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: mremap() use is racy
In-Reply-To: <430B7EAE.6020001@redhat.com>
Message-ID: <Pine.LNX.4.61.0508232135480.12189@goblin.wat.veritas.com>
References: <430B7EAE.6020001@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 23 Aug 2005 20:43:40.0419 (UTC) FILETIME=[58085530:01C5A823]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Aug 2005, Ulrich Drepper wrote:
> 
> One possible solution would be to add a flag to mremap() which allows
> mremap() to steal memory.  In general that would be too dangerous but we
> could limit it to private, anonymous mappings which have no access
> permissions (i.e., PROT_NONE with MAP_PRIVATE and MAP_ANON).  One
> explicitly has to allocate such blocks, they don't appear naturally.
> And the program in any case knows about the address space layout.
> 
> So, how about adding MREMAP_MAPOVERNONE or so?

If the app can plan ahead as you're proposing, why doesn't it just
mmap the maximum it might need, mprotect PROT_NONE the end it doesn't
need yet, then progressively re-mprotect parts to make them accessible
as needed?

I'm missing what mremap gives you here that mprotect doesn't.  Though
I do see that it would be nice not to be forced into mremap moving
all the time, because of other maps blocking you off: nice perhaps
to know what region of the layout is least likely to be so affected.

Hugh
