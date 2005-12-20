Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750802AbVLTSIP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbVLTSIP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 13:08:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750808AbVLTSIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 13:08:15 -0500
Received: from smtp.osdl.org ([65.172.181.4]:49124 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750802AbVLTSIO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 13:08:14 -0500
Date: Tue, 20 Dec 2005 10:08:07 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jens Axboe <axboe@suse.de>
cc: Ben Collins <bcollins@ubuntu.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rc6] block: Fix CDROMEJECT to work in more cases
In-Reply-To: <20051220174948.GP3734@suse.de>
Message-ID: <Pine.LNX.4.64.0512201005370.4827@g5.osdl.org>
References: <20051219195014.GA13578@swissdisk.com> <Pine.LNX.4.64.0512200930490.4827@g5.osdl.org>
 <20051220174948.GP3734@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 20 Dec 2005, Jens Axboe wrote:
> 
> WRITEs cannot have length 0, and READs cannot as well. Since it's just
> one bit for direction, those are the rules.

Jens, your logic doesn't make sense.

There clearly _are_ commands with a 0 data-length.

And commands _have_ to be either READ or WRITE. We don't have a choice. 
ll_rw_block: blk_get_request() even has a BIG_ON() that enforces that.

So claiming that reads and writes cannot have zere data-length is INSANE.

So reads and writes HAVE to accept a zero data length. End of story. If 
there is some path in the SCSI layer that refuses it, that part must be 
fixed, or you have to add a new "NONE" (and perhaps "BOTH") direction.

		Linus
