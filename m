Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265690AbSJSWde>; Sat, 19 Oct 2002 18:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265691AbSJSWde>; Sat, 19 Oct 2002 18:33:34 -0400
Received: from mnh-1-01.mv.com ([207.22.10.33]:14085 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S265690AbSJSWdd>;
	Sat, 19 Oct 2002 18:33:33 -0400
Message-Id: <200210192343.SAA03642@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Andrea Arcangeli <andrea@suse.de>
cc: Andi Kleen <ak@muc.de>, john stultz <johnstul@us.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>,
       george anzinger <george@mvista.com>,
       Stephen Hemminger <shemminger@osdl.org>,
       Bill Davidsen <davidsen@tmr.com>
Subject: Re: [PATCH] linux-2.5.43_vsyscall_A0 
In-Reply-To: Your message of "Sat, 19 Oct 2002 07:01:39 +0200."
             <20021019050139.GM23930@dualathlon.random> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 19 Oct 2002 18:43:28 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

andrea@suse.de said:
> the sysctl would replace the vsyscall fixmap fixmap entry for the
> current cpu enterely at switch_to time, I certainly don't want to add
> not necessary branches in the core vsyscall code.  Doing it globally
> is zerocost but it would probably need privilegies as said, per-task
> could be more dynamic without privilegies and it would be an unlikely
> branch added in switch_to, still a very low cost so still acceptable. 

If I'm understanding this (and reading the code) correctly, this would
allow UML to specify that, for a given process, it should have a page of
its choosing mapped into the vsyscall area.  Correct?

If so, I can go along with this.  It makes vsyscalls virtualizable, and thus
available to UML, which needs them more than the other arches :-)

The one suggestion I'd make is to make it per-mm rather than per-task and 
put it in switch_mm rather than switch_to.

				Jeff

