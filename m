Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261628AbUEQPVI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261628AbUEQPVI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 11:21:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261611AbUEQPVI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 11:21:08 -0400
Received: from ipcop.bitmover.com ([192.132.92.15]:5033 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S261628AbUEQPVF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 11:21:05 -0400
Date: Mon, 17 May 2004 08:20:56 -0700
From: Larry McVoy <lm@bitmover.com>
To: "Theodore Ts'o" <tytso@mit.edu>, Wayne Scott <wscott@bitmover.com>,
       akpm@osdl.org, torvalds@osdl.org, elenstev@mesatop.com, lm@bitmover.com,
       wli@holomorphy.com, hugh@veritas.com, adi@bitmover.com, scole@lanl.gov,
       support@bitmover.com, linux-kernel@vger.kernel.org
Subject: Re: 1352 NUL bytes at the end of a page?
Message-ID: <20040517152056.GC30695@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Theodore Ts'o <tytso@mit.edu>, Wayne Scott <wscott@bitmover.com>,
	akpm@osdl.org, torvalds@osdl.org, elenstev@mesatop.com,
	lm@bitmover.com, wli@holomorphy.com, hugh@veritas.com,
	adi@bitmover.com, scole@lanl.gov, support@bitmover.com,
	linux-kernel@vger.kernel.org
References: <200405162136.24441.elenstev@mesatop.com> <Pine.LNX.4.58.0405162152290.25502@ppc970.osdl.org> <20040516231120.405a0d14.akpm@osdl.org> <20040517.085640.30175416.wscott@bitmover.com> <20040517151738.GA4730@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040517151738.GA4730@thunk.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2004 at 11:17:38AM -0400, Theodore Ts'o wrote:
> On Mon, May 17, 2004 at 08:56:40AM -0500, Wayne Scott wrote:
> > From: Andrew Morton <akpm@osdl.org>
> > > Well we can stop right there, because the only way someone can get some
> > > more non-zero user data into this page before we memset and write it is by
> > > locking the page beforehand, and block_write_full_page() has the page lock.
> > > (Or they can write stuff into it via mmap, but writing to the page outside
> > > i_size is an application bug).
> > 
> > BTW: BitKeeper never opens a writable mmap to a file.  The files are
> > read with mmap() and written by fwriting to a tmp file and then
> > renaming over the target.  And since we run on Windows, no process has
> > the file open when we are updating it.
> 
> Note though that the stdio library uses a writeable mmap to implement
> fwrite.

That's news to me.  And we use fwrite.
-- 
---
Larry McVoy                lm at bitmover.com           http://www.bitkeeper.com
