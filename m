Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261421AbUKOV7A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261421AbUKOV7A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 16:59:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261423AbUKOV67
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 16:58:59 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:43335 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261421AbUKOV4t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 16:56:49 -0500
Date: Mon, 15 Nov 2004 21:56:29 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Sami Farin <7atbggg02@sneakemail.com>
cc: linux-kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Andrea Arcangeli <andrea@novell.com>
Subject: Re: vm-pageout-throttling.patch: hanging in
    throttle_vm_writeout/blk_congestion_wait
In-Reply-To: <20041115012620.GA5750@m.safari.iki.fi>
Message-ID: <Pine.LNX.4.44.0411152140030.4171-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Nov 2004, Sami Farin wrote:
> 
> this time I had some swapspace on /dev/loop1 (file-backed, reiserfs,
> loop-AES-2.2d)...  I think (!) it caused this deadlock.

That's not at all surprising.  See the swap_extent work Andrew did
for 2.5 (in mm/swapfile.c), by which swap to a swapfile now avoids
the filesystem altogether (except while swapon prepares the map of
disk blocks).  By swapping to a loop device over a file, you're
sneaking past his work, and putting the filesystem back under swap.
It is begging for deadlocks: I'm not saying it couldn't be got to
work, and of course it would be nice to boast that there's no such
issue; but there are so many better places to invest such effort...

Hugh

