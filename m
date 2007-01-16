Return-Path: <linux-kernel-owner+w=401wt.eu-S932193AbXAPDpY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbXAPDpY (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 22:45:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932209AbXAPDpY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 22:45:24 -0500
Received: from lazybastard.de ([212.112.238.170]:36762 "EHLO
	longford.lazybastard.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932193AbXAPDpY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 22:45:24 -0500
Date: Tue, 16 Jan 2007 03:41:14 +0000
From: =?utf-8?B?SsO2cm4=?= Engel <joern@lazybastard.org>
To: Aubrey <aubreylee@gmail.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Hua Zhong <hzhong@gmail.com>, Hugh Dickins <hugh@veritas.com>,
       linux-kernel@vger.kernel.org, hch@infradead.org,
       kenneth.w.chen@intel.com, akpm@osdl.org, mjt@tls.msk.ru,
       Carsten Otte <cotte@freenet.de>
Subject: Re: O_DIRECT question
Message-ID: <20070116034113.GB27177@lazybastard.org>
References: <6d6a94c50701101857v2af1e097xde69e592135e54ae@mail.gmail.com> <Pine.LNX.4.64.0701101902270.3594@woody.osdl.org> <Pine.LNX.4.64.0701101910110.3594@woody.osdl.org> <45A5D4A7.7020202@yahoo.com.au> <Pine.LNX.4.64.0701110746360.3594@woody.osdl.org> <6d6a94c50701110819nf78a90eg3ff06f85c75e8b50@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6d6a94c50701110819nf78a90eg3ff06f85c75e8b50@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 January 2007 00:19:45 +0800, Aubrey wrote:
>
> Yes for desktop, server, but maybe not for embedded system, specially
> for no-mmu linux. In many embedded system cases, the whole system is
> running in the ram, including file system. So it's not necessary using
> page cache anymore. Page cache can't improve performance on these
> cases, but only fragment memory.

You were not very specific, so I have to guess that you're referring to
the problem of having two copies of the same file in RAM - one in the
page cache and one in the "backing store", which is just RAM.

There are two solutions to this problem.  One is tmpfs, which doesn't
use a backing store and keeps all data in the page cache.  The other is
xip, which doesn't use the page cache and goes directly to backing
store.  Unlike O_DIRECT, xip only works with a RAM or de-facto RAM
backing store (NOR flash works read-only).

So if you really care about memory waste in embedded systems, you should
have a look at mm/filemap_xip.c and continue Carsten Otte's work.

Jörn

-- 
Fantasy is more important than knowledge. Knowledge is limited,
while fantasy embraces the whole world.
-- Albert Einstein
