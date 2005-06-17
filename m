Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262004AbVFQPv0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262004AbVFQPv0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 11:51:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262005AbVFQPv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 11:51:26 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:62545
	"EHLO g5.random") by vger.kernel.org with ESMTP id S262004AbVFQPvV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 11:51:21 -0400
Date: Fri, 17 Jun 2005 17:51:08 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Jens Axboe <axboe@suse.de>
Cc: spaminos-ker@yahoo.com, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: cfq misbehaving on 2.6.11-1.14_FC3
Message-ID: <20050617155108.GX9664@g5.random>
References: <20050614000352.7289d8f1.akpm@osdl.org> <20050614232154.17077.qmail@web30701.mail.mud.yahoo.com> <20050617141039.GL6957@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050617141039.GL6957@suse.de>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2005 at 04:10:40PM +0200, Jens Axboe wrote:
> Perhaps rmap could be used to lookup who has a specific page mapped...

I doubt, the computing and locking cost for every single page write
would be probably too high. Doing it during swapping isn't a big deal
since cpu is mostly idle during swapouts, but doing it all the time
sounds a bit overkill.

A mechanism to pass down a pid would be much better. However I'm unsure
where you could put the info while dirtying the page. If it was an uid
it might be reasonable to have it in the address_space, but if you want
a pid as index, then it'd need to go in the page_t, which would waste
tons of space. Having a pid in the address space, may not work well with
a database or some other app with multiple processes.
