Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262215AbUFEWoV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262215AbUFEWoV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 18:44:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262279AbUFEWoV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 18:44:21 -0400
Received: from fw.osdl.org ([65.172.181.6]:12160 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262215AbUFEWoU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 18:44:20 -0400
Date: Sat, 5 Jun 2004 15:44:05 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Robert Love <rml@ximian.com>
cc: Arjan van de Ven <arjanv@redhat.com>, Ulrich Drepper <drepper@redhat.com>,
       Russell Leighton <russ@elegant-software.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: clone() <-> getpid() bug in 2.6?
In-Reply-To: <1086472082.7940.48.camel@localhost>
Message-ID: <Pine.LNX.4.58.0406051540550.7010@ppc970.osdl.org>
References: <40C1E6A9.3010307@elegant-software.com> 
 <Pine.LNX.4.58.0406051341340.7010@ppc970.osdl.org> 
 <20040605205547.GD20716@devserv.devel.redhat.com> 
 <Pine.LNX.4.58.0406051405110.7010@ppc970.osdl.org> <1086472082.7940.48.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 5 Jun 2004, Robert Love wrote:
> 
> Eh, it definitely does, in nptl/sysdeps/unix/sysv/linux/getpid.c:

What a piece of shit.

> A few places, including the fork code, fix it:
> 
> 	/* Adjust the PID field for the new process.  */
> 	THREAD_SETMEM (self, pid, THREAD_GETMEM (self, tid));
> 
> But not direct calls to clone(2).

As mentioned, you can't even "adjust" it in a clone(). It's just _wrong_
to cache _ever_ after a clone(), whether it was cached before or not. You 
can't just re-set the pid information like in a fork().

The whole notion of caching "pid" is sick and idiotic. It has no redeeming 
values.

		Linus
