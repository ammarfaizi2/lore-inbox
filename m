Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261865AbUERBew@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261865AbUERBew (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 21:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262175AbUERBew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 21:34:52 -0400
Received: from ipcop.bitmover.com ([192.132.92.15]:21171 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S261865AbUERBeu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 21:34:50 -0400
Date: Mon, 17 May 2004 18:34:39 -0700
From: Larry McVoy <lm@bitmover.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Steven Cole <elenstev@mesatop.com>, mason@suse.com, torvalds@osdl.org,
       lm@bitmover.com, wli@holomorphy.com, hugh@veritas.com, adi@bitmover.com,
       support@bitmover.com, linux-kernel@vger.kernel.org
Subject: Re: 1352 NUL bytes at the end of a page? (was Re: Assertion `s && s->tree' failed: The saga continues.)
Message-ID: <20040518013439.GA23497@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Andrew Morton <akpm@osdl.org>, Steven Cole <elenstev@mesatop.com>,
	mason@suse.com, torvalds@osdl.org, lm@bitmover.com,
	wli@holomorphy.com, hugh@veritas.com, adi@bitmover.com,
	support@bitmover.com, linux-kernel@vger.kernel.org
References: <200405132232.01484.elenstev@mesatop.com> <1084828124.26340.22.camel@spc0.esa.lanl.gov> <20040517142946.571a3e91.akpm@osdl.org> <200405171752.08400.elenstev@mesatop.com> <20040517171330.7d594eb1.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040517171330.7d594eb1.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2004 at 05:13:30PM -0700, Andrew Morton wrote:
> I guess it would be interesting to run it on a filesystem which has 2k or
> even 1k blocksize.  If the corruption then terminates on a 2k- or
> 1k-boundary then that will rule out a few culprits.

Does anyone have a theory that accounts for the fact that the zeroed 
section is always tail aligned and seems to be the same length?  The
data seems to be

[ good page ] [ GGGB ] [ more good pages ] [ GGGB ] etc.

where the GGG is the first 2817 bytes and the B is the last 1279 (decimal)
bytes.  That's just too weird to be random, right?

> I'd really like to see this happen on some other machine though.  It'd be
> funny if you have a dud disk drive or something.

We can easily rule that out.  Steven, do a 

	dd if=/dev/zero of=USE_SOME_SPACE bs=1048576 count=500

which will eat up 500 MB and should eat up any bad blocks.  I _really_
doubt it is a bad disk.

Steven, if you have a copy of lmbench then use lmdd from that like so

	lmdd of=XXX opat=1 

and that will write non-zero data to the disk, you then remove that file
and if we are getting random crud from the disk then we won't have nulls.
-- 
---
Larry McVoy                lm at bitmover.com           http://www.bitkeeper.com
