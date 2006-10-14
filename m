Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932318AbWJNRu2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932318AbWJNRu2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 13:50:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422726AbWJNRu2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 13:50:28 -0400
Received: from mail.gmx.de ([213.165.64.20]:49879 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932321AbWJNRu1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 13:50:27 -0400
X-Authenticated: #14349625
Subject: Re: sluggish system responsiveness under higher IO load
From: Mike Galbraith <efault@gmx.de>
To: Matthias Dahl <mlkernel@mortal-soul.de>
Cc: Paolo Ornati <ornati@fastwebnet.it>, Jens Axboe <axboe@suse.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200610141639.58374.mlkernel@mortal-soul.de>
References: <200608061200.37701.mlkernel@mortal-soul.de>
	 <200608131815.12873.mlkernel@mortal-soul.de>
	 <20061006175833.4ef08f06@localhost>
	 <200610141639.58374.mlkernel@mortal-soul.de>
Content-Type: text/plain
Date: Sat, 14 Oct 2006 18:20:46 +0000
Message-Id: <1160850046.13212.30.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

On Sat, 2006-10-14 at 16:39 +0200, Matthias Dahl wrote:
> On Friday 06 October 2006 17:58, Paolo Ornati wrote:
> 
> > I used to have this type of problem and 2.6.19-rc1 looks much better
> > than 2.6.18.
> >
> > I'm using CONFIG_PREEMPT + CONFIG_PREEMPT_BKL, CFQ i/o scheduler
> > and /proc/sys/vm/swappiness = 20.
> 
> I will give 2.6.19 a test in a few weeks when the dust of all the changes have 
> settled a bit. :-)
> 
> As my Mike Galbraith suggested, I made some tests with renicing the IO 
> intensive applications. This indeed makes a hell of a difference. Currently I 
> am renicing everything that causes a lot of disk IO to a nice of 19. Even 
> though this doesn't fix it completely, the occasional short hangs have become 
> less common.

(I probably should have been more verbose in my suggestion;)

What I actually suggested was that you try renicing the application you
were experiencing sluggishness with to -10, and retry your IO
interference test to see if you were experiencing scheduling latency or
something else.  For example, if your GL application is using lots of
cpu, it will likely not be classified as interactive, and can end up in
the expired array, at which time an IO task can do a long burst of heavy
cpu usage at interactive status, and keep your application off of the
cpu for quite a while.  The intent of renicing your application to -10
was to keep it at interactive status, and above the heavy IO tasks. (if
it sleeps at all that should work.  there are other scenarios too, but
less likely than this one) 

If running IO at nice 19 more or less fixes your problem, I think we can
assume that you are having scheduling troubles, so the thing to do is to
grab some top snapshots showing cpu distribution during a problem
period.

	-Mike

