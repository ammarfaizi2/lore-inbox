Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265499AbUGGVHa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265499AbUGGVHa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 17:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265501AbUGGVHa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 17:07:30 -0400
Received: from mail-relay-1.tiscali.it ([212.123.84.91]:42919 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S265499AbUGGVGT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 17:06:19 -0400
Date: Wed, 7 Jul 2004 23:06:08 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Chris Mason <mason@suse.com>
Cc: Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       linux-kernel@vger.kernel.org
Subject: Re: Unnecessary barrier in sync_page()?
Message-ID: <20040707210608.GS28479@dualathlon.random>
References: <20040707175724.GB3106@logos.cnet> <20040707182025.GJ28479@dualathlon.random> <20040707112953.0157383e.akpm@osdl.org> <20040707184202.GN28479@dualathlon.random> <1089233823.3956.80.camel@watt.suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1089233823.3956.80.camel@watt.suse.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 07, 2004 at 04:57:04PM -0400, Chris Mason wrote:
> I wasn't worried about the locked bit when I added the barrier, my goal
> was to order things with people that set page->mapping to null.

page->mapping cannot change from NULL to non-NULL there.

it can only change from non-NULL to NULL, and there's no way to
serialize with the truncate without taking the page lock.

The one extremely important fix you did around the same time, has been
to "cache" the value of "mapping" in the kernel stack, so that it
remains the same during the while function (so that it cannot start
non-NULL an finish NULL). But the smp_mb() itself cannot make a
difference as far as I can tell.
