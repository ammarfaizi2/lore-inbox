Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285063AbRLRUTX>; Tue, 18 Dec 2001 15:19:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285097AbRLRUTJ>; Tue, 18 Dec 2001 15:19:09 -0500
Received: from eos.telenet-ops.be ([195.130.132.40]:9353 "EHLO
	eos.telenet-ops.be") by vger.kernel.org with ESMTP
	id <S285067AbRLRUSq>; Tue, 18 Dec 2001 15:18:46 -0500
Date: Tue, 18 Dec 2001 21:18:39 +0100
From: Kurt Roeckx <Q@ping.be>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: wait() and strace -f
Message-ID: <20011218211839.A4447@ping.be>
In-Reply-To: <20011218021407.A1595@ping.be> <877krlc60x.fsf@devron.myhome.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <877krlc60x.fsf@devron.myhome.or.jp>; from hirofumi@mail.parknet.co.jp on Tue, Dec 18, 2001 at 04:59:58PM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2001 at 04:59:58PM +0900, OGAWA Hirofumi wrote:
> Kurt Roeckx <Q@ping.be> writes:
> 
> > I think it's related to strace being the "real" parent of the
> > child.  But that doesn't really explain why I need 2 childs.
> 
> Probably, it's feature (or bug) of strace. I'm seems, if strace has
> child, trace of a child is started before wait() of parent.  Then,
> exit() of child continue wait() of parent.

If I understand what you're saying, sleep(1) in child1, and
sleep(2) in the parent should fix the problem, which it doesn't.

And it still doesn't explain why it only happens with 2 childs.

Maybe I should have mentioned this before: the wait will clean up
the first child at the time the second child dies, or atleast
that's what wait() returns.

> >         if (!fork())
> >         {
> >                 /* Child 1. */
> 		  sleep(2);
> >                 return 0;
> >         }
> 
> The above change is continued the parent after 2 seconds.

I know that too, as I said, only when child 1 dies before the
parent calls wait().


Kurt

