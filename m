Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269379AbUINPOe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269379AbUINPOe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 11:14:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269267AbUINPNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 11:13:18 -0400
Received: from fw.osdl.org ([65.172.181.6]:50121 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269384AbUINPL3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 11:11:29 -0400
Date: Tue, 14 Sep 2004 08:06:14 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Andries Brouwer <Andries.Brouwer@cwi.nl>, Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [no patch] broken use of mm_release / deactivate_mm
In-Reply-To: <4146E6F0.5030405@yahoo.com.au>
Message-ID: <Pine.LNX.4.58.0409140803090.2378@ppc970.osdl.org>
References: <20040913190633.GA22639@apps.cwi.nl> <Pine.LNX.4.58.0409131224440.2378@ppc970.osdl.org>
 <4146E6F0.5030405@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 14 Sep 2004, Nick Piggin wrote:
> > 
> > I agree. Looks like the "exit_mm()" should really be a "mmput()".
> > 
> > Can we have a few more eyes on this thing? Ingo, Nick?
> 
> AFAIKS yes. exit_mm doesn't look legal unless its dropping the current
> mm context. And mmput looks like it should clean up everything - it is
> used almost exactly the same way to cleanup a failure case in copy_mm.

Does everybody also agree that the 

	if (p->active_mm)
		mmdrop(p->active_mm);

should also be dropped, and that mmput() does all of that correctly too?

(Again, looking at all the counts etc, I think the answer is a resounding 
yes, but dammit, this code has obviously never gotten any testing at all, 
since it effectively never happens).

		Linus
