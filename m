Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317472AbSGJDZL>; Tue, 9 Jul 2002 23:25:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317473AbSGJDZK>; Tue, 9 Jul 2002 23:25:10 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:31211 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S317472AbSGJDZJ>;
	Tue, 9 Jul 2002 23:25:09 -0400
Date: Tue, 9 Jul 2002 23:27:52 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
cc: Robert Love <rml@mvista.com>, Dave Hansen <haveblue@us.ibm.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Rick Lindsley <ricklind@us.ibm.com>, Greg KH <greg@kroah.com>,
       kernel-janitor-discuss 
	<kernel-janitor-discuss@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: BKL removal
In-Reply-To: <20020710011517.GA1323@conectiva.com.br>
Message-ID: <Pine.GSO.4.21.0207092320380.2515-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 9 Jul 2002, Arnaldo Carvalho de Melo wrote:

> Em Tue, Jul 09, 2002 at 02:47:49PM -0700, Robert Love escreveu:
> > On Tue, 2002-07-09 at 07:44, Dave Hansen wrote:
> > 
> > > The Stanford Checker or something resembling it would be invaluable 
> > > here.  It would be a hell of a lot better than my litle patch!
> > 
> > The Stanford Checker would be infinitely invaluable here -- agreed.
> > 
> > Anything that can graph call chains and do analysis... we can get it to
> > tell us exactly who and what.

Not anything.  It can be used to find problems (and be very helpful at that)
but it can't be used to verify anything.

The problem is that checker doesn't (and cannot) cover all code paths -
by the time when it comes into the game the source had already passed
through through cpp.  In other words, depending on the configuration
you might get very different results.

Normally it's not that bad, but "can this function block?" is very nasty
in that respect - changes of configuration can and do affect that in
non-trivial ways.  Checker can be _very_ useful since it allows to catch
some of the existing bugs, but it should not be used as a justification
of change that might introduce bugs if some assumption ever becomes false.

> Try smatch:
> 
> http://smatch.sf.net
> 
> And see if you can write a smatch script to get a good broom for this trash 8)

