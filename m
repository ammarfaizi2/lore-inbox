Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261418AbUEQOGK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261418AbUEQOGK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 10:06:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261422AbUEQOGK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 10:06:10 -0400
Received: from ipcop.bitmover.com ([192.132.92.15]:1448 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S261418AbUEQOGH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 10:06:07 -0400
Date: Mon, 17 May 2004 07:05:57 -0700
From: Larry McVoy <lm@bitmover.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, elenstev@mesatop.com, lm@bitmover.com,
       wli@holomorphy.com, hugh@veritas.com, adi@bitmover.com, scole@lanl.gov,
       support@bitmover.com, linux-kernel@vger.kernel.org
Subject: Re: 1352 NUL bytes at the end of a page? (was Re: Assertion `s && s->tree' failed: The saga continues.)
Message-ID: <20040517140557.GA29054@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
	elenstev@mesatop.com, lm@bitmover.com, wli@holomorphy.com,
	hugh@veritas.com, adi@bitmover.com, scole@lanl.gov,
	support@bitmover.com, linux-kernel@vger.kernel.org
References: <200405132232.01484.elenstev@mesatop.com> <20040517022816.GA14939@work.bitmover.com> <Pine.LNX.4.58.0405161936490.25502@ppc970.osdl.org> <200405162136.24441.elenstev@mesatop.com> <Pine.LNX.4.58.0405162152290.25502@ppc970.osdl.org> <20040517002506.34022cb8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040517002506.34022cb8.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2004 at 12:25:06AM -0700, Andrew Morton wrote:
> Linus Torvalds <torvalds@osdl.org> wrote:
> >
> > Andrew, the obvious culprit would be the memset() in fs/buffer.c 
> >  (block_write_full_page() 
> 
> There is one race.
> 
> If an application does mmap(MAP_SHARED) of, say, a 2048 byte file and then
> extends it:
> 
> 	p = mmap(..., fd, ...);
> 	ftructate(fd, 4096);
> 	p[3000] = 1;
> 
> A racing block_write_full_page() could fail to notice the extended i_size
> and would decide to zap those 2048 bytes anyway.	

This isn't our problem, we only read with mmap().  We write with stdio.
-- 
---
Larry McVoy                lm at bitmover.com           http://www.bitkeeper.com
