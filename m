Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269510AbUINRXR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269510AbUINRXR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 13:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269519AbUINRLC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 13:11:02 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:10206 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S269461AbUINRAU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 13:00:20 -0400
Date: Tue, 14 Sep 2004 19:00:19 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Andries Brouwer <Andries.Brouwer@cwi.nl>, Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [no patch] broken use of mm_release / deactivate_mm
Message-ID: <20040914170019.GA3580@MAIL.13thfloor.at>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Nick Piggin <nickpiggin@yahoo.com.au>,
	Andries Brouwer <Andries.Brouwer@cwi.nl>,
	Andrew Morton <akpm@osdl.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>
References: <20040913190633.GA22639@apps.cwi.nl> <Pine.LNX.4.58.0409131224440.2378@ppc970.osdl.org> <4146E6F0.5030405@yahoo.com.au> <Pine.LNX.4.58.0409140803090.2378@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0409140803090.2378@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2004 at 08:06:14AM -0700, Linus Torvalds wrote:
> 
> 
> On Tue, 14 Sep 2004, Nick Piggin wrote:
> > > 
> > > I agree. Looks like the "exit_mm()" should really be a "mmput()".
> > > 
> > > Can we have a few more eyes on this thing? Ingo, Nick?
> > 
> > AFAIKS yes. exit_mm doesn't look legal unless its dropping the current
> > mm context. And mmput looks like it should clean up everything - it is
> > used almost exactly the same way to cleanup a failure case in copy_mm.
> 
> Does everybody also agree that the 
> 
> 	if (p->active_mm)
> 		mmdrop(p->active_mm);
> 
> should also be dropped, and that mmput() does all of that correctly too?
> 
> (Again, looking at all the counts etc, I think the answer is a resounding 
> yes, but dammit, this code has obviously never gotten any testing at all, 
> since it effectively never happens).

IIRC, linux-vserver did hit it once or twice
but I wasn't sure at that time that it isn't my
fault ...

this 'error path' was used by the memory limiting
code, so it's probably easy to test with minor
adjustments ...

best,
Herbert

> 		Linus
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
