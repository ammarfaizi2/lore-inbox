Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261269AbVABQTG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261269AbVABQTG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 11:19:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261272AbVABQTF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 11:19:05 -0500
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:29136 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S261269AbVABQTA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 11:19:00 -0500
Date: Sun, 2 Jan 2005 17:18:20 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Jens Axboe <axboe@suse.de>
Cc: William Lee Irwin III <wli@holomorphy.com>, Rik van Riel <riel@redhat.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Robert_Hentosh@Dell.com, Con Kolivas <kernel@kolivas.org>
Subject: Re: [PATCH][1/2] adjust dirty threshold for lowmem-only mappings
Message-ID: <20050102161820.GG5164@dualathlon.random>
References: <20041220125443.091a911b.akpm@osdl.org> <Pine.LNX.4.61.0412231420260.5468@chimarrao.boston.redhat.com> <20041224160136.GG4459@dualathlon.random> <Pine.LNX.4.61.0412241118590.11520@chimarrao.boston.redhat.com> <20041224164024.GK4459@dualathlon.random> <Pine.LNX.4.61.0412241711180.11520@chimarrao.boston.redhat.com> <20041225020707.GQ13747@dualathlon.random> <Pine.LNX.4.61.0412251253090.18130@chimarrao.boston.redhat.com> <20041225190710.GZ771@holomorphy.com> <20050102151147.GA1930@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050102151147.GA1930@suse.de>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 02, 2005 at 04:11:47PM +0100, Jens Axboe wrote:
> It should be lifted for block devices, it doesn't make any sense.

It cannot be lifted without:

1) creating aliasing between buffercache and blkdev pagecache
2) changing all fs to kmap around all buffercache accesses

2 would create an huge change (sure not a good idea during 2.6, 2.7 if
something). 1 would break lilo and tunefs and other things writing to a
superblock while the fs is mounted.

I effectively wrote it like 2 but I had to learn the hard way it broke
lilo in some weird configuration and IIRC Linus and Al fixed it very
nicely with current design.

There's no highmem and in turn no limit on 64bit in the first place, so
both efforts are worthless in the long term.
