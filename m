Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275930AbTHOM5n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 08:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275954AbTHOM5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 08:57:42 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:31361 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S275930AbTHOM5h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 08:57:37 -0400
Date: Fri, 15 Aug 2003 13:57:35 +0100
From: Jamie Lokier <jamie@shareable.org>
To: mouschi@wi.rr.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Interesting VM feature?
Message-ID: <20030815125735.GE15911@mail.jlokier.co.uk>
References: <13dedd139cb9.139cb913dedd@rdc-kc.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13dedd139cb9.139cb913dedd@rdc-kc.rr.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mouschi@wi.rr.com wrote:
> What this mempool wants to do is to be able to
> allocate a block of memory and tell the kernel which
> pages from it can be outright discarded, instead of
> swapped out when memory starts to get crowded. 

You can call madvise(start, length, MADV_DONTNEED),
or you can mmap() fresh empty pages into the region.

I have no idea if either of these methods is efficient enough to be
useful.  Also, I don't know whether mmap() would create multiple VMAs,
or if it is clever enough to merge adjacent vmas of anonymous private
mappings regardles of offset.

The ideal implementation would give the kernel the _option_ of
discarding pages until they are next touched, so that they are
discarded when there is memory pressure but retained if not, avoiding
the unnecessary zero-fill and cache flush.

Unfortunately, though much discussed a long time ago, the kernel
offers no service like this.

-- Jamie
