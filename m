Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129559AbQKCV1p>; Fri, 3 Nov 2000 16:27:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130089AbQKCV1f>; Fri, 3 Nov 2000 16:27:35 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:10760 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129559AbQKCV1X>; Fri, 3 Nov 2000 16:27:23 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Can EINTR be handled the way BSD handles it? -- a plea from a 
 user-land
Date: 3 Nov 2000 13:27:03 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <8tvaj7$mql$1@cesium.transmeta.com>
In-Reply-To: <200011031841.MAA07209@isunix.it.ilstu.edu> <3A031591.EA24ABFA@moberg.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <3A031591.EA24ABFA@moberg.com>
By author:    george@moberg.com
In newsgroup: linux.dev.kernel
> 
> Thanks for the info.
> 
> After looking at it, let me modify my position a bit.
> 
> My problem is that pthread_create (glibc 2.1.3, kernel 2.2.17 i686) is
> failing because, deep inside glibc somewhere, nanosleep() is returning
> EINTR.
> 
> My code is not using signals.  The threading library is, and there is
> obviously some subtle bug going on here.  Ever wonder why when browsing
> with Netscape and you click on a link and it says "Interrupted system
> call."?  This is it.  I'm arguing that the default behaviour should be
> SA_RESTART, and if some programmer is so studly that they actually know
> what the hell they are doing by disabling SA_RESTART, then they can do
> it explicitly.
> 

They do so explicitly by not specifying SA_RESTART.  It's a bitmask,
and the behaviour of each bit is specified by POSIX.

> I don't mean this to sound like a rant.

It does... it sounds like a rant someone who hasn't even bothered
looking up the relevant standards and interfaced.

> It's just that I can't possibly ascertain why someone in their right
> mind would want any behaviour different than SA_RESTART.

Synchronous post-processing of signals.   Too many things cannot be
safely done in a signal handler context.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
