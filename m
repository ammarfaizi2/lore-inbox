Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318884AbSHMALi>; Mon, 12 Aug 2002 20:11:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318886AbSHMALi>; Mon, 12 Aug 2002 20:11:38 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:53000 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318884AbSHMALh>;
	Mon, 12 Aug 2002 20:11:37 -0400
Message-ID: <3D584F14.5D518E8D@zip.com.au>
Date: Mon, 12 Aug 2002 17:13:08 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Rodland <arodland@noln.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.31: modules don't work at all
References: <3D574972.DD878928@zip.com.au> <20020812200908.7e5331df.arodland@noln.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Rodland wrote:
> 
> > > -       if (in_interrupt() || !mm)
> > > +       if (preempt_count() || !mm)
> > >                 goto no_context;
> > >
> > >         down_read(&mm->mmap_sem);
> > >
> >
> > Yes, that's the problem.   qm_symbols() is performing copy_to_user()
> > inside lock_kernel() and that's an "atomic copy_to_user()" in 2.5.31.
> > But only if preempt is selected.  The copy_to_user() doesn't work.
> >
> > There's nothing illegal about copy_to_user() inside lock_kernel().
> 
> Does that mean that the above fix is a legal quick-fix and won't cause
> things to fall apart, or does it mean that I shouldn't bother until the
> next version?

That a legal quick-fix.  Or disable CONFIG_PREEMPT.
