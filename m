Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263324AbUDBAI0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 19:08:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263346AbUDBAI0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 19:08:26 -0500
Received: from alt.aurema.com ([203.217.18.57]:44470 "EHLO smtp.sw.oz.au")
	by vger.kernel.org with ESMTP id S263324AbUDBAIW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 19:08:22 -0500
Message-ID: <406CAEB6.6080709@aurema.com>
Date: Fri, 02 Apr 2004 10:07:18 +1000
From: Peter Williams <peterw@aurema.com>
Organization: Aurema Pty Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jamie Lokier <jamie@shareable.org>
CC: Arjan van de Ven <arjanv@redhat.com>,
       Albert Cahalan <albert@users.sourceforge.net>,
       "Randy.Dunlap" <rddunlap@osdl.org>, ak@muc.de,
       Richard.Curnow@superh.com, aeb@cwi.nl,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: finding out the value of HZ from userspace
References: <1079453698.2255.661.camel@cube> <20040320095627.GC2803@devserv.devel.redhat.com> <1079794457.2255.745.camel@cube> <405CDA9C.6090109@aurema.com> <20040331134009.76ca3b6d.rddunlap@osdl.org> <1080776817.2233.2326.camel@cube> <20040401155420.GB25502@mail.shareable.org> <20040401160132.GB13294@devserv.devel.redhat.com> <20040401163047.GD25502@mail.shareable.org>
In-Reply-To: <20040401163047.GD25502@mail.shareable.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
> Arjan van de Ven wrote:
> 
>>HZ doesn't mean nothing, esp when we go to a tickless kernel...
> 
> 
> As explained several times in this thread, HZ is meaningful because it
> affects the rounding in select/poll/epoll/setitimer.  A few userspace
> programs with low jitter soft-RT timing requirements need to
> compensate for that rounding and/or deliberately synchronise
> themselves with the tick.
> 
> Such programs can determine HZ experimentally and lock onto the tick
> in the manner of a PLL, but it would be nice to simply be able to
> have the value, to reduce the number of control variables.
> 
> When we go to a tickless kernel and offer high-resolution timers to
> userspace, then it will be irrelevant.  Until then, or if the kernel
> goes tickless but limits the resolution of timers for efficiency, the
> value of HZ is still relevant.

The resolution will always be limited.  That's the nature of digital 
systems.  Unlimited resolution would require real "real" numbers and 
that's not possible.  The nearest you get on a digital system is the 
floating point APPROXIMATION to real numbers.

> 
> Not to get irritatingly back to the subject of this thread or
> anything, but...  is the value of HZ reported to userspace anywhere?

I don't think so.  There are those (I'm not one) who insist that to do 
so would be a bug.

IMHO, as I've said several times, USER_HZ should be changed to be equal 
to or greater than HZ.  In fact, if having USER_HZ greater than HZ would 
still make it unusable for your purposes, I'd change that opinion to say 
USER_HZ should be equal to HZ (or, in other words, cease to exist).

Peter
-- 
Dr Peter Williams, Chief Scientist                peterw@aurema.com
Aurema Pty Limited                                Tel:+61 2 9698 2322
PO Box 305, Strawberry Hills NSW 2012, Australia  Fax:+61 2 9699 9174
79 Myrtle Street, Chippendale NSW 2008, Australia http://www.aurema.com

