Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932772AbVJ3CKS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932772AbVJ3CKS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 22:10:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932785AbVJ3CKS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 22:10:18 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:43969 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932772AbVJ3CKR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 22:10:17 -0400
Date: Sat, 29 Oct 2005 22:10:05 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
To: David Weinehall <tao@acc.umu.se>
cc: linux-kernel@vger.kernel.org, Matt Mackall <mpm@selenic.com>
Subject: Re: [ketchup] patch to allow for moving of .gitignore in 2.6.14
In-Reply-To: <20051030011959.GA17750@vasa.acc.umu.se>
Message-ID: <Pine.LNX.4.58.0510292204170.10073@localhost.localdomain>
References: <Pine.LNX.4.58.0510170316310.5859@localhost.localdomain>
 <20051017213915.GN26160@waste.org> <Pine.LNX.4.58.0510180211320.13581@localhost.localdomain>
 <20051018063031.GR26160@waste.org> <Pine.LNX.4.58.0510180239550.13581@localhost.localdomain>
 <20051018072927.GU26160@waste.org> <1130504043.9574.56.camel@localhost.localdomain>
 <Pine.LNX.4.58.0510291659140.10073@localhost.localdomain>
 <20051030011959.GA17750@vasa.acc.umu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 30 Oct 2005, David Weinehall wrote:

> On Sat, Oct 29, 2005 at 05:06:21PM -0400, Steven Rostedt wrote:
> [snip]
>
> >
> > -    err = os.system("mv linux*/* . ; rmdir linux*")
> > +    err = os.system("shopt -s dotglob; mv linux*/* . ; rmdir linux*")
> >      if err:
> >          error("Unpacking failed: ", err)
> >          sys.exit(-1)
>
>
> Uhm, this patch assumes that you're using bash as /bin/sh.

Well, aren't you?  :-)

> Not everyone does.  (I haven't checked the rest of the system calls
> in ketchup though, maybe this is a more generic problem?)

Yeah, the thought did occur to me that this is bash specific, and would
not be "portable".  But I did think that this is very Linux specific, and
I'll go with the 99% of most Linux boxes use bash.  But you are right to
complain because, like Linux, I like to be compatible with even the most
obscure setups.

When I get some more time, I'll play with some other methods, like what
Matt suggested.  But this is the quick fix for those that do use bash as
the system shell, and want it to work for their system.  Since currently,
it doesn't work for 2.6.14 from scratch.

-- Steve

