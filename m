Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316069AbSEJRDA>; Fri, 10 May 2002 13:03:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316070AbSEJRC7>; Fri, 10 May 2002 13:02:59 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:1492 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S316069AbSEJRC6>; Fri, 10 May 2002 13:02:58 -0400
Date: Fri, 10 May 2002 19:03:19 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "David S. Miller" <davem@redhat.com>
cc: dizzy@roedu.net, linux-kernel@vger.kernel.org
Subject: Re: mmap, SIGBUS, and handling it
In-Reply-To: <20020510.084722.124055793.davem@redhat.com>
Message-ID: <Pine.GSO.3.96.1020510183538.13449A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 May 2002, David S. Miller wrote:

>     I would expect it to return from the handler with no action, possibly
>    re-executing the faulting instruction (if the reason was synchronous) and
>    causing an infinite loop.  For consistency, whether it makes sense, or not
>    (ditto for SIGSEGV, etc.). 
> 
> If we reexecute the instruction it will take the signal endlessly,
> forever.  That makes no sense.

 It depends on an application.  It certainly shouldn't be the default, but
a user may choose such an option for some reason.  E.g. for debugging a
system with an ICE or a similar tool.

> Next, if we skip the instruation, what should be in the destination
> register of the load?  There is no reasonable answer.  If you put
> zero there the program will likely segfault on a NULL pointer
> dereference.

 This option is out of question, obviously.

> So my original point I was trying to make, which still stands, is that
> what is being requested is totally rediculious behavior, trying to
> ignore a page fault that can't be serviced.

 Why should we enforce policy on a user?  If one wants to ignore such
signals for whatever reason, let him do that. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

