Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751142AbWAPRYy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbWAPRYy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 12:24:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751144AbWAPRYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 12:24:54 -0500
Received: from 217-133-42-200.b2b.tiscali.it ([217.133.42.200]:25647 "EHLO
	opteron.random") by vger.kernel.org with ESMTP id S1751142AbWAPRYy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 12:24:54 -0500
Date: Mon, 16 Jan 2006 18:24:49 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Suleiman Souhlal <ssouhlal@FreeBSD.org>
Cc: Badari Pulavarty <pbadari@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, hugh@veritas.com, dvhltc@us.ibm.com,
       linux-mm@kvack.org, blaisorblade@yahoo.it, jdike@addtoit.com
Subject: Re: differences between MADV_FREE and MADV_DONTNEED
Message-ID: <20060116172449.GL15897@opteron.random>
References: <20051102014321.GG24051@opteron.random> <1130947957.24503.70.camel@localhost.localdomain> <20051111162511.57ee1af3.akpm@osdl.org> <1131755660.25354.81.camel@localhost.localdomain> <20051111174309.5d544de4.akpm@osdl.org> <43757263.2030401@us.ibm.com> <20060116130649.GE15897@opteron.random> <43CBC37F.60002@FreeBSD.org> <20060116162808.GG15897@opteron.random> <43CBD1C4.5020002@FreeBSD.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43CBD1C4.5020002@FreeBSD.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2006 at 09:03:00AM -0800, Suleiman Souhlal wrote:
> Andrea Arcangeli wrote:
> 
> >We can also use it for the same purpose, we could add the pages to
> >swapcache mark them dirty and zap the ptes _after_ that.
> 
> Wouldn't that cause the pages to get swapped out immediately?

Not really, it would be a non blocking operation. But they could be
swapped out shortly later (that's the whole point of DONTNEED, right?),
once there is more memory pressure. Otherwise if they're used again, a
minor fault will happen and it will find the swapcache uptodate in ram.
