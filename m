Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261604AbULZDIJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261604AbULZDIJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Dec 2004 22:08:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbULZDIJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Dec 2004 22:08:09 -0500
Received: from holomorphy.com ([207.189.100.168]:42694 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261604AbULZDHs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Dec 2004 22:07:48 -0500
Date: Sat, 25 Dec 2004 19:07:21 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Rik van Riel <riel@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Robert_Hentosh@Dell.com,
       Con Kolivas <kernel@kolivas.org>
Subject: Re: [PATCH][1/2] adjust dirty threshold for lowmem-only mappings
Message-ID: <20041226030721.GA771@holomorphy.com>
References: <20041220125443.091a911b.akpm@osdl.org> <Pine.LNX.4.61.0412231420260.5468@chimarrao.boston.redhat.com> <20041224160136.GG4459@dualathlon.random> <Pine.LNX.4.61.0412241118590.11520@chimarrao.boston.redhat.com> <20041224164024.GK4459@dualathlon.random> <Pine.LNX.4.61.0412241711180.11520@chimarrao.boston.redhat.com> <20041225020707.GQ13747@dualathlon.random> <Pine.LNX.4.61.0412251253090.18130@chimarrao.boston.redhat.com> <20041225190710.GZ771@holomorphy.com> <20041225200349.GA11116@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041225200349.GA11116@dualathlon.random>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 25, 2004 at 11:07:10AM -0800, William Lee Irwin III wrote:
>> Lifting the artificial lowmem restrictions on blockdev mappings
>> (thereby nuking mapping->gfp_mask altogether) would resolve a number of
>> problems, not that anything making that much sense could ever happen.

On Sat, Dec 25, 2004 at 09:03:49PM +0100, Andrea Arcangeli wrote:
> I recall that such restriction is needed only for the buffercache, or
> you'd need to change _all_ the fs to kmap before accessing metadata
> (this is partly already happening for the dir in pagecache, but not for
> everything else).
> Whatever the problem is (assuming there's really a problem in the write
> throttling) it isn't going away by eliminating that restriction. Just
> think booting with mem=800M, it would run into the same issue that
> happens right now with the artificial limitation and >=1G of ram.
> 2.4 has the same limitation and it has no problem with write throttling
> (and from my part 2.6 is working fine too with the 4 patches I posted,
> it's not me being able to reproduce it).

The problem as posed is that the dirty memory limits are global, but
ZONE_NORMAL can be overwhelmed by dirty memory. bdev pagecache is as
surely subject to the zone limits as all others, but overwhelms them
and is not pressured because globally the thresholds are not tripped.

The sheer idiocy of physical placement restrictions imposed on behalf
of software is merely what's being exploited to artificially create
such a situation for a testcase and what users are tripping over daily.


-- wli
