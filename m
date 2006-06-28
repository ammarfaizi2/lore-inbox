Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751009AbWF1S72@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751009AbWF1S72 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 14:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751010AbWF1S72
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 14:59:28 -0400
Received: from silver.veritas.com ([143.127.12.111]:18338 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1751008AbWF1S71
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 14:59:27 -0400
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="4.06,189,1149490800"; 
   d="scan'208"; a="39614282:sNHT2468820236"
Date: Wed, 28 Jun 2006 19:59:02 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Nigel Cunningham <nigel@suspend2.net>
cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: [Suspend2][ 15/20] [Suspend2] Attempt to freeze processes.
In-Reply-To: <200606280939.02044.nigel@suspend2.net>
Message-ID: <Pine.LNX.4.64.0606281943010.24170@blonde.wat.veritas.com>
References: <20060626223446.4050.9897.stgit@nigel.suspend2.net>
 <20060626223537.4050.72340.stgit@nigel.suspend2.net> <20060627134514.GC3019@elf.ucw.cz>
 <200606280939.02044.nigel@suspend2.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 28 Jun 2006 18:59:25.0597 (UTC) FILETIME=[F982FCD0:01C69AE4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jun 2006, Nigel Cunningham wrote:
> On Tuesday 27 June 2006 23:45, Pavel Machek wrote:
> >
> > Current code seems to free memory without need to thaw/re-freeze
> > kernel threads. Have you found bugs in that, or is this unneccessary?
> 
> Did you read my other email? Try it with a swap file on a journalled 
> filesystem, in a situation where freeing memory will force the swap file to 
> be used.

Hi Nigel,

I may have missed your "other email" in the avalanche ;)

That particular example sounds dubious to me: it may well have been
a problem on 2.4, but are you sure that it's still a problem on 2.6?

Andrew very nicely rewrote the swapfile handling, to bmap the whole
file at swapon time (see setup_swap_extents), and thereafter the only
difference between using a swapfile and using a disk partition is that
the swapfile blocks may be fragmented into many extents where the disk
partition is contiguous.  Much more reliable.

I don't see how your "journalled filesystem" would affect it at all.

Hugh
