Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261355AbVADLzw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261355AbVADLzw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 06:55:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261365AbVADLzw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 06:55:52 -0500
Received: from one.firstfloor.org ([213.235.205.2]:19640 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S261355AbVADLzX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 06:55:23 -0500
To: Manfred Spraul <manfred@colorfullife.com>
Cc: torvalds@osdl.org, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] periodically scan redzone entries and slab control
 structures
References: <Pine.LNX.4.44.0501032223360.1865-100000@dbl.q-ag.de>
From: Andi Kleen <ak@muc.de>
Date: Tue, 04 Jan 2005 12:55:21 +0100
In-Reply-To: <Pine.LNX.4.44.0501032223360.1865-100000@dbl.q-ag.de> (Manfred
 Spraul's message of "Mon, 3 Jan 2005 22:29:22 +0100 (CET)")
Message-ID: <m1r7l1wgra.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul <manfred@colorfullife.com> writes:

> The redzone words are only checked during alloc and free - thus objects
> that are never/rarely freed are not checked at all.
>
> The attached patch adds a periodic scan over all objects and checks for
> wrong redzone data or corrupted bufctl lists.
>
> Most changes are under #ifdef DEBUG, the only exception is a trivial
> correction for the initial timeout calculation: divide the cachep address
> by L1_CACHE_BYTES before the mod - the low order bits are always 0.

Very nice patch. One request: Can you global and EXPORT_SYMBOL
the scanning function?

There is a kernel testing technique called "thrashing" that relies
on doing some custom stress from a kernel module and then checking
all state very often to catch corruption early. Calling the slab check m
ore often from such a test module would be useful.

Also I would make the slab test interval a kernel parameter to 
force more regular checking during stress testing.

-Andi
