Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964852AbWEaG5R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964852AbWEaG5R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 02:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964849AbWEaG5R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 02:57:17 -0400
Received: from gate.crashing.org ([63.228.1.57]:59787 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S964847AbWEaG5R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 02:57:17 -0400
Subject: Re: [git patch] libata resume fix
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jens Axboe <axboe@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Mark Lord <liml@rtr.ca>,
       Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060531064730.GG29535@suse.de>
References: <20060528203419.GA15087@havoc.gtf.org>
	 <1148938482.5959.27.camel@localhost.localdomain> <447C4718.6090802@rtr.ca>
	 <Pine.LNX.4.64.0605301122340.5623@g5.osdl.org>
	 <1149028674.9986.71.camel@localhost.localdomain>
	 <20060531064730.GG29535@suse.de>
Content-Type: text/plain
Date: Wed, 31 May 2006 16:56:45 +1000
Message-Id: <1149058605.766.45.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> In reality it probably doesn't matter much, since everything will be
> stalled until the queue is unfrozen anyways. Unless of course you have
> several slow-to-resume devices so you would at least get some overlap.
> But it would be nicer from a design view point.

In practice, it would be nice because most of X would restore while you
wait, it generally doesn't need the disk to do so unless you are heavy
on swap (or used suspend-to-disk :), that's one example among others...

At least letting other drivers restore in parallel, will improve things,
even if actual running of userland programs might still be stalled until
the disk kicks back in. But the whole experience of waking up the
machine will be improved from a black text screen waiting for the drive
to spin up ... :)

Ben.


