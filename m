Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262126AbSIPRjv>; Mon, 16 Sep 2002 13:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262747AbSIPRju>; Mon, 16 Sep 2002 13:39:50 -0400
Received: from mail.parknet.co.jp ([210.134.213.6]:23314 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S262126AbSIPRju>; Mon, 16 Sep 2002 13:39:50 -0400
To: Daniel Jacobowitz <dan@debian.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix for ptrace breakage
References: <Pine.LNX.4.44.0209161349270.29027-100000@localhost.localdomain>
	<87vg565eo2.fsf@devron.myhome.or.jp>
	<87wupmrtn1.fsf@devron.myhome.or.jp>
	<20020916130735.GA3920@nevyn.them.org>
	<87sn0at3di.fsf@devron.myhome.or.jp>
	<20020916144204.GA7991@nevyn.them.org>
	<87fzwasz96.fsf@devron.myhome.or.jp>
	<20020916160537.GA12905@nevyn.them.org>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 17 Sep 2002 02:44:29 +0900
In-Reply-To: <20020916160537.GA12905@nevyn.them.org>
Message-ID: <87k7llsubm.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Jacobowitz <dan@debian.org> writes:

> > > We have the tasklist lock.  How can there be a race here?  The parent
> > > can't detach while we're holding the tasklist lock.  If there is a race
> > > with PTRACE_SETOPTIONS, then PTRACE_SETOPTIONS should take the lock.
> > 
> > No. If the real parent don't change ->ptrace, it doesn't need
> > lock.
> 
> I don't understand what you mean by that.  Do you mean, "if it does
> change ->ptrace, it doesn't need a lock"?

Basically, only tracer can change ->ptrace of traced child. And, it
doesn't need lock. (there are some exceptions)

> > Ah, ok. I think, it's longtime (odd) behavior. And you think, it's
> > a bug. Right?
> > 
> > And, both of your and old code has odd behavior. yes?
> 
> Before your patch, do_notify_parent didn't get called; I think that
> perhaps it should be.  I'll think about that.  After your patch the
> process group will be unexpectedly orphaned, which is not now the case.
> 
> Let me sit on this for a couple of hours.  I'll send you an alternative
> patch to look at.

Ok. But I'll sleep soon. So, I'll look it, after having come back from
the office.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
