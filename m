Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263161AbUDBAkL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 19:40:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263419AbUDBAkL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 19:40:11 -0500
Received: from mail.shareable.org ([81.29.64.88]:31125 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S263161AbUDBAkD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 19:40:03 -0500
Date: Fri, 2 Apr 2004 01:39:37 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Peter Williams <peterw@aurema.com>
Cc: Arjan van de Ven <arjanv@redhat.com>,
       Albert Cahalan <albert@users.sourceforge.net>,
       "Randy.Dunlap" <rddunlap@osdl.org>, ak@muc.de,
       Richard.Curnow@superh.com, aeb@cwi.nl,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: finding out the value of HZ from userspace
Message-ID: <20040402003937.GC28520@mail.shareable.org>
References: <1079453698.2255.661.camel@cube> <20040320095627.GC2803@devserv.devel.redhat.com> <1079794457.2255.745.camel@cube> <405CDA9C.6090109@aurema.com> <20040331134009.76ca3b6d.rddunlap@osdl.org> <1080776817.2233.2326.camel@cube> <20040401155420.GB25502@mail.shareable.org> <20040401160132.GB13294@devserv.devel.redhat.com> <20040401163047.GD25502@mail.shareable.org> <406CAEB6.6080709@aurema.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <406CAEB6.6080709@aurema.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:
> >When we go to a tickless kernel and offer high-resolution timers to
> >userspace, then it will be irrelevant.  Until then, or if the kernel
> >goes tickless but limits the resolution of timers for efficiency, the
> >value of HZ is still relevant.
> 
> The resolution will always be limited.  That's the nature of digital 
> systems.  Unlimited resolution would require real "real" numbers and 
> that's not possible.  The nearest you get on a digital system is the 
> floating point APPROXIMATION to real numbers.

Sure, but HZ will still be irrelevant.  There won't be a HZ to report.

> IMHO, as I've said several times, USER_HZ should be changed to be equal 
> to or greater than HZ.  In fact, if having USER_HZ greater than HZ would 
> still make it unusable for your purposes, I'd change that opinion to say 
> USER_HZ should be equal to HZ (or, in other words, cease to exist).

It's not possible to change USER_HZ.  There are too many programs with
the number hard-coded into the binary.  The best we could do is make
the HZ userspace macro non-constant, so it calls sysconf(_SC_CLK_TCK),
and wait a few years until practically all programs being used no
longer contain a hard-coded constant.  Then we could get rid of USER_HZ again.

-- Jamie
