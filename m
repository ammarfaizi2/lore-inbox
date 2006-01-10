Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750980AbWAJNLf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750980AbWAJNLf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 08:11:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751000AbWAJNLf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 08:11:35 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:29612 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1750969AbWAJNLf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 08:11:35 -0500
Message-ID: <43C3C46C.D347F3F0@tv-sign.ru>
Date: Tue, 10 Jan 2006 17:27:56 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: vatsa@in.ibm.com
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>, linux-kernel@vger.kernel.org,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Manfred Spraul <manfred@colorfullife.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2/5] rcu: don't check ->donelist in __rcu_pending()
References: <43C165BC.F7C6DCF5@tv-sign.ru> <20060109185944.GB15083@us.ibm.com> <43C2C818.65238C30@tv-sign.ru> <20060109195933.GE14738@us.ibm.com> <20060110095811.GA30159@in.ibm.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Srivatsa Vaddagiri wrote:
> 
> On Mon, Jan 09, 2006 at 11:59:33AM -0800, Paul E. McKenney wrote:
> > Hmmm...  So your thought is that __rcu_offline_cpu() moves nxtlist and
> > curlist, but not donelist, but then returns to rcu_offline_cpu(), which
> > might well do the tasklet_kill_immediate() before the tasklet completed
> > processing all of donelist.
> >
> > Seems plausible to me.  If true, your patch adding the following statement
> > to the ed of __rcu_offline_cpu seems like a reasonable fix:
> >
> >       rcu_move_batch(this_rdp, rdp->donelist, rdp->donetail);
> >
> > Vatsa, is there something that Oleg and I are missing?
> 
> I think this should take care of the CPU Hotplug bug, with the caveat
> that the callbacks on ->donelist will wait for additional grace period before
> being invoked (which seems ok).
> 
> Oleg, do you want to resend the patch after some testing?

Sure. The problem is that I have no idea how to test this change.
However, the patch seems "obviously correct", so I am sending it.

Srivatsa, I am sorry, I forgot to add you on CC: list while re-sending
these cleanups. I hope you can see them on lkml.

Oleg.
