Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964786AbWBPUFS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964786AbWBPUFS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 15:05:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964895AbWBPUFS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 15:05:18 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:9939 "EHLO lirs02.phys.au.dk")
	by vger.kernel.org with ESMTP id S964786AbWBPUFQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 15:05:16 -0500
Date: Thu, 16 Feb 2006 21:04:43 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Daniel Walker <dwalker@mvista.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Ulrich Drepper <drepper@redhat.com>,
       Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 0/6] lightweight robust futexes: -V3 - Why in userspace?
In-Reply-To: <1140118455.4117.91.camel@laptopd505.fenrus.org>
Message-Id: <Pine.OSF.4.05.10602162057040.20911-100000@da410>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Feb 2006, Arjan van de Ven wrote:

> On Thu, 2006-02-16 at 20:06 +0100, Esben Nielsen wrote:
> > I just jump into a thread somewhere to ask my question :-)
> > 
> > Why does the list have to be in userspace?
> 
> because it's faster ;)
> 
>
Faster??? 
As I see it, extra manipulations have to be done even in the non-congested
case: Every time the lock is taken the locking thread has to add the lock
to a the list, and reversely remove the lock from the list. I.e.
instructions are _added_ to the fast path where you stay purely in
userspace.

I am ofcourse comparing to a solution where you do a syscall on everytime
you do a lock. What I am asking about is whethere it wouldn't be
enough to maintain the list at the FUTEX_WAIT/FUTEX_WAKE operation - i.e.
the slow path where you have to go into the kernel.

Esben


