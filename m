Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932389AbVKOPR3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932389AbVKOPR3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 10:17:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932535AbVKOPR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 10:17:29 -0500
Received: from gold.veritas.com ([143.127.12.110]:51647 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S932389AbVKOPR3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 10:17:29 -0500
Date: Tue, 15 Nov 2005 15:15:14 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Meelis Roos <mroos@linux.ee>
cc: Duncan Sands <baldrick@free.fr>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rc1-git1: BTTV: no picture with grabdisplay; later, an
 Oops
In-Reply-To: <20051115141305.049CF14200@rhn.tartu-labor>
Message-ID: <Pine.LNX.4.61.0511151508110.3622@goblin.wat.veritas.com>
References: <20051115141305.049CF14200@rhn.tartu-labor>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 15 Nov 2005 15:16:29.0343 (UTC) FILETIME=[8DB2DAF0:01C5E9F7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Nov 2005, Meelis Roos wrote:
> DS> When I change channels, a picture flashes onto the screen for a fraction of
> DS> a second, then the screen becomes black.  The picture glimpsed seems to be =
> DS> four
> DS> copies of the tv show, arranged in a 2x2 matrix.
> 
> Similar "Bad address" and "Invalid argument" errors here. xawtv works
> but only in overlay mode. tvtime tries non-overlay and gets these
> errors. Card is Hauppauge WinTV with bt878. 2.6.14 works.

This is likely to be due to the PageReserved changes, as were other bttv
problems reported.  We're still working on the right patch for that,
or might even revert.  In the meanwhile you could try removing the
" | VM_RESERVED" from mm/memory.c get_user_pages(), to see if that
really does correct it (though it's not the whole of the right answer).

The OOPSes Duncan saw, I don't know about those: I wouldn't expect
them to be due to this cause, but could be wrong.

Hugh
