Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264020AbUDFVK2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 17:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264009AbUDFVIF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 17:08:05 -0400
Received: from fed1rmmtao10.west.cox.net ([68.230.241.29]:20934 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S264021AbUDFVFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 17:05:01 -0400
Date: Tue, 6 Apr 2004 14:04:59 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: ganzinger@mvista.com
Cc: kgdb-bugreport@lists.sourceforge.net,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Amit S. Kale" <amitkale@emsyssoft.com>
Subject: Re: [KGDB] Make kgdb get in sync with it's I/O drivers for the breakpoint
Message-ID: <20040406210459.GC31152@smtp.west.cox.net>
References: <20040405233058.GV31152@smtp.west.cox.net> <40731A02.8090303@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40731A02.8090303@mvista.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2004 at 01:58:42PM -0700, George Anzinger wrote:

> Tom Rini wrote:
> >Hello.  The following interdiff, vs current kgdb-2 CVS makes kgdb core
> >and I/O drivers get in sync in order to cause a breakpoint.  This kills
> >off the init/main.c change, and makes way for doing things much earlier,
> >if other support exists.  What would be left, tangentally, is some sort
> >of queue to register with, so we can handle the case of KGDBOE on a
> >pcmcia card.  George? Amit? Comments ?
> 
> Well a simple but dumb way is to poll using the timer list, i.e. set up a 
> timer at the first entry were things "might" work and if the driver is not 
> yet, do a timer to come back in 1 tick, and keep doing it for each tick 
> until it is available.  This puts it all on the kgdb side.
> 
> The other way is with a call back list which would be managed by common OE 
> code. This would put most of the code in that area.  I tend to like call 
>  back lists that one registers for by passing in a structure which contains 
> a "list_head" member.  That way there is no memory allocation on either 
> end.  The manager, on a register call, just puts the new structure in its 
> call back list.  The struct would have the list_head member and a function 
> member, and the function would be called with the struct address as its 
> only parameter.  This allows for an expanded struct if more complex info is 
> needed.

Setting aside this problem for a minute (since what I posted does get
the job done, just not 100% clean), what do you think about the rest of
the changes?

-- 
Tom Rini
http://gate.crashing.org/~trini/
