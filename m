Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290311AbSAPAre>; Tue, 15 Jan 2002 19:47:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290303AbSAPArG>; Tue, 15 Jan 2002 19:47:06 -0500
Received: from tomts20-srv.bellnexxia.net ([209.226.175.74]:61373 "EHLO
	tomts20-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S290305AbSAPAoy>; Tue, 15 Jan 2002 19:44:54 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: <mingo@elte.hu>
Subject: Re: [patch] O(1) scheduler-H6/H7/I0 and nice +19
Date: Tue, 15 Jan 2002 19:44:51 -0500
X-Mailer: KMail [version 1.3.2]
Cc: Davide Libenzi <davidel@xmailserver.org>,
        lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0201160247530.27739-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.33.0201160247530.27739-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020116004452.7C241CCB54@oscar.casa.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 15, 2002 08:49 pm, Ingo Molnar wrote:
> On Tue, 15 Jan 2002, Ed Tomlinson wrote:
> > The 2.4.17-I0 patch makes things much better here.  Does this one
> > suffer from the same bugs that the 2.5.2 version has?
>
> i'll do a -I3 patch in a minute.
>
> > Major difference from older version of the patch is that top shows
> > many processes with PRI 0.  I am not sure this is intended?
>
> yes, it's intended. Lots of interactive (idle) tasks. Right now the time
> under which we detect a task as interactive is pretty short, but if you
> run 'top' with 's 0.3' then you can see how tasks grow/shrink their
> priorities, depending on the load they generate.

OK I3 also works fine with respect to my nice test.  One thing I do note
and I am not too sure how it might be fixed, is what happens when starting 
what will be interactive programs.  

Watching with top 's 0.3' I can see them lose priority in the 3-10 seconds it
takes them to setup.  This is not that critical if they are the only thing trying
to run.  If you have another (not niced) task eating cpu (like a kernel compile) 
then intactive startup time suffers.  Startup time is wait time that _is_ noticed
by users.

Is there some way we could tell the scheduler or the scheduler could learn that 
a given _program_ is usually interactive so it should wait at bit (10 seconds on my 
box would work) before starting to increase its priority numbers?

TIA
Ed Tomlinson
