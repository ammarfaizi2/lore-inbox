Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319221AbSIEWsZ>; Thu, 5 Sep 2002 18:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319223AbSIEWsZ>; Thu, 5 Sep 2002 18:48:25 -0400
Received: from crack.them.org ([65.125.64.184]:13573 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S319221AbSIEWsY>;
	Thu, 5 Sep 2002 18:48:24 -0400
Date: Thu, 5 Sep 2002 18:52:57 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] ptrace-fix-2.5.33-A1
Message-ID: <20020905225257.GB14295@nevyn.them.org>
Mail-Followup-To: Ingo Molnar <mingo@elte.hu>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
References: <20020905221558.GA12837@nevyn.them.org> <Pine.LNX.4.44.0209060021360.14643-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209060021360.14643-100000@localhost.localdomain>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2002 at 12:25:32AM +0200, Ingo Molnar wrote:
> > > this splitup of the lists makes it possible for the debugger to do a wait4
> > > that will get events from the debugged task, and for the debugged task to
> > > also be available to the real parent.
> > 
> > Great.  I'm not exactly sure on how this works right now: sys_wait4 only
> > iterates over ->children, with the exception of the special code in
> > TASK_ZOMBIE.  I'm not quite sure when events from a traced process get
> > to the normal parent of that process, or when they're supposed to.
> 
> i'm not sure about this either. What happens if an (untraced) parent has
> traced and untraced children, and does a wait4. Would it confuse the
> debugger if the parent could get one of the traced tasks as a result in
> wait4? And how does the debugger solve this problem?

Not a problem.  The parent never gets an event that is not first
reported to the debugger, via the hook in sys_wait4... A debugger that
runs other processes has to play some games with wait loops in order to
manage its children and its debugees, but that's old news.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
