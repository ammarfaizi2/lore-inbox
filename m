Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750759AbWBPWdV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbWBPWdV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 17:33:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750760AbWBPWdV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 17:33:21 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:33247 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S1750759AbWBPWdU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 17:33:20 -0500
Date: Thu, 16 Feb 2006 23:32:47 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Arjan van de Ven <arjan@infradead.org>, Daniel Walker <dwalker@mvista.com>,
       linux-kernel@vger.kernel.org, Ulrich Drepper <drepper@redhat.com>,
       Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 0/6] lightweight robust futexes: -V3 - Why in userspace?
In-Reply-To: <20060216203626.GB21415@elte.hu>
Message-Id: <Pine.OSF.4.05.10602162301050.22107-100000@da410>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 16 Feb 2006, Ingo Molnar wrote:

> [...]
> 
> > I am ofcourse comparing to a solution where you do a syscall on 
> > everytime you do a lock. What I am asking about is whethere it 
> > wouldn't be enough to maintain the list at the FUTEX_WAIT/FUTEX_WAKE 
> > operation - i.e. the slow path where you have to go into the kernel.
> 
> no, that's not enough at all: we need to be able to clean up after 
> futexes even if the kernel was _never involved_ with them. The pure 
> userspace futex fastpath still can keep a lock stuck! In fact that is 
> the common-case.
> 

As I understand the protocol the userspace task writes it's pid into the
lock atomically when locking it and erases it atomically when it leaves
the lock. If it is killed inbetween the pid is still there.
Now if another task comes along it reads the pid, sets the wait flag and goes 
into the kernel. The kernel will now be able to see that the pid is no
longer valid and therefore the owner must be dead. 

Esben

> 	Ingo
> 

