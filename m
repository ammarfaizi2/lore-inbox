Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261222AbULXQCG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261222AbULXQCG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Dec 2004 11:02:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbULXQCF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Dec 2004 11:02:05 -0500
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:2257 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S261222AbULXQCC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Dec 2004 11:02:02 -0500
Date: Fri, 24 Dec 2004 17:01:36 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Robert_Hentosh@Dell.com, Con Kolivas <kernel@kolivas.org>
Subject: Re: [PATCH][1/2] adjust dirty threshold for lowmem-only mappings
Message-ID: <20041224160136.GG4459@dualathlon.random>
References: <Pine.LNX.4.61.0412201013080.13935@chimarrao.boston.redhat.com> <20041220125443.091a911b.akpm@osdl.org> <Pine.LNX.4.61.0412231420260.5468@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0412231420260.5468@chimarrao.boston.redhat.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 23, 2004 at 02:21:15PM -0500, Rik van Riel wrote:
> the bug completely.  The time needed to trigger the
> bug has gone up though, from 5 minutes to a day ...

I'm running it in a loop for a day and no oom yet. This is all as well
applied to the current suse kernel and it's behaving very well so far
(well except the oom killer with oracle that in order to fix it badness
must be rewritten with a completely different algorithm). Let's limit
the workload to normal desktops for now so we don't have to change
everything at once.

Patches applied are Andrew's ignore-swap-token, Andrew's write
throttling total_scanned, Con's disable-swap-token, my oom
killer fixes (but that should not influence the write throttling), my
lowmem-reserve (that can definitely influence it on big boxes and it's a
must have for any computer with more than 1G), and a few more certainly
unrelated bits.

So I recommend you to try again with at least "Andrew's
ignore-swap-token, Andrew's total_scanned, Con's disable-swap-token and
my lowmem_reserve". Effectively disable-swap-token obsoletes
ignore-swap-token, but both makes sense together since just in case
somebody enables the feature, ignore-swap-token will give it a chance
not to generate a suprious oom kills.
