Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319275AbSIEW6W>; Thu, 5 Sep 2002 18:58:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319273AbSIEW6W>; Thu, 5 Sep 2002 18:58:22 -0400
Received: from crack.them.org ([65.125.64.184]:17157 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S319275AbSIEW6T>;
	Thu, 5 Sep 2002 18:58:19 -0400
Date: Thu, 5 Sep 2002 19:02:50 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] ptrace-fix-2.5.33-A1
Message-ID: <20020905230250.GC14295@nevyn.them.org>
Mail-Followup-To: Ingo Molnar <mingo@elte.hu>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
References: <20020905221558.GA12837@nevyn.them.org> <Pine.LNX.4.44.0209060029200.16108-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209060029200.16108-100000@localhost.localdomain>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2002 at 12:35:22AM +0200, Ingo Molnar wrote:
> 
> there are two kinds of wait4 calls, one that gets the WIFSTOPPED event
> from the debugged task, for this the traced task has to be in the
> debugger's ->children list.
> 
> Another one is when a debugged task exits and its parent wants the exit
> event. But in this case the task is untraced already, so it gets back into
> the parent's ->children list.
> 
> ie. wait4 should only look at the ->children list - zombies (or traced
> tasks debugged by this task) can only be there.
> 
> The only addition is that in the wait4 non-blocking case we need to look
> at the traced list as well - since a non-blocking wait4 is a 'could there
> be any children exiting' kind of query.

OK.  I think that the !list_empty (ptrace_children) isn't really enough
- since there can be things on our children list that we will not wait
for - should we be iterating over it making the same checks we do
above?

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
