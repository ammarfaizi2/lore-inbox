Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318766AbSIEWqF>; Thu, 5 Sep 2002 18:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318767AbSIEWqF>; Thu, 5 Sep 2002 18:46:05 -0400
Received: from crack.them.org ([65.125.64.184]:11525 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S318766AbSIEWqE>;
	Thu, 5 Sep 2002 18:46:04 -0400
Date: Thu, 5 Sep 2002 18:50:38 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] ptrace-fix-2.5.33-A1
Message-ID: <20020905225038.GA14295@nevyn.them.org>
Mail-Followup-To: Ingo Molnar <mingo@elte.hu>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
References: <20020905222947.GA13667@nevyn.them.org> <Pine.LNX.4.44.0209060036100.17495-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209060036100.17495-100000@localhost.localdomain>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2002 at 12:39:02AM +0200, Ingo Molnar wrote:
> 
> On Thu, 5 Sep 2002, Daniel Jacobowitz wrote:
> 
> > If we want to do this then we'd need to fix up every ptrace
> > implementation in every architecture to call the appropriate function;
> > it's a separate problem.
> 
> which code relies on having debugged children only in the ->children list
> and not in the ->ptrace_children list?

Every implementation of PTRACE_TRACEME leaves them in the ->children
list.  They are never added to ptrace_children.  Whether this is
_right_ is another question.

> > > i'm not sure about this either. What happens if an (untraced) parent has
> > > traced and untraced children, and does a wait4. Would it confuse the
> > > debugger if the parent could get one of the traced tasks as a result in
> > > wait4? And how does the debugger solve this problem?
> > 
> > Well, it seems to me that when a traced task has an event, it should be
> > reported first to the debugger - for signals this happens in do_signal -
> > and then possibly to the normal parent.  But I'm not sure if this
> > actually happens right now or not.  Worth investigating some more.
> 
> it just cannot happen. There are only two kinds of events passed via
> wait4: tracing related and exit related. An exiting task is not traced
> anymore. And two tasks cannot trace the same task - so it can never happen
> that wait4 wants to look at ->ptrace_children for events.

Oh.  You are, of course, right.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
