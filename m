Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318143AbSIAWXy>; Sun, 1 Sep 2002 18:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318148AbSIAWXx>; Sun, 1 Sep 2002 18:23:53 -0400
Received: from dsl-213-023-021-067.arcor-ip.net ([213.23.21.67]:6274 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318143AbSIAWXx>;
	Sun, 1 Sep 2002 18:23:53 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Andrew Morton <akpm@zip.com.au>
Subject: Re: [RFC] [PATCH] Include LRU in page count
Date: Mon, 2 Sep 2002 00:08:22 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Christian Ehrhardt <ehrhardt@mathematik.uni-ulm.de>,
       Linus Torvalds <torvalds@transmeta.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel@vger.kernel.org
References: <3D644C70.6D100EA5@zip.com.au> <20020901212943Z16578-4014+1360@humbolt.nl.linux.org> <3D729020.4DFDAC2B@zip.com.au>
In-Reply-To: <3D729020.4DFDAC2B@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17lctL-0004cZ-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 02 September 2002 00:09, Andrew Morton wrote:
> Daniel Phillips wrote:
> > 
> > ...
> > I'm looking at your spinlock_irq now and thinking the _irq part could
> > possibly be avoided.  Can you please remind me of the motivation for this -
> > was it originally intended to address the same race we've been working on
> > here?
> > 
> 
> scalability, mainly.  If the CPU holding the lock takes an interrupt,
> all the other CPUs get to spin until the handler completes.  I measured
> a 30% reducton in contention from this.
> 
> Not a generally justifiable trick, but this is a heavily-used lock.
> All the new games in refill_inactive() are there to minimise the
> interrupt-off time.

Per-cpu lru lists?  Your solution is a lot simpler...

-- 
Daniel
