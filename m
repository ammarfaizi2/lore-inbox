Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273658AbRIQPyc>; Mon, 17 Sep 2001 11:54:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273660AbRIQPyX>; Mon, 17 Sep 2001 11:54:23 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:35153 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S273658AbRIQPyO>; Mon, 17 Sep 2001 11:54:14 -0400
To: Rik van Riel <riel@conectiva.com.br>
Cc: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: broken VM in 2.4.10-pre9
In-Reply-To: <Pine.LNX.4.33L.0109170909270.2990-100000@imladris.rielhome.conectiva>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 17 Sep 2001 09:45:49 -0600
In-Reply-To: <Pine.LNX.4.33L.0109170909270.2990-100000@imladris.rielhome.conectiva>
Message-ID: <m1adztstw2.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel <riel@conectiva.com.br> writes:

> On 17 Sep 2001, Eric W. Biederman wrote:
> 
> > There is an alternative approach to have better aging information.
> 
> [snip incomplete description of data structure]
> 
> What you didn't explain is how your idea is related to
> aging.

Sorry I thought you had been staring at the problem long enough to
see.  In any case the problem with the current code is that you can't
put all pages in the swap cache immediately because you don't want to
allocate the swap space just yet.  And without being in the swap cache
aging isn't especially effective.

By using something like a shared memory segment behind every anonymous
page, you can put the page in the swap cache before you allocate swap
for it (because it has a persistent identity).   Further since you no
longer need counts for every swap page.  You can deallocate swap space
from pages simply by walking through the ``indirect pages'' and
removing the reference to swap space.

> > > For 2.5 I'm making a VM subsystem with reverse mappings, the
> > > first iterations are giving very sweet performance so I will
> > > continue with this project regardless of what other kernel
> > > hackers might say ;)
> >
> > Do you have any arguments for the reverse mappings or just for some of
> > the other side effects that go along with them?
> 
> Mainly for the side effects, but until somebody comes
> up with another idea to achieve all the side effects I'm
> not giving up on reverse mappings. If you can achieve
> all the good stuff in another way, show it.

I think I can I haven't had time to implement it.  Given the way Alan
and some of the others were talking I though my idea has long ago been
thought of and put on the plate for 2.5.  If it really is a new idea
under the sun I'll look at implementing it as soon as I have a hole
in my schedule.

Eric
