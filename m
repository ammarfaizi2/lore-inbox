Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263169AbUC2Wfl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 17:35:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263158AbUC2WfE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 17:35:04 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:21146
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263162AbUC2WdI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 17:33:08 -0500
Date: Tue, 30 Mar 2004 00:33:07 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: [andrea@suse.de: Re: 2.6.5-rc2-aa vma merging]
Message-ID: <20040329223307.GH3808@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

though it was a private email.

----- Forwarded message from Andrea Arcangeli <andrea@suse.de> -----

Date: Tue, 30 Mar 2004 00:32:30 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Subject: Re: 2.6.5-rc2-aa vma merging

On Mon, Mar 29, 2004 at 08:44:25PM +0100, Hugh Dickins wrote:
> Andrea,
> 
> Again I beg you to attend to vma merging in your anon_vma tree.
> Still you have #if VMA_MERGING_FIXUP throughout mm/mprotect.c
> (and much less seriously in mremap.c), and that's just masking
> the real problem: that when you do enable vma merging there, your
> anon_vmas will get in the way of merging in significant cases.
> 
> Try the example below, on mainline and on anonmm and on anon_vma,
> even when you've done the VMA_MERGING_FIXUP: you're limited by the
> MAX_MAP_COUNT of vmas, one per page.  Now, I know there's a move
> afoot to have /proc/sys/vm/max_map_count tunable, but I don't
> think that's the right answer for you ;)
> 
> If I remember rightly, Linus tried to do away with a lot of the
> vma merging about three years ago, but some had to be reinstated.

it was me to reistantiate it. And it wasn't for mprotect. Infact it was
me adding it to mprotect and mremap too, it has never been there before
(the day I did mprotect and mremap I got bored at some point and that's
why we never had it for mlock yet).

> So I assume that what's there is needed, and the example below
> does looks plausible enough: add page, fill it, protect it, ...

this will work perfect, absolutely perfect. You didn't read my code well
enough.

You still can write an exploit for it, but it will not be a real life
one.

----- End forwarded message -----
