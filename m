Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750752AbWGRBut@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750752AbWGRBut (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 21:50:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750781AbWGRBut
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 21:50:49 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:30125 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750752AbWGRBut (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 21:50:49 -0400
Subject: Re: kernel/timer.c: next_timer_interrupt() strange/buggy(?) code
	(2.6.18-rc1-mm2)
From: Steven Rostedt <rostedt@goodmis.org>
To: Valdis.Kletnieks@vt.edu
Cc: Andreas Mohr <andi@rhlx01.fht-esslingen.de>, linux-kernel@vger.kernel.org,
       keir@xensource.com, Tony Lindgren <tony@atomide.com>, zach@vmware.com,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <200607171957.k6HJvPHT022236@turing-police.cc.vt.edu>
References: <20060717185330.GA32264@rhlx01.fht-esslingen.de>
	 <200607171957.k6HJvPHT022236@turing-police.cc.vt.edu>
Content-Type: text/plain
Date: Mon, 17 Jul 2006 21:50:38 -0400
Message-Id: <1153187438.9932.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-07-17 at 15:57 -0400, Valdis.Kletnieks@vt.edu wrote:
> On Mon, 17 Jul 2006 20:53:30 +0200, Andreas Mohr said:
> > Hi all,
> > 
> 
> >         for (i = 0; i < 4; i++) {
> >                 j = INDEX(i);
> >                 do {
> 
> >                         if (j < (INDEX(i)) && i < 3)
> >                                 list = varray[i + 1]->vec + (INDEX(i + 1));
> >                         goto found;
> >                 } while (j != (INDEX(i)));
> >         }
> > found:
> 
> > Excuse me, but why do we have a while loop here if the last instruction in
> > the while loop is a straight "goto found"?
> 
> Consider if we take the 'goto found' when i==1.  We leave not only the do/while
> but also the for loop.  A 'continue' instead would leave the do/while and then
> drive the i==2 and subsequent 'for' iterations....
> 
> (Unless my C mastery has severely faded of late?)

No you are right.  We jump to found because we found what we are looking
for and don't need to look further in any more loops.

-- Steve


