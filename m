Return-Path: <linux-kernel-owner+w=401wt.eu-S965289AbXAKGGl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965289AbXAKGGl (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 01:06:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965295AbXAKGGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 01:06:41 -0500
Received: from smtp.osdl.org ([65.172.181.24]:32827 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965289AbXAKGGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 01:06:40 -0500
Date: Wed, 10 Jan 2007 22:06:03 -0800
From: Andrew Morton <akpm@osdl.org>
To: Aubrey <aubreylee@gmail.com>
Cc: "Linus Torvalds" <torvalds@osdl.org>, "Hua Zhong" <hzhong@gmail.com>,
       "Hugh Dickins" <hugh@veritas.com>, linux-kernel@vger.kernel.org,
       hch@infradead.org, kenneth.w.chen@intel.com, mjt@tls.msk.ru
Subject: Re: O_DIRECT question
Message-Id: <20070110220603.f3685385.akpm@osdl.org>
In-Reply-To: <6d6a94c50701102150w4c3b46d0w6981267e2b873d37@mail.gmail.com>
References: <6d6a94c50701101857v2af1e097xde69e592135e54ae@mail.gmail.com>
	<Pine.LNX.4.64.0701101902270.3594@woody.osdl.org>
	<6d6a94c50701102150w4c3b46d0w6981267e2b873d37@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Jan 2007 13:50:53 +0800
Aubrey <aubreylee@gmail.com> wrote:

> Firstly I want to say I'm working on no-mmu arch and uClinux.
> After much of file operations VFS cache eat up all of the memory.
> At this time, if an application request memory which order > 3, the
> kernel will report failure.

nommu kernels should probably run reclaim for higher-order allocations as
well.

That's rather a blunt instrument.  The "lumpy reclaim" patches in -mm
provide a much better approach, but they need more work yet (although I
don't immediately recall what's needed).

In the interim you could do the old "echo 3 > /proc/sys/vm/drop_caches"
thing, but that's terribly crude - drop_caches is really only for debugging
and benchmarking.
