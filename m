Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750958AbWAPVp0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750958AbWAPVp0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 16:45:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751176AbWAPVp0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 16:45:26 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:25732 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750958AbWAPVpZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 16:45:25 -0500
To: Andrea Arcangeli <andrea@suse.de>
Cc: Suleiman Souhlal <ssouhlal@FreeBSD.org>,
       Badari Pulavarty <pbadari@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, hugh@veritas.com, dvhltc@us.ibm.com,
       linux-mm@kvack.org, blaisorblade@yahoo.it, jdike@addtoit.com
Subject: Re: differences between MADV_FREE and MADV_DONTNEED
References: <20051102014321.GG24051@opteron.random>
	<1130947957.24503.70.camel@localhost.localdomain>
	<20051111162511.57ee1af3.akpm@osdl.org>
	<1131755660.25354.81.camel@localhost.localdomain>
	<20051111174309.5d544de4.akpm@osdl.org> <43757263.2030401@us.ibm.com>
	<20060116130649.GE15897@opteron.random> <43CBC37F.60002@FreeBSD.org>
	<20060116162808.GG15897@opteron.random> <43CBD1C4.5020002@FreeBSD.org>
	<20060116172449.GL15897@opteron.random>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 16 Jan 2006 14:43:47 -0700
In-Reply-To: <20060116172449.GL15897@opteron.random> (Andrea Arcangeli's
 message of "Mon, 16 Jan 2006 18:24:49 +0100")
Message-ID: <m1r777rgq4.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> writes:

> On Mon, Jan 16, 2006 at 09:03:00AM -0800, Suleiman Souhlal wrote:
>> Andrea Arcangeli wrote:
>> 
>> >We can also use it for the same purpose, we could add the pages to
>> >swapcache mark them dirty and zap the ptes _after_ that.
>> 
>> Wouldn't that cause the pages to get swapped out immediately?
>
> Not really, it would be a non blocking operation. But they could be
> swapped out shortly later (that's the whole point of DONTNEED, right?),
> once there is more memory pressure. Otherwise if they're used again, a
> minor fault will happen and it will find the swapcache uptodate in ram.

As I recall the logic with DONTNEED was to mark the mapping of
the page clean so the page didn't need to be swapped out, it could
just be dropped.

That is why they anonymous and the file backed cases differ.

Part of the point is to avoid the case of swapping the pages out if
the application doesn't care what is on them anymore.

Eric
