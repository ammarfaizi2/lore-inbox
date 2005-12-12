Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932134AbVLLScO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932134AbVLLScO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 13:32:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932142AbVLLScO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 13:32:14 -0500
Received: from api.pobox.com ([208.210.124.75]:24015 "EHLO thorn.pobox.com")
	by vger.kernel.org with ESMTP id S932138AbVLLScN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 13:32:13 -0500
Date: Mon, 12 Dec 2005 13:32:01 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Paul Mackerras <paulus@samba.org>, Jens Axboe <axboe@suse.de>,
       Brian King <brking@us.ibm.com>
Subject: Re: Memory corruption & SCSI in 2.6.15
Message-ID: <20051212183201.GA19599@localhost.localdomain>
References: <1134371606.6989.95.camel@gaston> <Pine.LNX.4.64.0512120909460.15597@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0512120909460.15597@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Mon, 12 Dec 2005, Benjamin Herrenschmidt wrote:
> > 
> > Current -git as of today (that is 2.6.15-rc5 + the batch of fixes Linus
> > pulled after his return) was dying in weird ways for me on POWER5. I had
> > the good idea to activate slab debugging, and I now see it detecting
> > slab corruption as soon as the IPR driver initializes.
> > 
> > Since I remember seeing a discussion somewhere on a list between Brian
> > King and Jens Axboe about use-after-free problems in SCSI and possible
> > other niceties of that sort, I though it might be related...
> > 
> > Anything I can do to help track this down ?
> 
> If it's easily repeatable, doing a "git bisect" to see when it starts 
> happening is the obvious big sledge-hammer thing to try. Even if you don't 
> bisect all the way, just narrowing it down a bit more might help.

I manually narrowed this down to between 2.6.14-git14 (good) and
2.6.15-rc1 (bad).  Will try git bisection later today.

> There's a raid1 use-after-free bugfix that I just merged and pushed out, 
> but I doubt that one is relevant. But you might try to update.

FWIW, I'm hitting this in a non-raid setup.
