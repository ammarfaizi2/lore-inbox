Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266584AbTGFBP3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 21:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266586AbTGFBP3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 21:15:29 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:31552 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP id S266584AbTGFBPZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 21:15:25 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: JXrn Engel <joern@wohnheim.fh-wedel.de>, benh@kernel.crashing.org,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <linuxppc-dev@lists.linuxppc.org>, <linuxppc64-dev@lists.linuxppc.org>
Subject: Re: [PATCH 2.5.73] Signal stack fixes #1 introduce PF_SS_ACTIVE
References: <Pine.LNX.4.44.0307041259050.10035-100000@home.osdl.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 05 Jul 2003 19:27:22 -0600
In-Reply-To: <Pine.LNX.4.44.0307041259050.10035-100000@home.osdl.org>
Message-ID: <m1wuewxx51.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Fri, 4 Jul 2003, Jörn Engel wrote:
> > 
> > So some application has it's signal handler on the signal stack and
> > instead of returning to the kernel, it detect where it left off before
> > the signal, mangles the last two stack frames, and goes back directly?
> 
> Yeah, basically a lot of old threading stuff did the equivalent of 
> longjump by hand.
> 
> It is entirely possible that they do not do this out of signal handlers, 
> since that has its own set of problems anyway, and one of the reasons for 
> doing co-operative user level threading is to not need locking, and thus 
> you never want to do any thread switching asynchronously (eg from a signal 
> context).
> 
> So I'm not saying that your patch will necessarily break stuff, I'm just 
> pointing out that it was actually done the way it is done on purpose.

I would have to double check but I am pretty certain dosemu does
this when running dpmi applications.  An alternative stack is setup
for signals so we get a stack we can control, and if we want to
return to dosemu instead of the dpmi application we must change the
stack we return to. 

Eric
