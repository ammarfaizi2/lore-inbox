Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264366AbRFGIQh>; Thu, 7 Jun 2001 04:16:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264365AbRFGIQ1>; Thu, 7 Jun 2001 04:16:27 -0400
Received: from www.wen-online.de ([212.223.88.39]:30469 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S264366AbRFGIQO>;
	Thu, 7 Jun 2001 04:16:14 -0400
Date: Thu, 7 Jun 2001 10:15:42 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Derek Glidden <dglidden@illusionary.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: Re: Break 2.4 VM in five easy steps
In-Reply-To: <m1y9r44t5b.fsf@frodo.biederman.org>
Message-ID: <Pine.LNX.4.33.0106071006310.8593-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 Jun 2001, Eric W. Biederman wrote:

> Mike Galbraith <mikeg@wen-online.de> writes:
>
> > On 7 Jun 2001, Eric W. Biederman wrote:
> >
> > > Does this improve the swapoff speed or just allow other programs to
> > > run at the same time?  If it is still slow under that kind of load it
> > > would be interesting to know what is taking up all time.
> > >
> > > If it is no longer slow a patch should be made and sent to Linus.
> >
> > No, it only cures the freeze.  The other appears to be the slow code
> > pointed out by Andrew Morton being tickled by dead swap pages.
>
> O.k.  I think I'm ready to nominate the dead swap pages for the big
> 2.4.x VM bug award.  So we are burning cpu cycles in sys_swapoff
> instead of being IO bound?  Just wanting to understand this the cheap way :)

There's no IO being done whatsoever (that I can see with only a blinky).
I can fire up ktrace and find out exactly what's going on if that would
be helpful.  Eating the dead swap pages from the active page list prior
to swapoff cures all but a short freeze.  Eating the rest (few of those)
might cure the rest, but I doubt it.

	-Mike

