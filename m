Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269938AbUJNAy5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269938AbUJNAy5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 20:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269939AbUJNAy5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 20:54:57 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:7298 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S269938AbUJNAyz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 20:54:55 -0400
Date: Thu, 14 Oct 2004 10:53:00 +1000
From: Nathan Scott <nathans@sgi.com>
To: Nick Piggin <piggin@cyberone.com.au>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-xfs@oss.sgi.com
Subject: Re: Page cache write performance issue
Message-ID: <20041014005300.GA716@frodo>
References: <20041013054452.GB1618@frodo> <20041012231945.2aff9a00.akpm@osdl.org> <20041013063955.GA2079@frodo> <20041013000206.680132ad.akpm@osdl.org> <20041013172352.B4917536@wobbly.melbourne.sgi.com> <416CE423.3000607@cyberone.com.au> <20041013013941.49693816.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20041013013941.49693816.akpm@osdl.org>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2004 at 01:39:41AM -0700, Andrew Morton wrote:
> Nick Piggin <piggin@cyberone.com.au> wrote:
> >
> >  Andrew probably has better ideas.
> 
> uh, is this an ia32 highmem box?

Yep, it is.

> If so, you've hit the VM sour spot.
> ...
> Basically, *any* other config is fine.  896MB and below, 1.5GB and above.

I just tried switching CONFIG_HIGHMEM off, and so running the
machine with 512MB; then adjusted the test to write 256M into
the page cache, again in 1K sequential chunks.  A similar mis-
behaviour happens, though the numbers are slightly better (up
from ~4 to ~6.5MB/sec).  Both ext2 and xfs see this.  When I
drop the file size down to 128M with this kernel, I see good
results again (as we'd expect).

I'm being pulled onto other issues atm, but in the background
I could try reverting specific changesets if you guys can
suggest anything in particular that might be triggering this?

thanks!

-- 
Nathan
