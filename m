Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751572AbWCGTVk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751572AbWCGTVk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 14:21:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751573AbWCGTVk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 14:21:40 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:59272 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1751569AbWCGTVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 14:21:39 -0500
Subject: Re: [PATCH] slab: fix offslab_limit in calculate_slab_order (Was:
	Slab corruption in 2.6.16-rc5-mm2)
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jesper Juhl <jesper.juhl@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, markhe@nextd.demon.co.uk,
       Andrea Arcangeli <andrea@suse.de>, Mike Christie <michaelc@cs.wisc.edu>,
       James Bottomley <James.Bottomley@steeleye.com>,
       Jens Axboe <axboe@suse.de>
In-Reply-To: <Pine.LNX.4.64.0603070911380.3573@g5.osdl.org>
References: <200603060117.16484.jesper.juhl@gmail.com>
	 <Pine.LNX.4.64.0603061122270.13139@g5.osdl.org>
	 <Pine.LNX.4.64.0603061147260.13139@g5.osdl.org>
	 <200603062136.17098.jesper.juhl@gmail.com>
	 <9a8748490603061253u5e4d7561vd4e566f5798a5f4@mail.gmail.com>
	 <9a8748490603061256h794c5af9wa6fbb616e8ddbd89@mail.gmail.com>
	 <Pine.LNX.4.64.0603061306300.13139@g5.osdl.org>
	 <9a8748490603061354vaa53c72na161d26065b9302e@mail.gmail.com>
	 <Pine.LNX.4.64.0603061402410.13139@g5.osdl.org>
	 <Pine.LNX.4.64.0603061423160.13139@g5.osdl.org>
	 <Pine.LNX.4.58.0603071042370.18351@sbz-30.cs.Helsinki.FI>
	 <Pine.LNX.4.64.0603070911380.3573@g5.osdl.org>
Date: Tue, 07 Mar 2006 21:21:27 +0200
Message-Id: <1141759287.11197.5.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Mar 2006, Pekka J Enberg wrote:
> > No you're not, it's broken. However, I think you're forgetting to reset 
> > cachep->num when we go over MAX_GFP_ORDER, no?

On Tue, 2006-03-07 at 09:12 -0800, Linus Torvalds wrote:
> No, we only ever set "cachep->num" for something that we've decided is 
> valid.
> 
> "gfporder" can never be > MAX_GFP_ORDER inside the loop, because we just 
> iterate between 0..MAX_GFP_ORDER.

I don't think that's true. We set cachep->num to something we think is
valid but check for internal fragmentation later. So I think we can get
out of the loop with cachep->num initialized to non-zero but gfporder
set to MAX_GFP_ORDER, no? Or did I forget to take my medicine this
morning...?

			Pekka

