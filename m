Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264950AbTBFCJg>; Wed, 5 Feb 2003 21:09:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265063AbTBFCJf>; Wed, 5 Feb 2003 21:09:35 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:33731 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S264950AbTBFCJf>;
	Wed, 5 Feb 2003 21:09:35 -0500
Message-Id: <200302060218.h162Ivn05684@owlet.beaverton.ibm.com>
To: "Haoqiang Zheng" <hzheng@cs.columbia.edu>
cc: ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: linux hangs with printk on schedule() 
In-reply-to: Your message of "Tue, 04 Feb 2003 22:01:27 EST."
             <015201c2ccc2$e10729e0$bcf627a0@zhengthinkpad> 
Date: Wed, 05 Feb 2003 18:18:57 -0800
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    I am working on implementing a new SMP scheduler. It's an OS research
    project. Without "printk" in the scheduler, it's really very hard to do the
    debugging. I don't know how other guys do in this case. Are you guys better
    equipped than me? I mean is debugging with gdb running on another machine
    (connected via serial port) a common technique? I am not sure whether it's
    necessary to set up an environment like that.

Depending on what your needs are, could you simply note or count events
and do something about them later?  I've a patch which inserts counters
into schedule() (basically a very focused code coverage) so that you
can determine later what decisions were taken (and how many times they
were taken). If knowing the frequency at which a path was taken is
more important than knowing specific values each time a path was hit,
this patch might do it for you.

http://eaglet.rain.com/rick/linux/schedstat

If both the details and sequence is important, since this is debugging,
you might try creating a, oh, 5000 member array, treated either as
a circular buffer or a simple recording of the first 5000 events, in
which you record your interesting event for later retrieval via
(fancy) /proc or (more basic) your favorite debugger.  I wouldn't
advocate this for finished code, and be warned that too much
intrusive debugging in a path like the scheduler can skew what
you're hoping to observe. (printk's, for instance, can
be very slow compared to what's happening in the scheduler.)

Rick
