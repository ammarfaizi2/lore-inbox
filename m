Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751155AbWDTTj7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbWDTTj7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 15:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbWDTTj7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 15:39:59 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:47029
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751155AbWDTTj6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 15:39:58 -0400
Date: Thu, 20 Apr 2006 12:39:48 -0700 (PDT)
Message-Id: <20060420.123948.52057640.davem@davemloft.net>
To: axboe@suse.de
Cc: torvalds@osdl.org, diegocg@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.17-rc2
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060420193430.GH4717@suse.de>
References: <20060420145041.GE4717@suse.de>
	<20060420.122647.03915644.davem@davemloft.net>
	<20060420193430.GH4717@suse.de>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jens Axboe <axboe@suse.de>
Date: Thu, 20 Apr 2006 21:34:31 +0200

> It should be able to, yes. Seems to me it should just work like regular
> splicing, with the difference that you'd have to wait for the reference
> count to drop before reusing. One way would be to do as Linus suggests
> and make the vmsplice call block or just return -EAGAIN if we are not
> ready yet. With that pollable, that should suffice?

Yes.

We really can't block on this, but I guess we could consider allowing
that for really dumb applications.

It does indeed require some smarts in the application to field the
events, but by definition of using this splice stuff there is explicit
knowledge in the application of what's going on.

This is why I'm very hesitant to say "yeah, blocking on the socket is
OK", because to be honest it's not.  As long as the socket buffer
limits haven't been reached, we really shouldn't block so the user can
go and do more work and create more transmit data in time to keep the
network pipe full.

