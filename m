Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265644AbSKAG4M>; Fri, 1 Nov 2002 01:56:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265645AbSKAG4M>; Fri, 1 Nov 2002 01:56:12 -0500
Received: from dsl-sj-66-219-79-98.broadviewnet.net ([66.219.79.98]:2517 "EHLO
	mail.3pardata.com") by vger.kernel.org with ESMTP
	id <S265644AbSKAG4L>; Fri, 1 Nov 2002 01:56:11 -0500
Date: Thu, 31 Oct 2002 23:00:20 -0800 (PST)
From: Castor Fu <castor@3pardata.com>
X-X-Sender: <castor@marais>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Bill Davidsen <davidsen@tmr.com>, "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>,
       <lkcd-general@lists.sourceforge.net>,
       <lkcd-devel@lists.sourceforge.net>
Subject: Re: [lkcd-devel] Re: What's left over.
In-Reply-To: <Pine.LNX.4.44.0210312233190.5595-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.33.0210312257120.8455-100000@marais>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Oct 2002, Linus Torvalds wrote:

>
> On Fri, 1 Nov 2002, Bill Davidsen wrote:
> >
> >   If you really believed the stuff you say you'd put it in and promise to
> > take it out if people didn't find it useful or there were inherent
> > limitations.
>
> This never works. Be honest. Nobody takes out features, they are stuck
> once they get in. Which is exactly why my job is to say "no", and why
> there is no "accepted unless proven bad".
>
> > It would probably take 10-30% off the time to a stable release.
>
> Talk is cheap.
>
> I've not seen a _single_ bug-report with a fix that attributed the
> existing LKCD patches. I might be more impressed if I had.

Maybe people don't bother to spell out how they got there.  Here's one.

    -castor

:: Newsgroups: mlist.linux.kernel
:: Date:   Mon, 17 Dec 2001 09:48:53 -0800 (PST)
:: From: Castor Fu <castor@3pardata.com>
:: X-To: <linux-kernel@vger.kernel.org>
:: Subject: i386 machine_restart unsafe in interrupt context
:: Message-ID: <linux.kernel.Pine.LNX.4.33.0112170935520.1623-100000@marais.SOMEWHERE>
:: MIME-Version: 1.0
:: Content-Type: TEXT/PLAIN; charset=US-ASCII
:: Approved: news@nntp-server.caltech.edu
:: Lines: 27
::
::
:: I have a problem where systems fail to reboot on panic().  I've resolved
:: it by changing smp_send_stop() to use an NMI (like the KDB patch does to
:: manage communication).
::
:: The source of the problem is that the panic path has the following:
::
::     panic()
::         machine_restart()
::             machine_real_restart()
::                 smp_send_stop()
::                     smp_call_function()
::
:: and smp_call_function() is not safe in an interrupt context.
::
:: I imagine people might want to handle this differently, but I'd be
:: happy to diffs if there's interest.  It may be that there are enough
:: cases like this that smp_call_function might want a version that
:: uses an NMI. . .
::
::     -Castor Fu
::     castor@3par.com

