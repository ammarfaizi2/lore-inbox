Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316588AbSGGV4Y>; Sun, 7 Jul 2002 17:56:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316589AbSGGV4X>; Sun, 7 Jul 2002 17:56:23 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:41152 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S316588AbSGGV4W>;
	Sun, 7 Jul 2002 17:56:22 -0400
Message-ID: <3D28B97E.3050401@us.ibm.com>
Date: Sun, 07 Jul 2002 14:58:22 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Oliver Neukum <oliver@neukum.name>
CC: Greg KH <greg@kroah.com>,
       kernel-janitor-discuss 
	<kernel-janitor-discuss@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: BKL removal
References: <Pine.LNX.4.44L.0207061306440.8346-100000@imladris.surriel.com> <3D27390E.5060208@us.ibm.com> <20020707205543.GA18298@kroah.com> <200207072328.34244.oliver@neukum.name>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Neukum wrote:
 >>> I would mind the BKL a lot less if it was as well understood
 >>> everywhere as it is in VFS.  The funny part is that a lock like
 >>>  the BKL would not last very long if it were well understood or
 >>>  documented everywhere it was used.
 >>
 >> I would mind it a whole lot less if when you try to remove the
 >> BKL, you do it correctly.  So far it seems like you enjoy doing
 >> "hit and run" patches, without even fully understanding or
 >> testing your patches out (the driverfs and input layer patches
 >> are proof of that.)  This does nothing but aggravate the
 >> developers who have to go clean up after you.
 >>
 >> Also, stay away from instances of it's use WHERE IT DOES NOT
 >> MATTER for performance.  If I grab the BKL on insertion or
 >> removal of a USB device, who cares?  I know you are trying to
 >> remove it entirely out of the kernel, but please focus on places
 >> where it actually helps, and leave the other instances alone.
 >
 > If you really want to make maximum impact, do tests. Very few
 > people can measure lock contention on a 4-CPU system.

Do you mean "see lock contention", or "have the hardware to measure
lock contention"?  We probably use lockmeter more than just about 
anyone else.  But, I do not, nor have I ever contended, that things 
like driverfs's BKL use have a performance impact.  I just consider 
them messy, and bad practice.

 > And please rest assured that nobody wants to be maintainer of the
 > subsystem that ruins scalability.

I agree completely.  All of the maintainers who are handed data that 
shows bad BKL contention have either done something about it, or are 
doing something about it now.  2.5 is 2 orders of magnitude better 
than 2.4 for BKL contention in most of the workloads that I see.

 > And if you see a use of the BKL you don't understand ask first, or
 > send a patch to the subsystem's mailing list, not lkml. People will
 >  look at BKL usage if you ask. In fact such a look might even
 > uncover bugs as in case of USB.

I guess I got discouraged by a few non-responsive mailing lists in the 
past.  I'll make an effort to use them more in the future.

-- 
Dave Hansen
haveblue@us.ibm.com

