Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267377AbUG2J1z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267377AbUG2J1z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 05:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267358AbUG2J1z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 05:27:55 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:63760 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S267419AbUG2JZt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 05:25:49 -0400
To: Paul Jackson <pj@sgi.com>
Cc: aebr@win.tue.nl, vojtech@suse.cz, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix NR_KEYS off-by-one error
References: <87llhjlxjk.fsf@devron.myhome.or.jp>
	<20040716164435.GA8078@ucw.cz>
	<20040716201523.GC5518@pclin040.win.tue.nl>
	<871xjbkv8g.fsf@devron.myhome.or.jp>
	<20040728115130.GA4008@pclin040.win.tue.nl>
	<87fz7c9j0y.fsf@devron.myhome.or.jp>
	<20040728134202.5938b275.pj@sgi.com>
	<87llh3ihcn.fsf@ibmpc.myhome.or.jp>
	<20040728231548.4edebd5b.pj@sgi.com>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Thu, 29 Jul 2004 18:24:46 +0900
In-Reply-To: <20040728231548.4edebd5b.pj@sgi.com>
Message-ID: <87oelzjhcx.fsf@ibmpc.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3.50
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> writes:

> > +	unsigned char s, i;
> > +	unsigned short v;
> 
> would limit s, i, and v if struct kbentry was changed to have
> larger types (short or int, say) for these.
> 
> Good point.
> 
> Would it work to use larger types for local variables s, i, and v now,
> in order to avoid the ugly macro, as in:
> 
> 	unsigned int s, i, v;

Yes.

> > Anyhow these will be warned by gcc.
> 
> If larger types, as I wrote above, were used for s, i, and v,
> then does gcc still warn?

Probably gcc not warn, I think.

> > Although overhead is insignificance, I'd hated to add overhead of this
> > test because test is not needed right now.
> 
> Code clarity matters most here.  If the code had been crystal clear
> to the casual reader, then the initial mistake, of removing the
> range checking, probably would never have occurred in the first place,
> and we human beings would have already saved more time than we can ever
> hope to save by optimizing this code.
> 
> You are absolutely correct that overhead is insignificant.
> 
> But code clarity - that is very significant <smile>.
> 
> Let all the essential details be spelled out, in the simplest
> most easily read, C statements that can be found to express it.
> 
> Each line of code we put in the kernel will be read by many people
> doing various things.  They will be more likely to have a correct
> understanding of our code if it is clear and simple, with a minimum
> of surprises.

Yes, I agree. But sorry, honestly I didn't see any big cleanup in your patch.
It's still using s/v/i... it is same readability at least for me...
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
