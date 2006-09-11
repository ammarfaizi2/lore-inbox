Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964906AbWIKPiu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964906AbWIKPiu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 11:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964897AbWIKPiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 11:38:50 -0400
Received: from brick.kernel.dk ([62.242.22.158]:2055 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S964886AbWIKPit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 11:38:49 -0400
Date: Mon, 11 Sep 2006 17:37:06 +0200
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, Sergei Shtylyov <sshtylyov@ru.mvista.com>,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: What's in libata-dev.git
Message-ID: <20060911153706.GE4955@suse.de>
References: <20060911132250.GA5178@havoc.gtf.org> <45056627.7030202@ru.mvista.com> <450566A2.1090009@garzik.org> <450568F3.3020005@ru.mvista.com> <1157986974.23085.147.camel@localhost.localdomain> <45057651.8000404@garzik.org> <1157988513.23085.159.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1157988513.23085.159.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11 2006, Alan Cox wrote:
> Ar Llu, 2006-09-11 am 10:44 -0400, ysgrifennodd Jeff Garzik:
> > > drivers/ide. You might want to do 256 for SATA Jeff but please don't do
> > > 256 for PATA. Reading specs is too hard for some people ;)
> > > 
> > > Some drives abort the xfer, some just choked.
> > 
> > Where in drivers/ide is it limited to 255?
> 
> Being a sensible sanity check it was removed, and that was a small
> mistake. Some 2.4 also has a 256 limit and it broken various transparent
> raid units, older Maxtors(1Gb or so), some IBM drives etc. Got fixed in
> -ac but never in base.
> 
> The failure pattern is pretty ugly too, your box runs and runs and
> eventually you get a linear 256 sector I/O and it all blows up,
> sometimes. The IBM's abort the xfer but the maxtors may or may not get
> it right (its as if half the firmware has the right test).

So this is a confirmed, broken case? Why has no one complained for 2.4
and 2.6?

> We could perhaps do it by ATA version - 255 for ATA < 3 256 for ATA 3+,

Might be sane, yep.

> lots for LBA48 ? Thats assuming you can show 256 sectors is faster than
> 255. I'd bet for normal I/O its unmeasurably small.

255 isn't faster than 256, measurably. But the alignment for "natural"
transfer sizes is much nicer with 256, that's the problem. You really
don't want 248 + 8 going down all the time, for instance. Perhaps it's
not a real problem, but it could be.

-- 
Jens Axboe

