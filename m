Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030239AbVIILOu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030239AbVIILOu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 07:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030240AbVIILOu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 07:14:50 -0400
Received: from gold.veritas.com ([143.127.12.110]:30040 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1030239AbVIILOt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 07:14:49 -0400
Date: Fri, 9 Sep 2005 12:14:38 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andi Kleen <ak@suse.de>
cc: Jan Beulich <JBeulich@novell.com>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org
Subject: Re: [discuss] [PATCH] allow CONFIG_FRAME_POINTER for x86-64
In-Reply-To: <200509091258.13300.ak@suse.de>
Message-ID: <Pine.LNX.4.61.0509091208350.6247@goblin.wat.veritas.com>
References: <43207D28020000780002451E@emea1-mh.id2.novell.com>
 <4321749202000078000248C5@emea1-mh.id2.novell.com>
 <Pine.LNX.4.61.0509091133180.5937@goblin.wat.veritas.com> <200509091258.13300.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 09 Sep 2005 11:14:49.0371 (UTC) FILETIME=[B15D76B0:01C5B52F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Sep 2005, Andi Kleen wrote:
> 
> It won't give more accurate backtraces, not even on i386 because show_stack
> doesn't have any code to follow frame pointers.

Ah, right.  I'm using kdb with it.  (And my recollection of when
show_stack did have a framepointer version, is that it was hopelessly
broken on interrupt frames, and we're much better off without it.)

> The only reason to use them would be external debuggers, but those
> don't need them on x86-64 neither.

Don't need them, but find them as useful on x86_64 as on i386?

Certainly, I can go on patching in FRAME_POINTERs for x86_64
as I have done, no problem with that.  But it seems both bogus
and unhelpful to have that "&& !X86_64" in lib/Kconfig.debug -
framepointers are as helpful/useless on x86_64 as the rest.

Hugh
