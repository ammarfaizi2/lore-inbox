Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131545AbQKCToB>; Fri, 3 Nov 2000 14:44:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131560AbQKCTnv>; Fri, 3 Nov 2000 14:43:51 -0500
Received: from neuron.moberg.com ([209.152.208.195]:61710 "EHLO
	neuron.moberg.com") by vger.kernel.org with ESMTP
	id <S131545AbQKCTnq>; Fri, 3 Nov 2000 14:43:46 -0500
Message-ID: <3A031591.EA24ABFA@moberg.com>
Date: Fri, 03 Nov 2000 14:44:17 -0500
From: george@moberg.com
Organization: Moberg Research, Inc.
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tim Hockin <thockin@isunix.it.ilstu.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: Can EINTR be handled the way BSD handles it? -- a plea from a 
 user-land
In-Reply-To: <200011031841.MAA07209@isunix.it.ilstu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Hockin wrote:
> 
> > Considering that the threading library for Linux uses signals to make it
> > work, would it be possible to change the Linux kernel to operate the way
> > BSD does--instead of returning EINTR, just restart the interrupted
> > primitive?
> 
> man sigaction, look for SA_RESTART

Thanks for the info.

After looking at it, let me modify my position a bit.

My problem is that pthread_create (glibc 2.1.3, kernel 2.2.17 i686) is
failing because, deep inside glibc somewhere, nanosleep() is returning
EINTR.

My code is not using signals.  The threading library is, and there is
obviously some subtle bug going on here.  Ever wonder why when browsing
with Netscape and you click on a link and it says "Interrupted system
call."?  This is it.  I'm arguing that the default behaviour should be
SA_RESTART, and if some programmer is so studly that they actually know
what the hell they are doing by disabling SA_RESTART, then they can do
it explicitly.

I don't mean this to sound like a rant.  It's just that I can't possibly
ascertain why someone in their right mind would want any behaviour
different than SA_RESTART.
--
George T. Talbot
<george at moberg dot com>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
