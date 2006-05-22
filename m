Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750935AbWEVP0O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750935AbWEVP0O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 11:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750937AbWEVP0O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 11:26:14 -0400
Received: from nevyn.them.org ([66.93.172.17]:25556 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S1750935AbWEVP0N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 11:26:13 -0400
Date: Mon, 22 May 2006 11:26:08 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Renzo Davoli <renzo@cs.unibo.it>
Cc: Jeff Dike <jdike@addtoit.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andi Kleen <ak@suse.de>, Ulrich Drepper <drepper@gmail.com>,
       osd@cs.unibo.it, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2-ptrace_multi
Message-ID: <20060522152608.GA21869@nevyn.them.org>
Mail-Followup-To: Renzo Davoli <renzo@cs.unibo.it>,
	Jeff Dike <jdike@addtoit.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Andi Kleen <ak@suse.de>, Ulrich Drepper <drepper@gmail.com>,
	osd@cs.unibo.it, linux-kernel@vger.kernel.org
References: <20060518155337.GA17498@cs.unibo.it> <20060519174534.GA22346@cs.unibo.it> <20060519201509.GA13477@nevyn.them.org> <200605192217.30518.ak@suse.de> <1148135825.2085.33.camel@localhost.localdomain> <20060520183020.GC11648@cs.unibo.it> <20060520213959.GA4229@ccure.user-mode-linux.org> <20060521152810.GL15497@cs.unibo.it> <20060522130222.GA16937@nevyn.them.org> <20060522150544.GB11910@cs.unibo.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060522150544.GB11910@cs.unibo.it>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2006 at 05:05:44PM +0200, Renzo Davoli wrote:
> Then it would be inconsistent with ppc64 where it does exist, and ppc64
> has the very same problem.
> So the solution would be to patch also the ppc64 [GS]ETREGS breaking
> compatibility with existing applications. 

Or use new ptrace operations for the full regsets; that is probably
wiser.

> The MULTI proposal was a way to have a fast, simple, safe support.
> Fast: one syscall does all

You've added copy_from_user to several operations which were previously
entirely register-based calling conventions.  In at least some
configurations this will dwarf the cost of the system call trap.

> If you do not find this proposal interesting, I'll continue to support
> it as a specific patch for umview. I am not here to "sell" any solution.
> On the contrary I think it might be useful in many applications.

Well, I'm afraid that I don't find it interesting; and I don't think
GDB would make use of it.

-- 
Daniel Jacobowitz
CodeSourcery
