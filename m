Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132736AbRDQQIW>; Tue, 17 Apr 2001 12:08:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132737AbRDQQIN>; Tue, 17 Apr 2001 12:08:13 -0400
Received: from stanis.onastick.net ([207.96.1.49]:53258 "EHLO
	stanis.onastick.net") by vger.kernel.org with ESMTP
	id <S132736AbRDQQID>; Tue, 17 Apr 2001 12:08:03 -0400
Date: Tue, 17 Apr 2001 12:07:56 -0400
From: Disconnect <lkml@sigkill.net>
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: RFC: pageable kernel-segments
Message-ID: <20010417120756.C11536@sigkill.net>
In-Reply-To: <27525795B28BD311B28D00500481B7601F11D9@ftrs1.intranet.ftr.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <27525795B28BD311B28D00500481B7601F11D9@ftrs1.intranet.ftr.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Apr 2001, Heusden, Folkert van did have cause to say:

> I would think is usable (for example) for my 8MB ram laptop.
> Anyone any thoughts on this?

I'm not a kernel hacker, but I've got some thoughts on this:

1> Modules (with the autoloader) can do that for anything not necessary to
boot. (Although even modules could lose a few pages after they
load/init/etc.  Hardware setup tends to only happen once..)

2> It'd be great for embedded systems.  But you'd need a "scale" -
something along the lines of "Page this out, compress it, step on it,
forget it, we'll never need it in a hurry" up through "page this out if
you -absolutely- have to, but make it easily accessible as fast as
possible".

3> It would involve a major kernel rewrite before it was anything more
than a slowdown to a few drivers supporting it.  And there would probably
need to be some /proc method of forbidding paging on certain
(modules/segments/etc) so that, for example, people who hit the
least-likely-path (most-likely-to-page-out) on a regular basis can disable
paging of that section/module/driver/whatnot.


-----BEGIN GEEK CODE BLOCK-----
Version: 3.1 [www.ebb.org/ungeek]
GIT/CC/CM/AT d--(-)@ s+:-- a-->? C++++$ ULBS*++++$ P+>+++ L++++>+++++ 
E--- W+++ N+@ o+>$ K? w--->+++++ O- M V-- PS+() PE Y+@ PGP++() t 5--- 
X-- R tv+@ b++++>$ DI++++ D++(+++) G++ e* h(-)* r++ y++
------END GEEK CODE BLOCK------
