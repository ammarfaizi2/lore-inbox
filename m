Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289812AbSAPCH3>; Tue, 15 Jan 2002 21:07:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289809AbSAPCHS>; Tue, 15 Jan 2002 21:07:18 -0500
Received: from port-213-20-228-123.reverse.qdsl-home.de ([213.20.228.123]:61194
	"EHLO drocklinux.dyndns.org") by vger.kernel.org with ESMTP
	id <S289806AbSAPCHL>; Tue, 15 Jan 2002 21:07:11 -0500
Date: Wed, 16 Jan 2002 03:06:50 +0100 (CET)
Message-Id: <20020116.030650.730576342.rene.rebe@gmx.net>
To: tomlins@cam.org
Cc: mingo@elte.hu, davidel@xmailserver.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] O(1) scheduler-H6/H7/I0 and nice +19
From: Rene Rebe <rene.rebe@gmx.net>
In-Reply-To: <20020116004452.7C241CCB54@oscar.casa.dyndns.org>
In-Reply-To: <Pine.LNX.4.33.0201160247530.27739-100000@localhost.localdomain>
	<20020116004452.7C241CCB54@oscar.casa.dyndns.org>
X-Mailer: Mew version 2.1 on XEmacs 21.4.6 (Common Lisp)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I3 still shows exactly the same behavior. For a test I simply compiled
ALSA and executed xstart. The screen went black (for a minute?) and
continued to start when ALSA finished.

Also dragging a xterm arround (during a compilation) results in 1-2
frames/per second refresh.

The lst one I tried was sched-patch was G1, it worked fine.

Athlon XP 1700+, SiS735, 512MB RAM, Matrox-G450 ...

From: Ed Tomlinson <tomlins@cam.org>
Subject: Re: [patch] O(1) scheduler-H6/H7/I0 and nice +19
Date: Tue, 15 Jan 2002 19:44:51 -0500

> On January 15, 2002 08:49 pm, Ingo Molnar wrote:
> > On Tue, 15 Jan 2002, Ed Tomlinson wrote:
> > > The 2.4.17-I0 patch makes things much better here.  Does this one
> > > suffer from the same bugs that the 2.5.2 version has?
> >
> > i'll do a -I3 patch in a minute.
> >
> > > Major difference from older version of the patch is that top shows
> > > many processes with PRI 0.  I am not sure this is intended?
> >
> > yes, it's intended. Lots of interactive (idle) tasks. Right now the time
> > under which we detect a task as interactive is pretty short, but if you
> > run 'top' with 's 0.3' then you can see how tasks grow/shrink their
> > priorities, depending on the load they generate.
> 
> OK I3 also works fine with respect to my nice test.  One thing I do note
> and I am not too sure how it might be fixed, is what happens when starting 
> what will be interactive programs.  
> 
> Watching with top 's 0.3' I can see them lose priority in the 3-10 seconds it
> takes them to setup.  This is not that critical if they are the only thing trying
> to run.  If you have another (not niced) task eating cpu (like a kernel compile) 
> then intactive startup time suffers.  Startup time is wait time that _is_ noticed
> by users.
> 
> Is there some way we could tell the scheduler or the scheduler could learn that 
> a given _program_ is usually interactive so it should wait at bit (10 seconds on my 
> box would work) before starting to increase its priority numbers?
> 
> TIA
> Ed Tomlinson
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
