Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262107AbSJVD5v>; Mon, 21 Oct 2002 23:57:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262119AbSJVD5v>; Mon, 21 Oct 2002 23:57:51 -0400
Received: from mnh-1-24.mv.com ([207.22.10.56]:62725 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S262107AbSJVD5u>;
	Mon, 21 Oct 2002 23:57:50 -0400
Message-Id: <200210220507.AAA06089@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andi Kleen <ak@muc.de>, john stultz <johnstul@us.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>,
       george anzinger <george@mvista.com>,
       Stephen Hemminger <shemminger@osdl.org>,
       Bill Davidsen <davidsen@tmr.com>
Subject: Re: [PATCH] linux-2.5.43_vsyscall_A0 
In-Reply-To: Your message of "Sun, 20 Oct 2002 04:33:21 +0200."
             <20021020023321.GS23930@dualathlon.random> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 22 Oct 2002 00:07:16 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

andrea@suse.de said:
> yes, this is true for all the syscalls, if that's a problem uml isn't
> an option for the user in the first place. 

Not true.  Any marginal increase in performance will make a number of 
applications fast enough that they become practical in UML.  Since there
are apps which, to a first order approximation, do nothing but call 
gettimeofday, they are not usable in UML today, but could become usable if
UML had vgettimeofday.  I've had complaints about this, so the need is
definitely there.

> what do you plan to do to make all other syscall faster? 

Right now, a UML syscall involves four host context switches and a host
signal delivery and return.  I'm merging some changes which will reduce
that to two host context switches and no signals.  Once that's done, I'm
going to look for more improvements.

> My problem is that mapping user code into the vsyscall fixmap is
> complex and not very clean at all, breaks various concepts in the mm
> and last but not the least it is slow

Can you explain, in small words, why mapping user code is so horrible?

				Jeff

