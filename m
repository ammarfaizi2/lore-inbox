Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261827AbUB1Gpq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 01:45:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261823AbUB1Gpp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 01:45:45 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:38826 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S261827AbUB1Gph (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 01:45:37 -0500
Date: Fri, 27 Feb 2004 22:45:21 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrea Arcangeli <andrea@suse.de>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Hugh Dickins <hugh@veritas.com>
cc: Andrew Morton <akpm@osdl.org>, Rik van Riel <riel@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.23aa2 (bugfixes and important VM improvements for the high end)
Message-ID: <472800000.1077950719@[10.10.2.4]>
In-Reply-To: <20040228061838.GO8834@dualathlon.random>
References: <20040227173250.GC8834@dualathlon.random> <Pine.LNX.4.44.0402271350240.1747-100000@chimarrao.boston.redhat.com> <20040227122936.4c1be1fd.akpm@osdl.org> <20040227211548.GI8834@dualathlon.random> <162060000.1077919387@flay> <20040228023236.GL8834@dualathlon.random> <20040228045713.GA388@ca-server1.us.oracle.com> <20040228061838.GO8834@dualathlon.random>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> thanks for giving it a spin (btw I assume it's 2.4, that's fine for
> a quick test, and I seem not to find the 2:2 and 1:3 options in the 2.6
> kernel anymore ;).

ftp://ftp.kernel.org/pub/linux/kernel/people/mbligh/patches/2.6.3/2.6.3-mjb1/212-config_page_offset
(which sits on top of the 4/4 patches, so might need some massaging to apply)

> What I probably didn't specify yet is that 2.5:1.5 is feasible too, I've
> a fairly small and strightforward patch here from ibm that implements
> 3.5:0.5 for PAE mode (for a completely different matter, but I mean,
> it's not really a problem to do 2.5:1.5 either if needed, it's the same
> as the current PAE mode 3.5:0.5).

I'm not sure it's that straightforward really - doing the non-pgd aligned
split is messy. 2.5 might actually be much cleaner than 3.5 though, as we
never updated the mappings of the PMD that's shared between user and kernel.
Hmmm ... that's quite tempting.

> starting with the assumtion that 32G machines works with 3:1 (like they
> do in 2.4), and assuming the size of a page is 48 bytes (like in 2.4, in
> 2.6 it's a bit bigger but we can most certainly shrink it, for example
> removing rmap for anon pages will immediatly release 128M of kernel
> memory), moving from 32G to 64G means losing 384M of those additional
> 512M in pages, you can use the remaining additional 512M-384M=128M for
> vmas, task structs, files etc...  So 2.5:1.5 should be enough as far as
> the kernel is concerned to run on 64G machines (provided the page_t is
> not bigger than 2.4 which sounds feasible too).

Shrinking struct page sounds nice. Did Hugh's patch actually end up doing
that? I don't recall that, but I don't see why it wouldn't.

M.
