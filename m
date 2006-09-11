Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932216AbWIKTwx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216AbWIKTwx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 15:52:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932144AbWIKTwx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 15:52:53 -0400
Received: from brick.kernel.dk ([62.242.22.158]:43883 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1751356AbWIKTww (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 15:52:52 -0400
Date: Mon, 11 Sep 2006 21:51:06 +0200
From: Jens Axboe <axboe@kernel.dk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jens Axboe <axboe@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jeff Garzik <jeff@garzik.org>,
       Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: What's in libata-dev.git
Message-ID: <20060911195106.GA6775@kernel.dk>
References: <20060911132250.GA5178@havoc.gtf.org> <45056627.7030202@ru.mvista.com> <450566A2.1090009@garzik.org> <450568F3.3020005@ru.mvista.com> <1157986974.23085.147.camel@localhost.localdomain> <45057651.8000404@garzik.org> <1157988513.23085.159.camel@localhost.localdomain> <20060911153706.GE4955@suse.de> <Pine.LNX.4.64.0609110850380.27779@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609110850380.27779@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11 2006, Linus Torvalds wrote:
> 
> 
> On Mon, 11 Sep 2006, Jens Axboe wrote:
> > 
> > So this is a confirmed, broken case? Why has no one complained for 2.4
> > and 2.6?
> 
> Oh, I didn't even notice that we do that by default already. That's a bit 
> scary - I remember people having their disks trashed.
> 
> Maybe the broken disks are old enough to not be an issue any more, or 
> maybe something else makes it effectively impossible to trigger in 
> practice?

Well, as I said, I don't think we ever saw a case that was demonstrably
due to the 256 sector issue. And I really don't think it is as obscure a
fact that people seem to think it is.

> You do need to get 32 pages of contiguous IO for it to happen, and while I 
> don't see anything else that would limit it, maybe there is something that 
> does? (Some other limiter like max_phys_segments might, but that 
> particular one defaults to much more than 32)

It should be pretty trivial to reach, the other IDE limits are basically
way beyond 128kb of contig io. People are hitting this during boot even
I bet, so...

> Of course, we do hopefully handle requests that fail a lot more 
> gracefully these days, so if the drive says it didn't do it, maybe we just 
> fix it up properly, in a way we didn't use to.. Ie we may have fixed the 
> thing that caused corruption just by fixing something else ;)

If the firmware is really buggy in that it doesn't recognise the 0 case
as being 256, you'd see immediate transfer errors. This going by
unnoticed is highly unlikely.

-- 
Jens Axboe

