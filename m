Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262217AbSJAR7i>; Tue, 1 Oct 2002 13:59:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262218AbSJAR7h>; Tue, 1 Oct 2002 13:59:37 -0400
Received: from dsl-213-023-043-077.arcor-ip.net ([213.23.43.77]:54940 "EHLO
	starship") by vger.kernel.org with ESMTP id <S262217AbSJAR7g>;
	Tue, 1 Oct 2002 13:59:36 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Jens Axboe <axboe@suse.de>
Subject: Re: 2.4 mm trouble [possible lru race]
Date: Tue, 1 Oct 2002 20:01:10 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Rik van Riel <riel@conectiva.com.br>,
       Richard.Zidlicky@stud.informatik.uni-erlangen.de, zippel@linux-m68k.org,
       linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44L.0210011356300.653-100000@duckman.distro.conectiva> <E17wQXN-0005vL-00@starship> <20021001173119.GY3867@suse.de>
In-Reply-To: <20021001173119.GY3867@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17wRKZ-0005vf-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 01 October 2002 19:31, Jens Axboe wrote:
> On Tue, Oct 01 2002, Daniel Phillips wrote:
> > On Tuesday 01 October 2002 18:56, Rik van Riel wrote:
> > > On Tue, 1 Oct 2002, Daniel Phillips wrote:
> > > > On Tuesday 01 October 2002 16:20, Richard.Zidlicky@stud.informatik.uni-erlangen.de wrote:
> > > > > no preempt or anything fancy, m68k vanila 2.4.19 (well almost).
> > > >
> > > > Vanilla would be CONFIG_SMP=y, is that what you have?
> > > 
> > > Somehow I doubt Linux supports m68k SMP machines ;)
> > 
> > CONFIG_SMP=y works perfectly well on single cpu machines - it forces
> > the spinlocks to actually exist.  It's not supposed to change any
> > behaviour, but you never know.  Behaviour is obviously changing here.
> 
> Again, m68k was the target.

Sure fine, no good reason to be cryptic about it though.

   #error "m68k doesn't do SMP yet"

So SMP must be off or the compile would abort.  Well, the only interesting
difference remaining is the extra count for the LRU.  I actually had that
parameterized at one time so you could turn it on/off easily, but akpm
complained about #ifdef's so I took that out ;-)

Richard, before I go making a test patch for you (it's not completely
straightforward) can you confirm that your bug comes back when you back
the lru race patch out?

-- 
Daniel
