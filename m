Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262966AbUDAQbg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 11:31:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262471AbUDAQbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 11:31:24 -0500
Received: from mail.shareable.org ([81.29.64.88]:14229 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262260AbUDAQbS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 11:31:18 -0500
Date: Thu, 1 Apr 2004 17:30:47 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       "Randy.Dunlap" <rddunlap@osdl.org>, Peter Williams <peterw@aurema.com>,
       ak@muc.de, Richard.Curnow@superh.com, aeb@cwi.nl,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: finding out the value of HZ from userspace
Message-ID: <20040401163047.GD25502@mail.shareable.org>
References: <1079453698.2255.661.camel@cube> <20040320095627.GC2803@devserv.devel.redhat.com> <1079794457.2255.745.camel@cube> <405CDA9C.6090109@aurema.com> <20040331134009.76ca3b6d.rddunlap@osdl.org> <1080776817.2233.2326.camel@cube> <20040401155420.GB25502@mail.shareable.org> <20040401160132.GB13294@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040401160132.GB13294@devserv.devel.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> HZ doesn't mean nothing, esp when we go to a tickless kernel...

As explained several times in this thread, HZ is meaningful because it
affects the rounding in select/poll/epoll/setitimer.  A few userspace
programs with low jitter soft-RT timing requirements need to
compensate for that rounding and/or deliberately synchronise
themselves with the tick.

Such programs can determine HZ experimentally and lock onto the tick
in the manner of a PLL, but it would be nice to simply be able to
have the value, to reduce the number of control variables.

When we go to a tickless kernel and offer high-resolution timers to
userspace, then it will be irrelevant.  Until then, or if the kernel
goes tickless but limits the resolution of timers for efficiency, the
value of HZ is still relevant.

Not to get irritatingly back to the subject of this thread or
anything, but...  is the value of HZ reported to userspace anywhere?

Thanks :)
-- Jamie
