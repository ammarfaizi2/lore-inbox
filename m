Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269201AbUIHX14@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269201AbUIHX14 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 19:27:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269212AbUIHXZc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 19:25:32 -0400
Received: from the-village.bc.nu ([81.2.110.252]:4777 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S269201AbUIHXYN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 19:24:13 -0400
Subject: Re: bug in md write barrier support?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jens Axboe <axboe@suse.de>
Cc: Neil Brown <neilb@cse.unsw.edu.au>, Christoph Hellwig <hch@lst.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040908154608.GN2258@suse.de>
References: <20040903172414.GA6771@lst.de>
	 <16697.4817.621088.474648@cse.unsw.edu.au> <20040904082121.GB2343@suse.de>
	 <16699.48946.29579.495180@cse.unsw.edu.au> <20040908092309.GD2258@suse.de>
	 <1094650500.11723.32.camel@localhost.localdomain>
	 <20040908154608.GN2258@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094682098.12280.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 08 Sep 2004 23:21:39 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-09-08 at 16:46, Jens Axboe wrote:
> That's a worry if it really does that - does it, or are you just
> speculating about possible problems?

I2O defines cache flush very losely. It flushes the cache and returns
when the cache has been flushed. From playing with the controllers I
have it seems some at least merge further queued writes into the output
stream. Thus if I issue

write 1, 2, 3, 4 , 40, 41, flush cache, write 5, 6, 100

it'll write 1,2,3,4,5,6, 40, 41, report flush cache complete. 

Obviously I can implement full barrier semantics in the driver if need
be but that would cost performance hence the question.


