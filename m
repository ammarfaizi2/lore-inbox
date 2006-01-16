Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750745AbWAPNG6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbWAPNG6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 08:06:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750744AbWAPNG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 08:06:58 -0500
Received: from 217-133-42-200.b2b.tiscali.it ([217.133.42.200]:52496 "EHLO
	opteron.random") by vger.kernel.org with ESMTP id S1750739AbWAPNG5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 08:06:57 -0500
Date: Mon, 16 Jan 2006 14:06:49 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       hugh@veritas.com, dvhltc@us.ibm.com, linux-mm@kvack.org,
       blaisorblade@yahoo.it, jdike@addtoit.com
Subject: differences between MADV_FREE and MADV_DONTNEED
Message-ID: <20060116130649.GE15897@opteron.random>
References: <20051029025119.GA14998@ccure.user-mode-linux.org> <1130788176.24503.19.camel@localhost.localdomain> <20051101000509.GA11847@ccure.user-mode-linux.org> <1130894101.24503.64.camel@localhost.localdomain> <20051102014321.GG24051@opteron.random> <1130947957.24503.70.camel@localhost.localdomain> <20051111162511.57ee1af3.akpm@osdl.org> <1131755660.25354.81.camel@localhost.localdomain> <20051111174309.5d544de4.akpm@osdl.org> <43757263.2030401@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43757263.2030401@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now that MADV_REMOVE is in, should we discuss MADV_FREE?

MADV_FREE in Solaris is destructive and only works on anonymous memory,
while MADV_DONTNEED seems to never be destructive (which I assume it
means it's a noop on anonymous memory).

Our MADV_DONTNEED is destructive on anonymous memory, while it's
non-destructive on file mappings.

Perhaps we could move the destructive anonymous part of MADV_DONTNEED to
MADV_FREE?

Or we could as well go relaxed and define MADV_FREE and MADV_DONTNEED
the same way (that still leaves the question if we risk to break apps
ported from solaris where MADV_DONTNEED is apparently always not
destructive).

I only read the docs, I don't know in practice what MADV_DONTNEED does
on solaris (does it return -EINVAL if run on anonymous memory or not?).

http://docs.sun.com/app/docs/doc/816-5168/6mbb3hrgk?a=view

BTW, I don't know how other specifications define MADV_FREE, but besides
MADV_REMOVE I've also got the request to provide MADV_FREE in linux,
this is why I'm asking. (right now I'm telling them to use #ifdef
__linux__ #define MADV_FREE MADV_DONTNEED but that's quite an hack since
it could break if we make MADV_DONTNEED non-destructive in the future)

Thanks.
