Return-Path: <linux-kernel-owner+w=401wt.eu-S965308AbXAKG55@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965308AbXAKG55 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 01:57:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965311AbXAKG55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 01:57:57 -0500
Received: from smtp.osdl.org ([65.172.181.24]:36340 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965308AbXAKG5z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 01:57:55 -0500
Date: Wed, 10 Jan 2007 22:57:20 -0800
From: Andrew Morton <akpm@osdl.org>
To: Aubrey <aubreylee@gmail.com>
Cc: "Linus Torvalds" <torvalds@osdl.org>, "Hua Zhong" <hzhong@gmail.com>,
       "Hugh Dickins" <hugh@veritas.com>, linux-kernel@vger.kernel.org,
       hch@infradead.org, kenneth.w.chen@intel.com, mjt@tls.msk.ru
Subject: Re: O_DIRECT question
Message-Id: <20070110225720.7a46e702.akpm@osdl.org>
In-Reply-To: <6d6a94c50701102245g6afe6aacxfcb2136baee5cbfa@mail.gmail.com>
References: <6d6a94c50701101857v2af1e097xde69e592135e54ae@mail.gmail.com>
	<Pine.LNX.4.64.0701101902270.3594@woody.osdl.org>
	<6d6a94c50701102150w4c3b46d0w6981267e2b873d37@mail.gmail.com>
	<20070110220603.f3685385.akpm@osdl.org>
	<6d6a94c50701102245g6afe6aacxfcb2136baee5cbfa@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Jan 2007 14:45:12 +0800
Aubrey <aubreylee@gmail.com> wrote:

> >
> > In the interim you could do the old "echo 3 > /proc/sys/vm/drop_caches"
> > thing, but that's terribly crude - drop_caches is really only for debugging
> > and benchmarking.
> >
> Yes. This method can drop caches, but will fragment memory.

That's what page reclaim will do as well.

What you want is Mel's antifragmentation work, or lumpy reclaim.

> This is
> not what I want. I want cache is limited to a tunable value of the
> whole memory. For example, if total memory is 128M, is there a way to
> trigger reclaim when cache size > 16M?

If there was, it'd "fragment memory" as well.

You might get a little benefit from increasing /proc/sys/vm/min_free_kbytes,
but not much.  Some page allocation tweaks would aid that.

But basically, to do this well, serious work is needed.

