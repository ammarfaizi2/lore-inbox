Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261682AbUEQP2L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261682AbUEQP2L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 11:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261638AbUEQP02
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 11:26:28 -0400
Received: from ipcop.bitmover.com ([192.132.92.15]:11177 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S261648AbUEQPZd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 11:25:33 -0400
Date: Mon, 17 May 2004 08:25:17 -0700
From: Larry McVoy <lm@bitmover.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Wayne Scott <wscott@bitmover.com>,
       akpm@osdl.org, elenstev@mesatop.com, lm@bitmover.com,
       wli@holomorphy.com, hugh@veritas.com, adi@bitmover.com, scole@lanl.gov,
       support@bitmover.com, linux-kernel@vger.kernel.org
Subject: Re: 1352 NUL bytes at the end of a page?
Message-ID: <20040517152517.GD30695@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Linus Torvalds <torvalds@osdl.org>, Theodore Ts'o <tytso@mit.edu>,
	Wayne Scott <wscott@bitmover.com>, akpm@osdl.org,
	elenstev@mesatop.com, lm@bitmover.com, wli@holomorphy.com,
	hugh@veritas.com, adi@bitmover.com, scole@lanl.gov,
	support@bitmover.com, linux-kernel@vger.kernel.org
References: <200405162136.24441.elenstev@mesatop.com> <Pine.LNX.4.58.0405162152290.25502@ppc970.osdl.org> <20040516231120.405a0d14.akpm@osdl.org> <20040517.085640.30175416.wscott@bitmover.com> <20040517151738.GA4730@thunk.org> <Pine.LNX.4.58.0405170820560.25502@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0405170820560.25502@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2004 at 08:22:10AM -0700, Linus Torvalds wrote:
> On Mon, 17 May 2004, Theodore Ts'o wrote:
> > Note though that the stdio library uses a writeable mmap to implement
> > fwrite.
> 
> It does? Whee. Then I'll have to agree with Andrew - if there is a path 
> that is more likely to have bugs, it's trying to do writes with mmap and 
> ftruncate.
> 
> Who came up with that braindead idea? Is it some crazed Mach developer 
> that infiltrated the glibc development group?

You have my agreement on the craziness of this idea.  It's a lot easier for
the kernel to do smart things with write behind with write() rather than
mmap()-ed pages being touched.  SunOS is the only system I know which does
both "correctly" (correctly meaning the same way whether it is mmap or
write).

It's also a lose to do mmap() instead of read/write for small files.  Linux
is light weight enough that the cross over point is pretty small, probably
under 8K and certainly under 16K, but still.
-- 
---
Larry McVoy                lm at bitmover.com           http://www.bitkeeper.com
