Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267793AbTAMPlV>; Mon, 13 Jan 2003 10:41:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267799AbTAMPlV>; Mon, 13 Jan 2003 10:41:21 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:45734 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S267793AbTAMPlU>;
	Mon, 13 Jan 2003 10:41:20 -0500
Date: Mon, 13 Jan 2003 16:49:54 +0100
From: Jens Axboe <axboe@suse.de>
To: terje.eggestad@scali.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: any chance of 2.6.0-test*?
Message-ID: <20030113154954.GR14017@suse.de>
References: <Pine.LNX.4.44.0301121100380.14031-100000@home.transmeta.com> <1042400094.1208.26.camel@RobsPC.RobertWilkens.com> <1042400219.1208.29.camel@RobsPC.RobertWilkens.com> <20030112195347.GJ3515@louise.pinerecords.com> <1042401817.1209.54.camel@RobsPC.RobertWilkens.com> <1042472605.5404.72.camel@pc-16.office.scali.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1042472605.5404.72.camel@pc-16.office.scali.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13 2003, Terje Eggestad wrote:
> Considering that doing kernel development is hard enough, new
> development is almost always done on uni processors kernels that do only
> one thing at the time. Then when you base logic is OK, you move to a
> SMP, which means (adding and) debugging you spin locks.

Goto's aside, I find the above extremely bad advise. You should _always_
develop with smp and for smp from the very start, or you will most
likely not get it right later on. With preempt, this becomes even more
important.

> Considering that fucking up spin locks are prone to corrupting your
> machine, one very simple trick to makeing fewer mistakes to to have one,
> and only one, unlock for every lock. 

Taking a spin lock twice will hard lock the machine, however on smp you
will typically have the luxury of an nmi watchdog which will help you
solve this quickly. Double unlock will oops immediately if you run with
spin lock debugging (you probably should, if you are developing kernel
code).

-- 
Jens Axboe

