Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262738AbTJNSv2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 14:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262351AbTJNSuC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 14:50:02 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:64426 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S263489AbTJNSth
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 14:49:37 -0400
X-AuthUser: davidel@xmailserver.org
Date: Tue, 14 Oct 2003 11:45:34 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Chris Lattner <sabre@nondot.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [x86] Access off the bottom of stack causes a segfault?
In-Reply-To: <Pine.LNX.4.44.0310141358420.4165-100000@nondot.org>
Message-ID: <Pine.LNX.4.56.0310141142440.2098@bigblue.dev.mdolabs.com>
References: <Pine.LNX.4.44.0310141358420.4165-100000@nondot.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Oct 2003, Chris Lattner wrote:

> > > Generated code:
> > >         .intel_syntax
> > > ...
> > > main:
> > >         mov DWORD PTR [%ESP - 16004], %EBP    # Save EBP to stack
> >                          ^^^^^^^^^^^^
> >
> > Yes, this is the problem (even Windows does that IIRC).
>
> Ok, I realize what's going on here.  The question is, why does the linux
> kernel consider this to be a bug?  Where (in the X86 specs) is it
> documented that it's illegal to access off the bottom of the stack?
>
> My compiler does a nice leaf function optimization where it does not even
> bother to adjust the stack for leaf functions, which eliminates the adds
> and subtracts entirely from these (common) functions.  This completely
> invalidates the optimization.
>
> Since I'm going to have to live with lots of preexisting kernels, it looks
> like I'm going to have to disable it entirely, which is disappointing.
> I'm still curious though why this is thought to be illegal.

I don't know, I didn't code it :) I discovered it a few months ago while I
was doing some portable code to measure the maximum stack growth of our
software. I was doing something like:

	memset(%esp - SAFE, 'S', SIZE);

and it was puking on me on both Linux and Windows. An alloca+memset solved
the problem in both environments.



- Davide

