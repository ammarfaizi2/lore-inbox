Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261800AbTIYKZt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 06:25:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261802AbTIYKZt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 06:25:49 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:48542 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261800AbTIYKZn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 06:25:43 -0400
Date: Thu, 25 Sep 2003 12:25:17 +0200
From: Jens Axboe <axboe@suse.de>
To: Aaron Lehmann <aaronl@vitelus.com>
Cc: Nick Piggin <piggin@cyberone.com.au>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Complete I/O starvation with 3ware raid on 2.6
Message-ID: <20030925102517.GI15415@suse.de>
References: <20030925071252.GE22525@vitelus.com> <20030925004301.171f6645.akpm@osdl.org> <20030925075852.GI22525@vitelus.com> <20030925011052.6f8beab2.akpm@osdl.org> <20030925083142.GK22525@vitelus.com> <3F72B1BC.7080405@cyberone.com.au> <20030925101546.GL22525@vitelus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030925101546.GL22525@vitelus.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 25 2003, Aaron Lehmann wrote:
> On Thu, Sep 25, 2003 at 07:13:32PM +1000, Nick Piggin wrote:
> > But the load average will be 11 because there are processes stuck in the
> > kernel somewhere in D state. Have a look for them. They might be things
> > like pdflush, kswapd, scsi_*, etc.
> 
> They're pdflush and kjournald. I don't have sysrq support compiled in
> at the moment.
> 
> I've noticed the problem does not occur when the raid can absorb data
> faster than the other drive can throw data at it. My naive mind is
> pretty sure that this is just an issue of way too much being queued
> for writing. If someone could tell me how to control this parameter,
> I'd definately give it a try [tomorrow]. All I've found on my own is
> #define TW_Q_LENGTH 256 in 3w-xxxx.h and am not sure if this is the
> right thing to change or safe to change.

That is the right define, try setting it to something low. 8, or maybe
even 4. Don't go below 3, though.

-- 
Jens Axboe

