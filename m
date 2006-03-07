Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751142AbWCGRN3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbWCGRN3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 12:13:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbWCGRN3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 12:13:29 -0500
Received: from smtp.osdl.org ([65.172.181.4]:7622 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751142AbWCGRN3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 12:13:29 -0500
Date: Tue, 7 Mar 2006 09:12:59 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
cc: Jesper Juhl <jesper.juhl@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, markhe@nextd.demon.co.uk,
       Andrea Arcangeli <andrea@suse.de>, Mike Christie <michaelc@cs.wisc.edu>,
       James Bottomley <James.Bottomley@steeleye.com>,
       Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] slab: fix offslab_limit in calculate_slab_order (Was:
 Slab corruption in 2.6.16-rc5-mm2)
In-Reply-To: <Pine.LNX.4.58.0603071042370.18351@sbz-30.cs.Helsinki.FI>
Message-ID: <Pine.LNX.4.64.0603070911380.3573@g5.osdl.org>
References: <200603060117.16484.jesper.juhl@gmail.com> 
 <Pine.LNX.4.64.0603061122270.13139@g5.osdl.org>  <Pine.LNX.4.64.0603061147260.13139@g5.osdl.org>
  <200603062136.17098.jesper.juhl@gmail.com> 
 <9a8748490603061253u5e4d7561vd4e566f5798a5f4@mail.gmail.com> 
 <9a8748490603061256h794c5af9wa6fbb616e8ddbd89@mail.gmail.com> 
 <Pine.LNX.4.64.0603061306300.13139@g5.osdl.org>
 <9a8748490603061354vaa53c72na161d26065b9302e@mail.gmail.com>
 <Pine.LNX.4.64.0603061402410.13139@g5.osdl.org> <Pine.LNX.4.64.0603061423160.13139@g5.osdl.org>
 <Pine.LNX.4.58.0603071042370.18351@sbz-30.cs.Helsinki.FI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 7 Mar 2006, Pekka J Enberg wrote:
> 
> No you're not, it's broken. However, I think you're forgetting to reset 
> cachep->num when we go over MAX_GFP_ORDER, no?

No, we only ever set "cachep->num" for something that we've decided is 
valid.

"gfporder" can never be > MAX_GFP_ORDER inside the loop, because we just 
iterate between 0..MAX_GFP_ORDER.

		Linus
