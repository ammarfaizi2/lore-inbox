Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261383AbSJJNM0>; Thu, 10 Oct 2002 09:12:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261530AbSJJNM0>; Thu, 10 Oct 2002 09:12:26 -0400
Received: from denise.shiny.it ([194.20.232.1]:35471 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id <S261383AbSJJNMY>;
	Thu, 10 Oct 2002 09:12:24 -0400
Message-ID: <XFMail.20021010151735.pochini@shiny.it>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <3DA55E0C.24033BB5@aitel.hist.no>
Date: Thu, 10 Oct 2002 15:17:35 +0200 (CEST)
From: Giuliano Pochini <pochini@shiny.it>
To: Helge Hafting <helgehaf@aitel.hist.no>
Subject: Re: [PATCH] O_STREAMING - flag for optimal streaming I/O
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 10-Oct-2002 Helge Hafting wrote:
> Giuliano Pochini wrote:
> 
>> Yes, it makes sense, but it's useless or harmful to discard caches
>> if nobody else needs memory. You just lose data that may be
>> requested in the future for no reason.
> 
> Sure, so the ideal is to not drop unconditionally, but
> make sure that the "finished" O_STREAMING pages are
> the very first ones to go whenever memory pressure happens.
> 
> The question then becomes "can you do that, with no more
> overhead or code complexity than the existing stuff?"

I don't know enough of linux internals to suggest anything
really useful. Perhaps something like: "drop pages which
weren't already loaded when we requested them" might be
enough to prevent cached stuff used by other tasks to be
removed from memory.

> It wouldn't necessarily make much difference, because
> a linux machine is almost always under memory pressure.
> Free memory is simply filled up with cache till there
> is no more left.  From then on, all requests for memory
> are handled by throwing something else out of cache
> or into swap.  In that case the streaming pages
> are evicted quickly anyway, and the ideal case
> is no different from the implemented case.

O_STREAMING is a way to reduce cache footprint of some
files, ad it does the job very well, unless those files
are accessed concurrently by two of more processes.
Thing again about to backup a large database. I don't
want to use tar because it kills the caches. I would
like a way to read the db so that the cached part of
the db (the 20% which gets 80% of accesses) is not
expunged.


Bye.

