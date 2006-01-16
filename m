Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750726AbWAPQ2N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbWAPQ2N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 11:28:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750744AbWAPQ2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 11:28:13 -0500
Received: from 217-133-42-200.b2b.tiscali.it ([217.133.42.200]:30062 "EHLO
	opteron.random") by vger.kernel.org with ESMTP id S1750726AbWAPQ2M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 11:28:12 -0500
Date: Mon, 16 Jan 2006 17:28:08 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Suleiman Souhlal <ssouhlal@FreeBSD.org>
Cc: Badari Pulavarty <pbadari@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, hugh@veritas.com, dvhltc@us.ibm.com,
       linux-mm@kvack.org, blaisorblade@yahoo.it, jdike@addtoit.com
Subject: Re: differences between MADV_FREE and MADV_DONTNEED
Message-ID: <20060116162808.GG15897@opteron.random>
References: <20051101000509.GA11847@ccure.user-mode-linux.org> <1130894101.24503.64.camel@localhost.localdomain> <20051102014321.GG24051@opteron.random> <1130947957.24503.70.camel@localhost.localdomain> <20051111162511.57ee1af3.akpm@osdl.org> <1131755660.25354.81.camel@localhost.localdomain> <20051111174309.5d544de4.akpm@osdl.org> <43757263.2030401@us.ibm.com> <20060116130649.GE15897@opteron.random> <43CBC37F.60002@FreeBSD.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43CBC37F.60002@FreeBSD.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2006 at 08:02:07AM -0800, Suleiman Souhlal wrote:
> FWIW, in FreeBSD, MADV_DONTNEED is not destructive, and just makes pages 
> (including anonymous ones) more likely to get swapped out.

We can also use it for the same purpose, we could add the pages to
swapcache mark them dirty and zap the ptes _after_ that.

> This would seem like the best way to go, since it would bring Linux's 
> behavior more in line with what other systems do.

Agreed.

> FreeBSD's MADV_FREE only works on anonymous memory (it's a noop for 
> vnode-backed memory), and marks the pages clean before moving them to 
> the inactive queue, so that they can be freed or reused quickly, without 
> causing a pagefault.

Well, perhaps solaris is also a noop and not necessairly a -EINVAL, all
I know from the docs is "This value cannot be used on mappings that have
underlying file objects.", so I expected -EINVAL but it may be a noop.
