Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261296AbVABR31@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261296AbVABR31 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 12:29:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261297AbVABR30
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 12:29:26 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:50439
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261296AbVABR3V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 12:29:21 -0500
Date: Sun, 2 Jan 2005 18:29:29 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       robert_hentosh@dell.com
Subject: Re: [PATCH][2/2] do not OOM kill if we skip writing many pages
Message-ID: <20050102172929.GL5164@dualathlon.random>
References: <Pine.LNX.4.61.0412201013420.13935@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0412201013420.13935@chimarrao.boston.redhat.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2004 at 10:17:28AM -0500, Rik van Riel wrote:
> Simply running "dd if=/dev/zero of=/dev/hd<one you can miss>" will
> result in OOM kills, with the dirty pagecache completely filling up
> lowmem.  This patch is part 2 to fixing that problem.
> 
> Note that this test case demonstrates that the false OOM kills can
> also be reproduced with pages that are not "pinned" by the swap token
> at all, so there are some serious VM problems left still...
> 
> If we cannot write out a number of pages because of congestion on
> the filesystem or block device, do not cause an OOM kill.  These
> pages will become freeable later, when the congestion clears.

I don't like this one, it's much less obvious than 1/2. After your
obviously right 1/2 we're already guaranteed at least a percentage of
the ram will not be dirty. Is the below really needed even after 1/2 +
Andrew's fix? Are you sure this isn't a workaround for the lack of
Andrew's fix.

This 2/2 is absolutely generic, not related to highmem, and I'm at least
not having problem with Andrew's patch applied.

The conditional to out_of_memory especially looks not good, and I'm
scared it could generate livelocks.

I'm going to apply both your 1/2 and I already applied Andrew's
total_scanned, but from my part I'm not applying this 2/2. I believe to
be already safe with total_scanned + 1/2.
