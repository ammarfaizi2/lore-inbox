Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318196AbSIOTkn>; Sun, 15 Sep 2002 15:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318209AbSIOTkn>; Sun, 15 Sep 2002 15:40:43 -0400
Received: from dsl-213-023-020-240.arcor-ip.net ([213.23.20.240]:33664 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318196AbSIOTkm>;
	Sun, 15 Sep 2002 15:40:42 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Andrew Morton <akpm@digeo.com>, Daniel Jacobowitz <dan@debian.org>
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB changes for 2.5.34
Date: Sun, 15 Sep 2002 21:43:39 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       David Brownell <david-b@pacbell.net>,
       Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       Greg KH <greg@kroah.com>, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
References: <E17qRfU-0001qz-00@starship> <20020915190435.GA19821@nevyn.them.org> <3D84E2DB.6B189E7A@digeo.com>
In-Reply-To: <3D84E2DB.6B189E7A@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17qfIx-00008h-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 15 September 2002 21:43, Andrew Morton wrote:
> I suspect the example which you give is not a very typical one.  Generally
> people use kgdb for poking around looking at kernel state.  I almost never
> single-step.  I set breakpoints so that I can inspect state within a
> particular context, and for coverage testing ("is this path being executed").

Right, I almost never single-step either.  Probably, my favorite technique
is to replace BUG() with asm("int3").

> Also as a replacement for printk/rebuild/reboot.

Yup.  I still use a lot of printks, but they are mostly for tracing, not
triangulation.

> Also for inspecting ad-hoc instrumentation: just add `some_global_int++;'
> and then take a look at its value - much quicker than exposing it via /proc.

Yep, I noticed you doing that, very useful, I picked up that technique
from you.  Then I made a little all-purpose proc interface for myself
to make it easy to export my stats structures, which is kind of nice too,
because then you can put a patch out with the hooks still in it, making
it easier for others to participate in the analysis.

> It's also very good to have kgdb on hand when you happen to hit a
> really rare bug - I hit a weirdo request queue corruption thing the
> other day, an hour into a `dbench 1024' run.  Was able to get a
> decent amount of information.  Heaven knows how long it would take
> to make that bug trigger a second time...

Yes, this last one applies equally to kdb, but since I'm not relying
on kdb at the moment, best to leave the lid on that can of flamable
material.

-- 
Daniel
