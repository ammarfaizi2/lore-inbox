Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262963AbUDAREP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 12:04:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262932AbUDAREP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 12:04:15 -0500
Received: from mail.shareable.org ([81.29.64.88]:18069 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262963AbUDARBg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 12:01:36 -0500
Date: Thu, 1 Apr 2004 18:01:05 +0100
From: Jamie Lokier <jamie@shareable.org>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Arjan van de Ven <arjanv@redhat.com>,
       Albert Cahalan <albert@users.sourceforge.net>,
       "Randy.Dunlap" <rddunlap@osdl.org>, Peter Williams <peterw@aurema.com>,
       ak@muc.de, Richard.Curnow@superh.com, aeb@cwi.nl,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: finding out the value of HZ from userspace
Message-ID: <20040401170105.GF25502@mail.shareable.org>
References: <1079453698.2255.661.camel@cube> <20040320095627.GC2803@devserv.devel.redhat.com> <1079794457.2255.745.camel@cube> <405CDA9C.6090109@aurema.com> <20040331134009.76ca3b6d.rddunlap@osdl.org> <1080776817.2233.2326.camel@cube> <20040401155420.GB25502@mail.shareable.org> <20040401160132.GB13294@devserv.devel.redhat.com> <20040401163047.GD25502@mail.shareable.org> <Pine.LNX.4.53.0404011146490.21282@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0404011146490.21282@chaos>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> > Not to get irritatingly back to the subject of this thread or
> > anything, but...  is the value of HZ reported to userspace anywhere?
> 
> I may be naive, but what's the matter with:
> 
> #include <sys/param.h>   // Required to be here!
> int main()
> {
>     printf("HZ=%d\n", HZ);
>     return 0;
> }
> It works for me.

It gives the wrong answer for HZ on 2.6 kernels.  Try it.

The value called "HZ" we are talking about in this thread is the timer
interrupt frequency.  On 2.6 kernels, on x86, that is 1000.  Your
program prints 100.

The reason that you are able to use "HZ" from userspace and get the
wrong answer is that the macros have different names when used from
userspace than from kernelspace.

The value your program reports is what we mean by USER_HZ in this
thread.  That macro is renamed to HZ when the kernel header
<linux/param.h> is included from userspace, for backward
source compatibility with some programs.

Your method also perpetuates the problem that USER_HZ is hard-coded as
a constant into programs, so cannot ever be changed.  Perhaps the
header files should redefine "HZ" to call sysconf(_SC_CLK_TCK)
nowadays, but presently they don't.

-- Jamie
