Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751143AbVLLRSb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbVLLRSb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 12:18:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751256AbVLLRSb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 12:18:31 -0500
Received: from smtp.osdl.org ([65.172.181.4]:53193 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751143AbVLLRSa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 12:18:30 -0500
Date: Mon, 12 Dec 2005 09:17:32 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Paul Mackerras <paulus@samba.org>, Jens Axboe <axboe@suse.de>,
       Brian King <brking@us.ibm.com>
Subject: Re: Memory corruption & SCSI in 2.6.15
In-Reply-To: <1134371606.6989.95.camel@gaston>
Message-ID: <Pine.LNX.4.64.0512120909460.15597@g5.osdl.org>
References: <1134371606.6989.95.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 12 Dec 2005, Benjamin Herrenschmidt wrote:
> 
> Current -git as of today (that is 2.6.15-rc5 + the batch of fixes Linus
> pulled after his return) was dying in weird ways for me on POWER5. I had
> the good idea to activate slab debugging, and I now see it detecting
> slab corruption as soon as the IPR driver initializes.
> 
> Since I remember seeing a discussion somewhere on a list between Brian
> King and Jens Axboe about use-after-free problems in SCSI and possible
> other niceties of that sort, I though it might be related...
> 
> Anything I can do to help track this down ?

If it's easily repeatable, doing a "git bisect" to see when it starts 
happening is the obvious big sledge-hammer thing to try. Even if you don't 
bisect all the way, just narrowing it down a bit more might help.

Also, enabling DEBUG_PAGEALLOC might help, but that's not available on 
powerpc.

There's a raid1 use-after-free bugfix that I just merged and pushed out, 
but I doubt that one is relevant. But you might try to update.

		Linus
