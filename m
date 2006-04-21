Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750879AbWDUAtw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750879AbWDUAtw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 20:49:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751295AbWDUAtv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 20:49:51 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:34479
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750879AbWDUAtv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 20:49:51 -0400
Date: Thu, 20 Apr 2006 17:49:39 -0700 (PDT)
Message-Id: <20060420.174939.105403265.davem@davemloft.net>
To: dlang@digitalinsight.com
Cc: torvalds@osdl.org, piet@bluelane.com, axboe@suse.de, diegocg@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.17-rc2
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.62.0604201624330.25281@qynat.qvtvafvgr.pbz>
References: <Pine.LNX.4.64.0604201512070.3701@g5.osdl.org>
	<Pine.LNX.4.64.0604201649100.3701@g5.osdl.org>
	<Pine.LNX.4.62.0604201624330.25281@qynat.qvtvafvgr.pbz>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Lang <dlang@digitalinsight.com>
Date: Thu, 20 Apr 2006 16:26:54 -0700 (PDT)

> On Thu, 20 Apr 2006, Linus Torvalds wrote:
> 
> > (Some users may even be able to take _advantage_ of the fact that the
> > buffer is "in flight" _and_ mapped into user space after it has been
> > submitted. You could imagine code that actually goes on modifying the
> > buffer even while it's being queued for sending. Under some strange
> > circumstances that may actually be useful, although with things like
> > checksums that get invalidated by you changing the data while it's queued
> > up, it may not be acceptable for everything, of course).
> 
> I could see this in some sort of logging/monitoring situation where you 
> want the latest data you can possibly get at each write. with the 
> appropriate care in write ordering you could have one thread update the 
> buffer continuously and the buffer gets written out periodicly, what gets 
> written is the latest possible info.
> 
> definantly not a common case, but I could see it's use in some cases.

And the checksums don't get invalidated, the card computes them
on transmit.

If the card cannot compute them on transmit, we will copy into a
stable kernel buffer, always.
