Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274825AbTGaRfN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 13:35:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274822AbTGaRfN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 13:35:13 -0400
Received: from smtp6.Stanford.EDU ([171.67.16.33]:49066 "EHLO
	smtp6.Stanford.EDU") by vger.kernel.org with ESMTP id S274825AbTGaRfH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 13:35:07 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: Emulating i486 on i386 (was: TSCs are a no-no on i386)
References: <f41P.374.9@gated-at.bofh.it> <f4bw.3eu.13@gated-at.bofh.it>
	<f5Az.4tG.3@gated-at.bofh.it> <f5TZ.4Hq.11@gated-at.bofh.it>
	<f9uz.Ll.5@gated-at.bofh.it> <ff6X.6qi.3@gated-at.bofh.it>
	<ffTk.734.15@gated-at.bofh.it> <fk6A.241.7@gated-at.bofh.it>
	<fkgp.2aL.29@gated-at.bofh.it> <fnnW.4QQ.43@gated-at.bofh.it>
	<fnQP.5bE.5@gated-at.bofh.it>
Reply-To: blp@cs.stanford.edu
From: Ben Pfaff <blp@cs.stanford.edu>
Date: 31 Jul 2003 10:35:00 -0700
In-Reply-To: <fnQP.5bE.5@gated-at.bofh.it>
Message-ID: <877k5y8urf.fsf@pfaff.Stanford.EDU>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan-Benedict Glaw <jbglaw@lug-owl.de> writes:

> On Thu, 2003-07-31 16:12:26 +0100, Jamie Lokier <jamie@shareable.org>
> wrote in message <20030731151226.GG6410@mail.jlokier.co.uk>:
> > Alan Cox wrote:
> > > On Iau, 2003-07-31 at 12:38, Jan-Benedict Glaw wrote:
> > > > See? It's loaded at the "ls" call, but it seems to be not loaded for
> > > > apt-get.
> > > 
> > > Remember you need to overload signal setting functions like sigaction.
> > > My guess is apt decided to disable your signal and you didnt stop it
> > 
> > An application might install its own SIGILL handler to emulate or trap
> > _other_ instructions.  To do it properly, you have to chain the handlers.
> > 
> > Not sure how to do this, when you get to the stage of two LD_PRELOAD
> > libraries each wanting to overload sigaction.
> 
> That's not (yet) my problem and I think it's not impossible to hook
> them. _But_ before, I need to get called at all _before_ libstdc++5's
> _init(). For now, I haven't managed to do that...

One way to get loaded before anything else is to do ELF binary
loading by hand in userspace.  The kernel exec loads your
program, which sets up trap handlers etc., then loads the actual
target binary by hand.  I did this for an application sandbox.
Writing the loader took less than half a day since I was able to
use a lot of kernel code from binfmt_elf.c directly, just
translating internal kernel calls into open, mmap, etc. system
calls.
-- 
"Note that nobody reads every post in linux-kernel.   In fact, nobody who
 expects to have time left over to  actually do any real kernel work will
 read even half.  Except Alan Cox, but he's actually not human, but about
 a thousand gnomes working in under-ground caves in Swansea." --Linus

