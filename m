Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750725AbVLTReS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbVLTReS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 12:34:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750739AbVLTReS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 12:34:18 -0500
Received: from smtp.osdl.org ([65.172.181.4]:47068 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750725AbVLTReS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 12:34:18 -0500
Date: Tue, 20 Dec 2005 09:34:11 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Ben Collins <bcollins@ubuntu.com>
cc: Jens Axboe <axboe@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rc6] block: Fix CDROMEJECT to work in more cases
In-Reply-To: <20051219195014.GA13578@swissdisk.com>
Message-ID: <Pine.LNX.4.64.0512200930490.4827@g5.osdl.org>
References: <20051219195014.GA13578@swissdisk.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 19 Dec 2005, Ben Collins wrote:
>
> This changes the request to a READ instead of WRITE. Also adds and calls
> blk_send_allow_medium_removal() for CDROMEJECT case.

Can you tell why it also does that START_STOP/1 thing? That looks a bit 
strange. 

Also, can somebody go through the READ/WRITE difference for me for a 
zero-length command? If the _only_ difference is a protection one (WRITE 
commands need write permissions), then I'm ok with this (I think it's 
very reasonable that somebody who can read a cd-rom can also eject it), 
but if there's some SCSI layer logic that says "writes cannot have length 
0", then I think that's a bug. 

		Linus
