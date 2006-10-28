Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932101AbWJ1TrB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101AbWJ1TrB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 15:47:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932106AbWJ1TrB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 15:47:01 -0400
Received: from smtp.osdl.org ([65.172.181.4]:5567 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932101AbWJ1TrA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 15:47:00 -0400
Date: Sat, 28 Oct 2006 12:41:50 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "Adam J. Richter" <adam@yggdrasil.com>
cc: akpm@osdl.org, bunk@stusta.de, greg@kroah.com,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       matthew@wil.cx, pavel@ucw.cz, shemminger@osdl.org
Subject: Re: [patch] drivers: wait for threaded probes between initcall levels
In-Reply-To: <200610280823.k9S8NZ2D004392@freya.yggdrasil.com>
Message-ID: <Pine.LNX.4.64.0610281238460.3849@g5.osdl.org>
References: <200610280823.k9S8NZ2D004392@freya.yggdrasil.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 28 Oct 2006, Adam J. Richter wrote:

> On Fri, 27 Oct 2006 13:42:44 -0700 (PDT), Linus Torvals wrote:
> >        static struct semaphore outstanding;
> [...]
> >        static void allow_parallel(int n)
> [...]
> >        static void wait_for_parallel(int n)
> [...]
> >        static void execute_in_parallel(int (*fn)(void *), void *arg)
> 
> 	This interface would have problems with nesting.

You miss the point.

They _wouldn't_ be nested.

The "allow_parallel()" and "wait_for_parallel()" calls would be at some 
top-level situation (ie initcalls looping).

Nobody else than the top level would _ever_ use them. Anything under that 
level would just say "I want to do this in parallel" - which is just a 
statement, and has no nesting issues in itself.

The whole notion of "I want to do this in parallel" is basically 
non-nesting. If something is parallel, it's by definition not ordered, and 
thus nesting cannot make sense. All the "ordered" stuff would be either 
done without using "execute_in_parallel()" at all, or it would be ordered 
_within_ one thread that is executed in parallel.

		Linus
