Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750749AbVLTRsP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbVLTRsP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 12:48:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbVLTRsP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 12:48:15 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:60685 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750749AbVLTRsO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 12:48:14 -0500
Date: Tue, 20 Dec 2005 18:49:48 +0100
From: Jens Axboe <axboe@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ben Collins <bcollins@ubuntu.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rc6] block: Fix CDROMEJECT to work in more cases
Message-ID: <20051220174948.GP3734@suse.de>
References: <20051219195014.GA13578@swissdisk.com> <Pine.LNX.4.64.0512200930490.4827@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0512200930490.4827@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20 2005, Linus Torvalds wrote:
> 
> 
> On Mon, 19 Dec 2005, Ben Collins wrote:
> >
> > This changes the request to a READ instead of WRITE. Also adds and calls
> > blk_send_allow_medium_removal() for CDROMEJECT case.
> 
> Can you tell why it also does that START_STOP/1 thing? That looks a bit 
> strange. 

I still think that is weird and not something that should be merged. The
0x01 bit means load the tray and read TOC.

> Also, can somebody go through the READ/WRITE difference for me for a 
> zero-length command? If the _only_ difference is a protection one (WRITE 
> commands need write permissions), then I'm ok with this (I think it's 
> very reasonable that somebody who can read a cd-rom can also eject it), 
> but if there's some SCSI layer logic that says "writes cannot have length 
> 0", then I think that's a bug. 

It has no logical implications other than from what pool it allocates,
and we've always used the WRITE pool for these requests. There's no
protection implications.

WRITEs cannot have length 0, and READs cannot as well. Since it's just
one bit for direction, those are the rules.

-- 
Jens Axboe

